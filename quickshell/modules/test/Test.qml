import QtQuick
import Quickshell
PanelWindow {
  id: topPanel
  anchors { top: true; left: true; right: true }
  height: topPanel.hovered  ? 45 : 5          
  exclusiveZone:topPanel.hovered  ? 40 : 0
  Behavior on height {
      NumberAnimation {
        duration:35
        easing.type: Easing.OutCubic
      }
    }
  property bool hovered: false

  color: "#00000000"  
  MouseArea {
     anchors {
      left: parent.left
      right: parent.right
    }
    height:40
    hoverEnabled: true
    onEntered: topPanel.hovered=true
    onExited: topPanel.hovered=false
  }
  Rectangle {
    id: topBar
    anchors {
      left: parent.left
      right: parent.right
      margins: 5   // gap from screen
    }

    y: topPanel.hovered ? 5 : -40

    Behavior on y {
      NumberAnimation {
        duration: 300
        easing.type: Easing.OutCubic
      }
    }
    height: 35
    radius: 8
    color:"#80050512"
    Row{
      Row {
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter
        Workspace {}
        CurrentWindow {}
      }

          // Right side
      Row {
        spacing: 12
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        CPU {}
        RAM {}
        Clock {}   
      }
    }
  }
}
