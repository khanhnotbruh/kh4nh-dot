import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
import "../../config"
import "../../services"
import "../widgets"

PanelWindow {
  id: root

  // --- 1. CONFIG ---
  property int slideDuration: 250
  property int borderThick: Config.border.thickness
  property int rounding: Config.dashboard.rounding
  property int cornerDuration: slideDuration*(rounding/(Screen.height/3))*6
  property int boardWidth: Screen.width / 3
  property color boardColor: Config.border.color

  // --- 2. LOGIC ---
  property bool showing: false
  property int boardHeight: showing ? Screen.height/3:0
  property real topCornerRelativeY: showing ? rounding:0
  Behavior on boardHeight { NumberAnimation { duration: root.slideDuration; easing.type: Easing.BezierSpline } }
  Behavior on topCornerRelativeY { NumberAnimation { duration: root.cornerDuration } }

  property real sideRelHeight: boardHeight - (2 * rounding) - borderThick

  // --- 3. WINDOW SETUP ---
  WlrLayershell.layer: WlrLayer.Top
  exclusiveZone: -1
  focusable: false
  implicitHeight: borderThick + Screen.height / 3
  color: "transparent"

  anchors { left: true; top: true; right: true }
  margins {
    left: (Screen.width / 3) - rounding
    right: (Screen.width / 3) - rounding 
  }
  mask: Region { item: visualContent }

  Shape {
    id: visualContent
    width: parent.width
    height: root.boardHeight + root.borderThick
    layer.enabled: true
    layer.samples: 4
    MouseArea {
      anchors{
        fill:parent
        leftMargin:root.rounding
        rightMargin:root.rounding
      }
      hoverEnabled: true
      onEntered: root.showing = true
      onExited: root.showing = false
    }
    ShapePath {
      startX: 0
      startY: root.borderThick * 1.0
      fillColor: root.boardColor
      strokeColor: "transparent"

      PathArc {
        relativeX: root.rounding
        relativeY: root.topCornerRelativeY
        radiusX: root.rounding
        radiusY: root.rounding
      }

      PathLine {
        relativeX: 0
        relativeY: root.sideRelHeight
      }

      PathArc {
        relativeX: root.rounding
        relativeY: root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
        direction: PathArc.Counterclockwise
      }

      PathLine {
        relativeX: root.boardWidth - (2 * root.rounding)
        relativeY: 0
      }

      PathArc {
        relativeX: root.rounding
        relativeY: -root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
        direction: PathArc.Counterclockwise
      }

      PathLine {
        relativeX: 0
        relativeY: -root.sideRelHeight
      }

      PathArc {
        relativeX: root.rounding
        relativeY: -root.topCornerRelativeY
        radiusX: root.rounding
        radiusY: root.rounding
      }
    }
    SystemInfo{
      opacity:showing?100:0
      Behavior on opacity { NumberAnimation { duration: 400} }
    }
  }
}
