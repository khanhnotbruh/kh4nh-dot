import Quickshell
import QtQuick
import QtQuick.Controls

import "root:/services"
Item{
  id:root
  property var parent_context
  property var pam_context
  property string currentTime: ""
  anchors.fill:parent
  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      let date = new Date()
      let hours = String(date.getHours()).padStart(2, '0')
      let minutes = String(date.getMinutes()).padStart(2, '0')
      let seconds = String(date.getSeconds()).padStart(2, '0')
      currentTime = `${hours}:${minutes}:${seconds}`
    }
  }
  Image{
    z:0
    id:img
    anchors.fill: parent
    fillMode: Image.PreserveAspectFit
    source:Services.screen.shot.ipc.getPath()
  }
  Item{
    id:place_holder
    anchors.fill: parent
    opacity: 1.0
    Rectangle {
      id:background
      anchors.fill: parent
      color: "black"
      opacity:1.0
      NumberAnimation {
        id: fadeAnim
        target: background
        property: "opacity"
        from:background.opacity
        running: false
        to: 0.0
        duration: 500
        onFinished: {
          Services.lock_screen.ipc.setVal(false)
          root.parent_context.locking=false
        }
      }
      Column {
        anchors.centerIn: parent
        spacing: 12
        Text {
          text: root.currentTime
          color: "white"
          font.pixelSize: 32
          anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
          id:context
          text:root.parent_contex.context
          color: "white"
          anchors.horizontalCenter: parent.horizontalCenter
        }
        TextField {
          id: password
          focus: true
          echoMode: TextInput.Password
          placeholderText: "Password"
          enabled: !root.pam_context.active
          anchors.horizontalCenter: parent.horizontalCenter
          onAccepted: {
            if(text!==""&&!root.pam_context.active){
              root.parent_context.pending=text
              root.pam_context.start()
            }
          }
        }
      }
      Component.onCompleted: password.forceActiveFocus()
    }
  }
}
