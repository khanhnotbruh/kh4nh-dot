import Quickshell.Io
import QtQuick
JsonObject{
  id:root
  property double background_opacity:1
  property color  background_color:"#242424"
  property JsonObject anim:JsonObject{
    property int duration:250
    property int ease_type:Easing.OutQuad
    property Animation animation:NumberAnimation{
      duration: anim.duration
      easing.type: anim.ease_type
    }
  }
}
