//color0: #80050512
//color3: #313244
//foreground: #fface6f3
import QtQuick
import Quickshell
import "../../"

Rectangle {
    id: drawer
    property Component drawerButton
    property Component drawerContent
    property int drawerWidth: 100
    property int buttonWidth: 40
    property int contentWidth: 40
    property bool hovered: drawerMouse.containsMouse
    property bool drawerLeft: false

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: drawer.drawerLeft ? parent.left : undefined
        right: drawer.drawerLeft ? undefined : parent.right
        margins:5 
    }

    Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }

    width: drawer.hovered ? drawer.drawerWidth : drawer.buttonWidth
    color: "#80050512"
    radius:Config.radiusAll
    z: 2 

    MouseArea {
        id: drawerMouse
        anchors.fill: parent
        hoverEnabled: true
    }

    //--------- content ------------
    Rectangle {
        id:contentContainer
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: drawer.drawerLeft ? undefined : parent.left
            right: drawer.drawerLeft ? parent.right : undefined
            margins:2 
        }

        width: drawer.hovered ? (drawer.drawerWidth - drawer.buttonWidth) : 0

        color:"transparent" 
        radius: Config.radiusAll
        clip: true 

        Item {
            anchors.fill: parent
            Loader {
                anchors {
                top: parent.top
                bottom: parent.bottom
                left: drawer.drawerLeft ? undefined : parent.left
                right: drawer.drawerLeft ? parent.right : undefined
                }
                sourceComponent: drawer.drawerContent
            }
        }
    }

    //--------- button ------------
    Rectangle {
        id: buttonContainer
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: drawer.drawerLeft ? undefined : parent.right
            left: drawer.drawerLeft ? parent.left : undefined
            margins:2 
        }

        width: drawer.buttonWidth
        color: "transparent"
        radius: Config.radiusAll

        Loader {
            id: buttonLoader
            anchors.centerIn: parent
            sourceComponent: drawer.drawerButton
        }
    }
}
