import QtQuick
import Quickshell
import Quickshell.Io
Item{
  id: root
  property int value:100
  property Process brightProc: Process {
    command: ["brightnessctl", "set", root.value + "%"]
    running: false
  }
  property IpcHandler ipc:IpcHandler {
    target: "brightness"
    function setVal(percent:int):void { 
      root.value=Math.min(100,Math.max(0,percent));
      root.brightProc.running=true;
    }
    function getVal():int { return root.value }
  }
}
