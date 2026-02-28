import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam

WlSessionLock {
  id: lock
  property bool checking: false
  locked: true

  WlSessionLockSurface {
    Rectangle {
      color: "black"
      anchors.fill: parent
      Component.onCompleted: passwordIn.forceActiveFocus()

      PamContext {
        id: pam
        onCompleted: (result) => {
          lock.checking = false;
          if (result === PamResult.Success) {
            lock.locked = false;
            Qt.callLater(Qt.quit);
          } else {
            passwordIn.text = "";
            passwordIn.forceActiveFocus();
          }
        }
        onResponseRequiredChanged: {
          if (responseRequired && passwordIn.text !== "") {
            lock.checking = true;
            pam.respond(passwordIn.text);
          }
        }
      }

      Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
          text: "Locked"
          color: "white"
          font.pixelSize: 24
          anchors.horizontalCenter: parent
        }

        TextField {
          id: passwordIn
          readOnly: lock.checking
          implicitWidth: 200 
          echoMode: TextInput.Password
          padding: 5
          focus: true
          placeholderText: "Password..."
          palette.placeholderText: "white"
          color: "white"
          onAccepted: unlockButton.unlock()

          background: Rectangle {
            color: "#223"
            border.color: passwordIn.activeFocus ? "cyan" : "gray"
            border.width: 1
            radius: 8
            Rectangle {
              color: "#343"
              anchors.fill: parent
              anchors.margins: -2
              radius: parent.radius + 2
              visible: lock.checking

              SequentialAnimation on opacity {
                running: lock.checking
                loops: Animation.Infinite
                NumberAnimation { from: 0.2; to: 0.8; duration: 600; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 0.8; to: 0.2; duration: 600; easing.type: Easing.InOutQuad }
              }
            }
          }
        }

        Rectangle {
          id: unlockButton
          width: 100; height: 40
          anchors.horizontalCenter: parent
          radius: 20
          color: mouse.pressed ? "#444" : "#333"

          function unlock() {
            if (passwordIn.text === "" || lock.checking) return;
            if (!pam.active) {
              pam.start(); 
            }
            pam.respond(passwordIn.text);
          }

          Text {
            anchors.centerIn: parent
            text: "Unlock"
            color: "white"
          }

          MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: unlockButton.unlock()
          }
        }

        Text {
          text: lock.checking ? "Authenticating..." : 
          (pam.completed === PamResult.Success ? "Welcome!" : 
          (pam.message || "Enter password"))

          color: pam.messageIsError ? "#ff5555" : "gray"
          font.pixelSize: 12
          anchors.horizontalCenter: parent
        }
      }
    }
  }
}
