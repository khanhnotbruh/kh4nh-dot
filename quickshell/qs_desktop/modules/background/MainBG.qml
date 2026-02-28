import QtQuick
import Quickshell
import Quickshell.Wayland
PanelWindow {
  id:main
  anchors { 
    top: true 
    left: true 
    right: true 
    bottom:true 
  }
  visible:true
  color:"transparent"

  // ---- layer-shell ----
  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
  WlrLayershell.exclusiveZone: -1
  Item {
    id: scene
    anchors.fill: parent
    Wallpaper{}
    Border{}
  }
}

