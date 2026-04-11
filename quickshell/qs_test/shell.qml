import Quickshell
import QtQuick
import QtQuick.Controls

FloatingWindow {

  id: window
  visible: true
  color: "#333"


  MouseArea {
    id: dragArea
    anchors.fill: parent
    drag.target: drawer
    drag.axis: Drag.YAxis
    drag.minimumY: 0
    drag.maximumY: window.height

    // Snapping Logic when released
    onReleased: {
      if (drawer.y > window.height * 0.3) {
        snapClose.start()
      } else {
        snapOpen.start()
      }
    }
  }
  Rectangle {
    id: drawer
    width: parent.width
    height: parent.height
    y: window.height
    color: "#1a1a1a"
    radius: 25
    Rectangle {
      width: 40; height: 5
      radius: 3
      color: "#555"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 12
    }
    Column {
      anchors.centerIn: parent
      spacing: 20
      Button { 
        text: "Close Panel" 
        onClicked: snapClose.start() 
      }
      Text { 
        text: "Drag me down to close!" 
        color: "white"
        font.pixelSize: 18 
      }
    }
  }

  NumberAnimation { 
    id: snapOpen 
    target: drawer 
    property: "y" 
    to: 0 
    duration: 250; 
    easing.type: Easing.OutCubic
  }
  NumberAnimation { 
    id: snapClose
    target: drawer 
    property: "y" 
    to: window.height 
    duration: 250 
    easing.type: Easing.OutCubic
  }
}
