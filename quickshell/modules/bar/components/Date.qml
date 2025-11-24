import QtQuick
import "../../../"
Rectangle {
    id:date
    width: Config.dateWidth 
    height:Config.dateHeight
    radius:Config.radiusAll
    color: Config.background2Color
    z:10
    anchors{
        top:parent.top
        bottom:parent.bottom
        margins:(parent.height-Config.dateHeight)/2
    }
    property var time: new Date()

    Text {
        id:dateText
        anchors.centerIn: parent
        text: parent.time.toLocaleTimeString(Qt.locale(), "dddd MMM d")
        color:Config.textColor 
        font.pixelSize: Config.dateTextSize
        font.bold: true
    }

    Timer {
        interval: 60000; running: true; repeat: true
        onTriggered: parent.time = new Date()
    }
}
