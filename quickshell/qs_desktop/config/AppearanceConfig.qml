import Quickshell.Io
import QtQuick

JsonObject{
  property Rounding rounding:Rounding{}
  property Spacing spacing:Spacing{}
  property Padding padding:Padding{}
  property FontInfo font:FontInfo{}
  property Transparency transparency:Transparency{}

  component Rounding: JsonObject{
    property real scale:1
    property int small :12 * scale;
    property int medium:12 * scale;
    property int large :22 * scale;
  }
  component Spacing:JsonObject{
    property real scale: 1
    property int small : 7  * scale 
    property int normal: 10 * scale
    property int medium: 12 * scale
    property int large : 15 * scale
    property int huge  : 20 * scale
  }

  component Padding:JsonObject{
    property real scale: 1
    property int small : 5  * scale
    property int normal: 7  * scale
    property int medium: 10 * scale
    property int large : 12 * scale
    property int huge  : 15 * scale
  }

  component FontFamily: JsonObject{
    property string sans: "Rubik"
    property string mono: "JetBrains Mono"
    property string material: "Material Symbols Rounded"
    property string clock: "Rubik"
  }

  component FontSize: JsonObject{
    property real scale: 1
    property int small : 11 * scale
    property int normal: 12 * scale
    property int medium: 13 * scale
    property int large : 15 * scale
    property int huge  : 18 * scale
    property int extraHuge:28*scale
  }

  component FontInfo:JsonObject{
    property FontFamily family: FontFamily{}
    property FontSize   size  : FontSize{}
  }
  component Transparency: JsonObject {
    property bool enabled: false
    property real base: 0.85
    property real layers: 0.4
  }
}
