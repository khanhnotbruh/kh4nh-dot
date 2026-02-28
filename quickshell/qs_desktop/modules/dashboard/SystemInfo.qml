import Quickshell
import QtQuick

import "../widgets"
import "../../config"
import "../../services"

Rectangle{
  id:root
  Status{
    width:80
    text:SysInfo.cpuName
    usage:SysInfo.cpuTemp
    accentColor:Config.border.color
  }
}
