pragma singleton
import QtQuick
import QtQuick.Shapes
import "../../config"

Item {
    id: root
    implicitWidth: 100 
    implicitHeight: width
    // required property
    property real usage: 36
    property real maxUsage: 100
    property real startAngle:160   
    property real maxAngle:220
    property string usageUnit:"°C"
    property string text:"empty"
    property color textColor:Config
    property color usageTextColor:
    property color trackColor: 
    property color accentColor:  

    //relative property
    property int strokeWidth:width * 0.1
    property int usageSize:width   * 0.22
    property int textSize:usageSize* 0.5
    property int textOffset:height * 0.1

    anchors.centerIn:parent

    //the shape:
    //use outline as progress bar and capstyle for rounded looking
    Shape{
      anchors.centerIn:parent
      layer.enabled:true
      layer.samples:4
      ShapePath{
        strokeWidth:root.strokeWidth
        strokeColor:root.trackColor
        fillColor:"transparent"
        capStyle: ShapePath.RoundCap

        PathAngleArc{
          centerX:root.width/2;centerY:root.height/2
          radiusX:(root.width/2)-root.strokeWidth
          radiusY:(root.height/2)-root.strokeWidth
          startAngle:root.startAngle;sweepAngle:root.maxAngle
        }
      }
      ShapePath{
        strokeWidth:root.strokeWidth
        strokeColor:root.accentColor
        fillColor:"transparent"
        capStyle: ShapePath.RoundCap

        PathAngleArc{
          id:proportion
          centerX:root.width/2;centerY:root.height/2
          radiusX:(root.width/2)-root.strokeWidth
          radiusY:(root.height/2)-root.strokeWidth
          startAngle:root.startAngle;sweepAngle:(root.usage/root.maxUsage)*root.maxAngle
          Behavior on sweepAngle{NumberAnimation{duration:2000; easing.type: Easing.OutCubic}}
        }
      }
    }
    Column{
      anchors.centerIn:parent
      anchors.verticalCenterOffset: root.textOffset
      spacing:-2
      Text {
        id: usageText
        property real targetValue: root.usage 
        property real animatedValue: 0
        Behavior on animatedValue {NumberAnimation {duration: 2000; easing.type: Easing.OutCubic}}
        onTargetValueChanged: animatedValue = targetValue
        text: Math.round(animatedValue) + root.usageUnit

        color: root.usageTextColor
        font.pixelSize: root.usageSize
        font.weight: Font.DemiBold
        anchors.horizontalCenter: parent.horizontalCenter
      }
      Text{
        text:root.text
        color:root.textColor
        font.pixelSize:root.textSize
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }
  }
