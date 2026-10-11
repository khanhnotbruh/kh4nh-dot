import Quickshell
import QtQuick
import QtQuick.Shapes
import "../"
Item{
  id:root
  property int size:500
  property int space:root.size/6
  property real percent:0
  property color foreground_color:"#242424"
  property color background_color:"#363636"
  // Behavior on percent {
  //   animation:root.anim.animator
  // }
  property QtObject center:QtObject{
    property int stroke_width:root.size/50
    property int cap_style: ShapePath.RoundCap
    property int max_radius:root.size/10
    property int min_radius:root.size/13
    property int radius:min_radius+(max_radius-min_radius)*percent
    property color fill_color:"transparent"
    property color stroke_color:"#242424"
  }
  property QtObject beam:QtObject{
    property int cap_style: ShapePath.RoundCap
    property int count:8
    property int width:root.center.stroke_width
    property real length:root.cx-root.center.radius-root.space
    property color foreground_color:root.foreground_color
    property color background_color:"transparent"
  }
  property QtObject anim:QtObject{
    property int duration:250
    property int ease_type:Easing.OutQuad
    property NumberAnimation animator: NumberAnimation {
      duration:anim.duration
      easing.type:anim.ease_type
    }
  }
  default property alias extra:shape.data
  implicitWidth: root.size
  implicitHeight:root.size
  readonly property real cx:root.size/2
  readonly property real cy:root.size/2
  Shape{
    id:shape
    anchors.fill: parent
    ShapePath{
      strokeWidth:root.center.stroke_width
      strokeColor:root.center.stroke_color
      fillColor:root.center.fill_color
      capStyle: root.center.cap_style
      PathAngleArc{
        centerX:root.cx;centerY:root.cy
        radiusX:root.center.radius;radiusY:root.center.radius
        startAngle:0;sweepAngle:360
      }
    }
  }
  Repeater{
    model:root.beam.count
    AngleSlider{
      required property int index
      property real cangle:index*(2*Math.PI/root.beam.count)
      enable_mouse:false
      x:root.cx+(root.center.radius+root.space+root.center.stroke_width)*Math.cos(cangle)-width/2.0
      y:root.cy+(root.center.radius+root.space+root.center.stroke_width)*Math.sin(cangle)-height/2.0
      length:beam.length
      thickness:beam.width
      background_color:root.beam.background_color
      foreground_color:root.beam.foreground_color
      angle:cangle*(180/Math.PI)
      percent:root.percent
    }
  }
}
