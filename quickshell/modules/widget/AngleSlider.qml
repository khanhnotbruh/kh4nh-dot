import QtQuick
import QtQuick.Shapes

Item{
  id:root
  property int length:300
  property int thickness:100
  property int cap_style: ShapePath.RoundCap
  property QtObject anim:QtObject{
    property int duration:250
    property int ease_type:Easing.OutQuad
    property NumberAnimation animator: NumberAnimation {
      duration:anim.duration
      easing.type:anim.ease_type
    }
  }
  property bool enable_mouse:true
  property real percent:0.001
  property real angle:-90.0
  property color foreground_color:"#242424"
  property color background_color:"#363636"
  default property alias extra:shape.data
  signal moved()
  property real sx:0
  property real sy:0
  property real ex:0
  property real ey:0
  implicitWidth:0
  implicitHeight:0
  Component.onCompleted: {
    let track=root.length-root.thickness
    if(track<=0){
      console.error("FATAL ERROR (AngleSlider): 'length' ("+root.length+ 
      ") must be strictly greater than 'thickness' ("+root.thickness+")!")
      return
    }
    let rad=root.angle*(Math.PI/180)
    let sinR=Math.sin(rad),cosR=Math.cos(rad)  
    let asinR=Math.abs(sinR),acosR=Math.abs(cosR)
    root.implicitWidth= track*acosR+thickness
    root.implicitHeight=track*asinR+thickness
    let cx=width/2,cy=height/2
    let ox=cosR*track/2.0,oy=sinR*track/2.0
    root.sx=cx-ox;root.sy=cy-oy
    root.ex=cx+ox;root.ey=cy+oy
    // root.angle=Math.min(root.angle,0.001); 0 for dissappear
  }
  // Behavior on percent {
  //   animation:root.anim.animator
  // }
  // Rectangle{
  //   anchors.fill:parent
  //   color:"white"
  // }
  MouseArea{
    id:area
    acceptedButtons:Qt.LeftButton
    anchors.fill: parent
    preventStealing: true
    enabled:root.enable_mouse
    function updateValue(mouse){
      let dsx=mouse.x-root.sx,dsy=mouse.y-root.sy
      let dex=mouse.x-root.ex,dey=mouse.y-root.ey
      let vx=root.ex-root.sx,vy=root.ey-root.sy
      let d1=dsx*dsx+dsy*dsy,d2=dex*dex+dey*dey
      let tol=vx*vx+vy*vy
      if (d2>tol+d1){
        root.percent=0.001
        root.moved()
        return
      }
      if(d1>tol+d2){
        root.percent=1.001
        root.moved()
        return
      }
      root.percent=Math.max(Math.min(1.001,(d1-d2+tol)/(2*tol)),0.001)
      root.moved()
    }
    onPressed:mouse=>updateValue(mouse)
    onPositionChanged:mouse=>updateValue(mouse)
  }
  Shape{
    id:shape
    anchors.fill:parent
    ShapePath {
      strokeWidth: root.thickness
      strokeColor: root.background_color
      fillColor: "transparent"
      capStyle: root.cap_style
      startX:root.sx
      startY:root.sy
      PathLine {
        x:root.ex
        y:root.ey
      }
    }
    ShapePath {
      strokeWidth: root.thickness
      strokeColor: root.foreground_color
      fillColor: "transparent"
      capStyle: root.cap_style

      startX:root.sx
      startY:root.sy
      PathLine {
        x:root.sx+root.percent*(root.ex-root.sx)
        y:root.sy+root.percent*(root.ey-root.sy)
      }
    }
  }
}
