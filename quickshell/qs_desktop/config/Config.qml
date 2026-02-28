pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton{
  id:root
  property bool saving:false
  //---------------------opening file----------------------//
  FileView{
    id:file
    path:Quickshell.shellDir+"/config.json"
    watchChanges: true

    JsonAdapter{
      id:adapter
      property AppearanceConfig appearance: AppearanceConfig{}
      property BorderConfig border:BorderConfig{}
      property PathConfig path:PathConfig{}
      property DashboardConfig dashboard:DashboardConfig{}
    }

    onFileChanged:{
      console.log("File changed detected");
      if(!saving) {
        reload();
      }
    }
  }
  property alias appearance:adapter.appearance
  property alias border:adapter.border
  property alias path:adapter.path
  property alias dashboard:adapter.dashboard
  // save if there is change
  Connections {
    target: appearance
    ignoreUnknownSignals: true
    // i commented this bc for some reason it does nothing
    //function onChanged() {
    //  console.log("change in Appearance detected");
    //  sTimer.restart()
    //}
  }
  Connections {
    target: border
    ignoreUnknownSignals: true
  }
  Connections {
    target: path
    ignoreUnknownSignals: true
  }
  Connections {
    target: dashboard
    ignoreUnknownSignals: true
  }
  //---------------------saving file----------------------//
  Timer{
    id:sTimer
    interval:500
    repeat:false
    onTriggered:{
      try{
        root.saving=true;
        console.log("Saving...");
        file.setText(file.text());
        root.saving=false;
      }catch(e){
        console.log("Failed saving file: ",e);
      }
    }
  }
}
