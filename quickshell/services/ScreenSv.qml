import QtQuick
import Quickshell
import Quickshell.Io
Item{
  id:root
  property alias shot:shot
  QtObject{
    id:shot
    property string name:"screen_shot.png"
    property string path:Quickshell.env("XDG_RUNTIME_DIR")+"/"+name
    signal procFinished()
    property Process proc:Process{
      command:["grim",shot.path]
      running:false
      onExited: (exitCode, exitStatus) =>{ shot.procFinished() }
    }
    property IpcHandler ipc:IpcHandler{
      target:"screen/screen_shot"
      function take():void{ if(!shot.proc.running)shot.proc.running=true }
      function getPath():string{return shot.path}
      function getName():string{return shot.name}
      function setPath(val:string):void{shot.path=val}
      function setName(val:string):void{shot.name=val}
    }
  }
}
