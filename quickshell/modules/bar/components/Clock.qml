import QtQuick
import "../../../"
Rectangle {
    width: Config.clockWidth 
    height:Config.clockHeight
    radius:Config.radiusAll
    color: Config.background2Color
    z:10
    anchors{
        top:parent.top
        bottom:parent.bottom
        margins:(parent.height-Config.clockHeight)/2
    }

    Text {
        id:clockText
        anchors.centerIn: parent
        text: Time.timeString
        color:Config.textColor 
        font.pixelSize: Config.clockTextSize
        font.bold: true
    }
}
