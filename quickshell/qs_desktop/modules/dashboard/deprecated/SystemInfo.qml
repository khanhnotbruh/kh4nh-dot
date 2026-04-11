import Quickshell
import QtQuick
import QtQuick.Layouts

import "../widgets"
import "../../config"
import "../../services"
Item{
  id:root
  anchors.fill:parent
  property int sysWidth:210
  property int sysHeight:100
  property int spacing:10
  property int rounding:10
  RowLayout{
    anchors.centerIn:parent
    ColumnLayout{
      Rectangle{
        color:"#51332410"
        height:root.sysHeight
        width:root.sysWidth
        radius:root.rounding
        RowLayout{
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:"CPU"
            usage:SysInfo.cpuTemp
            usageUnit:"°C"
          }
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:"CPU"
            usage:SysInfo.cpuUsage
            usageUnit:"%"
          }
        }
      }
      Rectangle{
        color:"#51332410"
        height:root.sysHeight
        width:root.sysWidth
        radius:root.rounding
        RowLayout{
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:"GPU"
            usage:SysInfo.gpuTemp
            usageUnit:"°C"
          }
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:"GPU"
            usage:SysInfo.gpuUsage
            usageUnit:"%"
          }
        }
      }
    }
    Rectangle{
      color:"#51332410"
      height:root.sysWidth
      width:root.sysHeight
      Layout.fillHeight: true
      radius:root.rounding
      ColumnLayout{
        Status{
          anchors{
            top:parent.top
            topMargin:10
          }
          text:"RAM"
          usage:SysInfo.ramUsage
          usageUnit:"%"
        }
        Status{
          anchors{
            bottom:parent.bottom
            bottomMargin:-10
          }
          text:"Disk"
          usage:SysInfo.diskUsage
          usageUnit:"%"
        }
      }
    }
  }
}
