pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: sys
    //---------------------gpu stuff-----------------------//
    property string activeCard: "card1" 
    property string gpuName:""
    property real gpuTemp: 0
    property real gpuUsage: 0

    Process {
        id: checkGpuInfo
        command: ["sh", "-c", "grep -l '0x8086' /sys/class/drm/card*/device/vendor | head -n 1 | cut -d'/' -f5 ;lspci -mm |grep -i 'vga\|display'|awk -F'\"' '{print $6}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                let result = this.text.trim().split('\n');
                if (result[0] !== "") {
                    sys.activeCard = result[0];
                }
                sys.gpuName=result[1];
            }
        }
    }
    Process {
        id: gpuUsageProc
        command: ["sh", "-c", `cat /sys/class/drm/${sys.activeCard}/gt_cur_freq_mhz && cat /sys/class/drm/${sys.activeCard}/gt_max_freq_mhz`]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.trim().split("\n");
                if (lines.length >= 2) {
                    let cur = parseInt(lines[0]);
                    let max = parseInt(lines[1]);
                    if (max > 0) sys.gpuUsage = ((cur / max)*100);
                }
            }
        }
    }
    Process {
        id: gpuTempProc
        command: ["sh", "-c", "sensors -u | grep -A 1 'Package id 0' | grep 'temp1_input' | awk '{print $2}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                let mC = parseInt(this.text.trim());
                if (!isNaN(mC)) sys.gpuTemp = mC;
            }
        }
    }
    //---------------------cpu stuff-----------------------//
    property string cpuName:""
    property real cpuTemp:0
    property real cpuUsage:0
    Process{
      id:cpuInfo
      // Fixed: Used backticks and double backslashes for the sed regex
      command:["sh","-c", `cat /proc/cpuinfo | grep -m 1 'model name' | sed -E 's/.*Core\\([^)]*\\) +([A-Za-z0-9-]+).*/\\1/'`]
      stdout: StdioCollector{
        onStreamFinished:{
          sys.cpuName=this.text.trim()
        }
      }
    }
    Process{
      id:cpuTempProc
      // Fixed: Used backticks so the double quotes around temp1_input don't break the string
      command: ["sh", "-c", `sensors -u | awk '/coretemp-isa-0000/,/temp1_input/ {if ($1 == "temp1_input:") print $2}'`]
      stdout:StdioCollector{
        onStreamFinished:{
          sys.cpuTemp=parseFloat(this.text.trim())
        }
      }
    }
    Process {
      id: cpuUsageProc
      command: ["sh", "-c", "grep 'cpu ' /proc/stat | awk '{print ($2+$4)*100/($2+$4+$5)}'"]
      stdout: StdioCollector {
        onStreamFinished: {
          let val = parseFloat(this.text.trim());
          if (!isNaN(val)) {
            sys.cpuUsage = val; 
          }
        }
      }
    }
    Timer {
      id: pollingTimer
        interval: 500
        repeat: true
        onTriggered: {
            gpuUsageProc.running=true;
            gpuTempProc.running=true;
            cpuUsageProc.running=true;
            cpuTempProc.running=true;
        }
    }
    Component.onCompleted: {
        checkGpuInfo.running=true;
        cpuInfo.running=true;
        pollingTimer.start();
    }
}
