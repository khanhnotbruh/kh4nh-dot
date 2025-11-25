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
    property int drawerAnimation: 150
    property int drawerWidth: 100
    property int drawerHeight
    property int drawerMargins
    property int buttonWidth: 40
    property int contentWidth: 40
    property bool hovered: drawerMouse.containsMouse
    property bool drawerLeft: false

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: drawer.drawerLeft ? parent.left : undefined
        right: drawer.drawerLeft ? undefined : parent.right
        margins:(parent.height-drawer.drawerHeight)/2  
    }

    Behavior on width { NumberAnimation { duration: drawer.drawerAnimation; easing.type: Easing.OutQuad } }

    width: drawer.hovered ? drawer.drawerWidth+3*drawer.drawerMargins : drawer.buttonWidth+2*drawer.drawerMargins
    color:Config.backgroundColor 
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
        z:9
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
                visible:drawer.width>(drawer.contentWidth+drawer.buttonWidth)/3*2?1:0
                Behavior on visible { NumberAnimation { duration: drawer.drawerAnimation; easing.type: Easing.OutQuad } }
                sourceComponent: drawer.drawerContent
            }
        }
    }

    //--------- button ------------
    Rectangle {
        id: buttonContainer
        z:10
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
