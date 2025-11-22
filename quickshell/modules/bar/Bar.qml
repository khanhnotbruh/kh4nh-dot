import QtQuick
import Quickshell
import Quickshell.Io 
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: topPanel
    anchors { top: true; left: true; right: true }
    implicitHeight: topPanel.hovered  ? 55 : 5          
    exclusiveZone: 0
    Behavior on height {
        NumberAnimation {
            duration:100
            easing.type: Easing.OutCubic
        }
    }
    property bool hovered: false

    color: "transparent"  
    MouseArea {
        anchors {
            left: parent.left
            right: parent.right
        }
        height:55
        hoverEnabled: true
        onEntered: topPanel.hovered=true
        onExited: topPanel.hovered=false
    }
    Rectangle {
        id: topBar
        anchors {
            left: parent.left
            right: parent.right
            margins: 100   // gap from screen
        }

        y: topPanel.hovered ? 20 : -40

        Behavior on y {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutCubic
            }
        }
        height: 35
        radius: 20
        color:"#80050512"
    }
}
