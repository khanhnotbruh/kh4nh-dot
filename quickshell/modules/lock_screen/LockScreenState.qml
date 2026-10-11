pragma singleton
import QtQuick
import Quickshell
import Quickshell.Io
QtObject{
  property bool locked:false
  property var pam:pam
  PamContext {
    id: pam
    config: "lock_screen.conf"
  }

}
