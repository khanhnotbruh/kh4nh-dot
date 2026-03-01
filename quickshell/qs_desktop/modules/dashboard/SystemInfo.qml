import Quickshell
import QtQuick
import QtQuick.Layouts

import "../widgets"
import "../../config"
import "../../services"
Item{
  id:root
  anchors.fill:parent
  property int sysWidth:200
  property int sysHeight:100
  RowLayout{
    anchors.centerIn:parent
    ColumnLayout{
      Rectangle{
        color:"#51332410"
        height:root.sysHeight
        width:root.sysWidth
        radius:20
        RowLayout{
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:SysInfo.cpuName
            usage:SysInfo.cpuTemp
          }
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:SysInfo.cpuName
            usage:SysInfo.cpuTemp
          }
        }
      }
      Rectangle{
        color:"#51332410"
        height:root.sysHeight
        width:root.sysWidth
        radius:20
        RowLayout{
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:SysInfo.cpuName
            usage:SysInfo.cpuTemp
          }
          Status{
            anchors{
              top:parent.top
              topMargin:10
            }
            text:SysInfo.cpuName
            usage:SysInfo.cpuTemp
          }
        }
      }
    }
    Rectangle{
      color:"#51332410"
      height:root.sysWidth
      width:root.sysHeight
      Layout.fillHeight: true
      radius:20
      ColumnLayout{
        Status{
          Layout.fillHeight: true
          text:SysInfo.cpuName
          usage:SysInfo.cpuTemp
        }
        Status{
          Layout.fillHeight: true
          text:SysInfo.cpuName
          usage:SysInfo.cpuTemp
        }
      }
    }
  }
}
