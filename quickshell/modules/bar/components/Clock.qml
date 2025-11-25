import QtQuick
import "../../../"
Rectangle {
    width: Config.clockWidth 
    height:Config.clockHeight
    radius:Config.radiusAll
    color: Config.background2ColorDim
    anchors{
        top:parent.top
        bottom:parent.bottom
        topMargin:(parent.height-Config.clockHeight)/2
        bottomMargin:(parent.height-Config.clockHeight)/2
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
