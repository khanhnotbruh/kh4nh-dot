import QtQuick
import QtQuick.Shapes

Item {
    id: root
    
    // Data Properties
    property real gpuTemp: 36
    property real gpuUsage: 4
    property real maxTemp: 100
    
    property color trackColor: "#F5E6E2"    // Light background ring
    property color accentColor: "#7D4E44"   // Dark brown/red from image
    property int strokeWidth: 10
    anchors.centerIn:parent
    height:80
    width:80

    Shape{
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
          startAngle:0;sweepAngle:360
        }
      }
      ShapePath{
        strokeWidth:root.strokeWidth
        strokeColor:root.accentColor
        fillColor:"transparent"
        capStyle: ShapePath.RoundCap

        PathAngleArc{
          centerX:root.width/2;centerY:root.height/2
          radiusX:(root.width/2)-root.strokeWidth
          radiusY:(root.height/2)-root.strokeWidth
          startAngle:60;sweepAngle:(root.gpuTemp/root.maxTemp)*120
        }
      }
    }
  }
