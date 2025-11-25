import QtQuick
import "../../../"
Rectangle {
    width: Config.dateWidth 
    height:Config.dateHeight
    radius:Config.radiusAll
    color: Config.background2ColorDim
    anchors{
        top:parent.top
        bottom:parent.bottom
        topMargin:(parent.height-Config.clockHeight)/2
        bottomMargin:(parent.height-Config.clockHeight)/2
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
