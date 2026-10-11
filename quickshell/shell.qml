import QtQuick
import Quickshell

import "config"
import "services"
import "modules/widget"
import "modules/widget/icon"
import "modules/control_center"
import "modules/lock_screen"
ShellRoot{
  id:root
  Component.onCompleted: {
    Services;
    Config;
  }
  DropDown{}
  LockScreen{}
  // FloatingWindow{
  // }
}
