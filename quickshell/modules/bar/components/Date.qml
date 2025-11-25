import QtQuick
import "../../../"
Rectangle {
    width: Config.dateWidth 
    height:Config.dateHeight
    radius:Config.radiusAll
    color: Config.background2Color
    z:9
    anchors{
        top:parent.top
        bottom:parent.bottom
        margins:(parent.height-Config.dateHeight)/2
    }

    Text {
        id:dateText
        anchors.centerIn: parent
        text: Time.dateString
        color:Config.textColor 
        font.pixelSize: Config.dateTextSize
        font.bold: true
    }
}
