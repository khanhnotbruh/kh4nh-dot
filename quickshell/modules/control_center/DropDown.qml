import QtQuick
import Quickshell
import Quickshell.Wayland

import "root:/services"
import "root:/config"
PanelWindow {
  id: root
  anchors {
    top: true
    left: true
    right: true
  }
  property bool is_open:Services.control_center.is_open
  implicitHeight: Screen.height
  exclusiveZone: -1
  color: "transparent"
  WlrLayershell.layer: WlrLayer.Top
  mask:Region{
    item:tab
  }
  Rectangle{
    id:tab
    opacity:Config.control_center.background_opacity
    width: parent.width
    height: parent.height
    color:Config.control_center.background_color
    y:root.is_open?0:-root.height
    Behavior on y {
      NumberAnimation {
        duration: 1000
        easing.type: Easing.OutCubic
      }
    }
    Text {
      anchors.centerIn: parent
      text: "6969"
      font {
        family: "Anurati"
        pixelSize: 20
        // italic: true
        // weight: Font.Bold
      }
      color: "#cdd6f4"
    }
  }
}
