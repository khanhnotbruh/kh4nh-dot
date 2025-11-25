import QtQuick 6.5
import QtQuick.Window 6.5
import QtQuick.Controls 6.5
import"components"

Window {
    id: mainWindow
    width: 600
    height: 500
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint
    visible: true
    title: "BubbleToy"
    Rectangle {
        anchors.fill: parent
        color: "#0C0C16"
        opacity: 0.2 
        border.color: "#333"
        border.width: 1
        radius: 10
    }
    Rectangle {
        width: 20
        height: 20
        color: "#ff4444"
        radius: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
        z: 99
        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.close()
        }
        Text {
            anchors.centerIn: parent
            text: "x"
            color: "white"
        }
    }
    Loader {
        source: "Bubble.qml"
        x: 100
        y: 100
        onLoaded: {
            item.bubbleColor = "#00C8FF"
            item.diameter = 80
        }
    }
}
