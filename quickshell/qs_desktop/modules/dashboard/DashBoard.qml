import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PanelWindow {
  id: root
  anchors { 
    top: true 
    left: true 
    right: true 
    bottom:true 
  }
  property int velocityThreshold:60
  property int dragThreshold:300

  WlrLayershell.layer: WlrLayer.Top
  exclusiveZone: -1
  color: "transparent"
  mask: Region { item: drawer }
  Rectangle {
    anchors.fill: parent
    color: drawer.color
    opacity:1-(-drawer.y/root.height)
    visible: opacity > 0
  }
  Rectangle{
    id:drawer
    height:root.height
    property real openY:0
    property real closeY:-drawer.height+ handle.height
    color:"#2B2D420f"
    anchors{
      left:parent.left
      right:parent.right
    }
    y:closeY
    Behavior on y{
      id:yBehavior
      enabled:drawer.height>0
      NumberAnimation{
        duration: 250
      }
    }
    // the gray handle
    Rectangle {
      id:handle
      width: 150; height: 8
      radius: 15
      color: "gray"
      anchors{
        horizontalCenter: parent.horizontalCenter
        bottom:parent.bottom
      }
    }
    MouseArea{
      property var startTime:0
      property real startY:0

      onPressed:(mouse)=>{
        startY=mouse.y;
        startTime=Date.now();
      }
      anchors.fill:parent
      drag.target: drawer
      drag.axis: Drag.YAxis
      drag.minimumY: root.closedY
      drag.maximumY: root.openY
      onReleased:(mouse)=> {
        let velocity=((mouse.y-startY)/(Date.now()-startTime))*1000;
        if (velocity<=-root.velocityThreshold || drawer.y< -root.dragThreshold) {
          drawer.y=drawer.closeY;
        }else if(velocity>=root.velocityThreshold || drawer.y>= -(root.height-root.dragThreshold)){
          drawer.y=drawer.openY;
        }else {
          drawer.y=drawer.closeY;
        }
      }
    }
  }
}
