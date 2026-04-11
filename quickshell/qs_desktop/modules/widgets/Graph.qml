import Quickshell
import QtQuick
import QtQuick.Shapes

Item{
  id: root
  implicitHeight: 100
  implicitWidth: implicitHeight*3 
  anchors.centerIn:parent
  property color backgroundColor:"#11111b"
  property color gridColor:"blue"
  property color fillColor:"#87b2fabf"
  property color strokeColor:"#86b2d0"
  property int maxCol:10
  property int maxRow:5
  property int gridStrokeWidth:1
  property int graphStokeWidth:2
  Rectangle{anchors.fill:parent;color:root.backgroundColor}
  Shape {
    id: shape
    anchors.fill: parent
    layer.enabled: true
    layer.samples: 4
    property var points: [0] 
    property real stepX: root.implicitWidth / root.maxCol
    property real stepY:root.implicitHeight/root.maxRow
    Component.onCompleted: {
      let temp = [];
      for (let i = 0; i <=root.maxCol; i++) {
        temp.push(0);
      }
      points=temp;
    }
    //----------the grid-------------
    ShapePath{
      fillColor:"transparent"
      strokeColor:root.strokeColor
      strokeWidth:root.strokeWidth
      PathMultiline{
        paths:{
          let lines=[];
          let w=root.implicitWidth||0
          let h=root.implicitHeight||0

          for(let i = 1; i < root.maxCol; i++) {
            let posX = i * shape.stepX;
            let posY = i * shape.stepY;
            //grid line
            lines.push([Qt.point(0, posY), Qt.point(w, posY)]); 
            lines.push([Qt.point(posX, 0), Qt.point(posX, h)]); 
          }
          return lines;
        }
      }
    }

    //----------the graph------------
    ShapePath {
      id: path
      strokeColor: root.strokeColor
      fillColor: root.fillColor
      strokeWidth: root.graphStokeWidth
      startX:0
      startY:root.implicitHeight-(data[0]||0)
    }
    function buildGraph(){
      path.pathElements=[];
      if (points.length === 0) return;
      for (let i = 0; i <=points.length; i++) {
        let line = Qt.createQmlObject('import QtQuick; PathLine {}', path);
        line.x = i * shape.stepX;
        line.y = height - (points[i] || 0);
        path.pathElements.push(line);
      }
      let line1 = Qt.createQmlObject('import QtQuick; PathLine {}', path);
      line1.x = (root.maxCol-1) * shape.stepX;
      line1.y = root.implicitHeight;
      let line2 = Qt.createQmlObject('import QtQuick; PathLine {}', path);
      line2.x = 0;
      line2.y = root.implicitHeight;
      path.pathElements.push(line1,line2);
    }
    onPointsChanged: buildGraph()
    Timer{
      interval:1000
      running:true
      repeat:true
      onTriggered:{
        let v=Math.random()*root.implicitHeight;
        let n=[...shape.points];
        n.push(v);
        if(n.length>root.maxCol)n.shift();
        shape.points=n;
      }
    }
  }
}
