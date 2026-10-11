import QtQuick
import Quickshell.Io
Item{
  id: root
  property bool is_open:false
  signal lockRequested()
  property IpcHandler ipc:IpcHandler {
    target:"lock_screen"
    function toggle():void{
      if(!is_open)lockRequested()
      root.is_open=!root.is_open; 
    }
    function setVal(val:bool):void{
      if(val&&val!=root.is_open)lockRequested()
      root.is_open=val
    }
    function getVal():bool{ return root.is_open; }
  }
}
