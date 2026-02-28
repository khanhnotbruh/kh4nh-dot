import Quickshell
import QtQuick

import "../widgets"
import "../../config"
import "../../services"
FloatingWindow{
  id:root
  height:100
  width:100
  Status{
    width:80
    text:SysInfo.cpuName
    usage:SysInfo.cpuTemp
    accentColor:Config.border.color
  }
}
