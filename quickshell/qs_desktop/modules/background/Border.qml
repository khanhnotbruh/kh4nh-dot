import Quickshell
import QtQuick
import QtQuick.Shapes
import "../../config"

Shape{
  id:root

  //smoother option
  // antialiasing: true
  layer.enabled: true
  layer.samples: 4
  ShapePath {
    id:frame
    property real width:Screen.width
    property real height:Screen.height

    property real rounding:Config.border.rounding
    property int thickness:Config.border.thickness
    property bool flatten:width<rounding*2
    property real roundingX:flatten?width/2:rounding

    fillColor:Config.border.color
    strokeWidth:-1
    //start by drawing top left corner
    startX: 0
    startY: 0

    PathLine{
      relativeX: frame.rounding+frame.thickness
      relativeY: 0
    }
    PathLine{
      relativeX: 0
      relativeY: frame.thickness
    }
    PathArc{
      relativeX:-frame.rounding
      relativeY:frame.rounding
      radiusX:frame.rounding
      radiusY:frame.rounding
      direction:PathArc.Counterclockwise
    }
    PathLine{
      relativeX:0
      relativeY:frame.height-2*(frame.thickness+frame.rounding)
    }
    PathArc{
      relativeX:frame.rounding
      relativeY:frame.rounding
      radiusX:frame.rounding
      radiusY:frame.rounding
      direction:PathArc.Counterclockwise
    }
    PathLine{
      relativeX:frame.width-2*(frame.thickness+frame.rounding)
      relativeY:0
    }
    PathArc{
      relativeX:frame.rounding
      relativeY:-frame.rounding
      radiusX:frame.rounding
      radiusY:frame.rounding
      direction:PathArc.Counterclockwise
    }
    PathLine{
      relativeX:0
      relativeY:-(frame.height-2*(frame.thickness+frame.rounding))
    }
    PathArc{
      relativeX:-frame.rounding
      relativeY:-frame.rounding
      radiusX:frame.rounding
      radiusY:frame.rounding
      direction:PathArc.Counterclockwise
    }
    PathLine{
      relativeX:-(frame.width-2*(frame.thickness+frame.rounding))
      relativeY:0
    }
    PathLine{
      relativeX:0
      relativeY:-frame.thickness
    }
    PathLine{
      relativeX:frame.width-(frame.thickness+frame.rounding)
      relativeY:0
    }
    PathLine{
      relativeX:0
      relativeY:frame.height
    }
    PathLine{
      relativeX:-frame.width
      relativeY:0
    }
  }
}
