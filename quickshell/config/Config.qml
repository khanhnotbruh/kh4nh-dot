pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
Singleton{
  FileView{
    id:configFile
    path:Quickshell.shellDir+"/config.json"
    watchChanges:true
    JsonAdapter{
      id:configAdapter
      property Appearance appearance:Appearance{}
      property ControlCenter control_center:ControlCenter{}
    }
    onFileChanged:{
      console.log("Config file changed...");
      reload();
    }
  }
  property alias appearance: configAdapter.appearance
  property alias control_center: configAdapter.control_center
}
