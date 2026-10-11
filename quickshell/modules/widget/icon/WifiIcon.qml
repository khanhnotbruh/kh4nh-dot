import Quickshell
import QtQuick
import QtQuick.Shapes
Item{
  id:root
  implicitWidth: 100 
  implicitHeight: implicitWidth
  property int percent:46
  property int stroke_width:10
  property int start_angle:-180
  property int sweep_angle:90
  property int spacing:5
  property int layers:3
  property color inner_color:"red"
  property color background_color:"yellow"
  width: root.width
  height: root.height
  anchors.centerIn: parent

  Shape{
    anchors.fill:parent
    ShapePath{
      strokeWidth:-1
      fillColor:root.inner_color
      PathAngleArc {
        centerX:root.width/2
        centerY:root.height-root.stroke_width/2
        radiusX:root.stroke_width/2
        radiusY:root.stroke_width/2
        startAngle: 0
        sweepAngle: 360
      }
    }
  }

  Repeater{
    model:root.layers-1
    Shape{
      required property int index
      anchors.fill: parent
      ShapePath{
        capStyle: ShapePath.RoundCap
        property real factor:Math.max(root.percent-(100/root.layers)*index,0)/100
        strokeColor: Qt.rgba(
          root.background_color.r+factor*(root.inner_color.r-root.background_color.r),
          root.background_color.g+factor*(root.inner_color.g-root.background_color.g),
          root.background_color.b+factor*(root.inner_color.b-root.background_color.b),
          root.background_color.a+factor*(root.inner_color.a-root.background_color.a)
        )
        strokeWidth:root.stroke_width
        fillColor:"transparent"
        PathAngleArc{
          centerX:root.width/2
          centerY:root.height-root.stroke_width/2
          property real cradius:root.stroke_width+root.spacing+(root.spacing+root.stroke_width)*index
          radiusX:cradius
          radiusY:cradius
          startAngle: (root.start_angle-root.sweep_angle)/2
          sweepAngle: root.sweep_angle
        }
      }
    }
  }
}
