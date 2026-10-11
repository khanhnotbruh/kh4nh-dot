import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam
import QtQuick
import QtQuick.Controls

import "root:/services"
Item{
  id:root
  property bool locking:false
  WlSessionLock {
    id: lock
    locked:root.locking
    WlSessionLockSurface {
      PamContext {
        id: pam
        config: "lock_screen.conf"
        onResponseRequiredChanged: {
          if (responseRequired && password.text !== "")
          pam.respond(password.text)
        }
        onCompleted: result => {
          if (result === PamResult.Success) {
            context.text="Authenticated successfully"
            fadeOutAnim.restart()
            return
          } else if(result===PamResult.Failed){
            context.text="Authentication failed"
          }
          password.clear()
          password.forceActiveFocus()
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
        anchors.fill: parent
        opacity: 1.0
        Rectangle {
          z:1
          id:background
          anchors.fill: parent
          color: "black"
          opacity:1.0
          NumberAnimation {
            id: fadeOutAnim
            target: background
            property: "opacity"
            from:background.opacity
            running: false
            to: 0.0
            duration: 500
            onFinished: {
              Services.lock_screen.ipc.setVal(false)
              root.locking=false
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
              text:pam.active?"Authenticating...":"Locked"
              color: "white"
              anchors.horizontalCenter: parent.horizontalCenter
            }
            TextField {
              id: password
              focus: true
              echoMode: TextInput.Password
              placeholderText: "Password"
              enabled: !pam.active
              anchors.horizontalCenter: parent.horizontalCenter
              onAccepted: {
                if(text !==""&&!pam.active)
                pam.start()
              }
            }
          }
          Component.onCompleted: password.forceActiveFocus()
        }
      }
    }
  }
  property string currentTime: ""
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
  Connections{
    target:Services.lock_screen
    function onLockRequested() {
      Services.screen.shot.ipc.take()//take screenshot
    }
  }
  Connections{
    target:Services.screen.shot
    function onProcFinished(){
      root.locking=true
    }
  }
}
