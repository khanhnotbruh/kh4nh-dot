import QtQuick
import Quickshell.Io
Item{
  id: root
  property bool is_open:false
  property IpcHandler ipc:IpcHandler {
    target:"control_center"
    function toggle():void{ root.is_open=!root.is_open; }
    function setVal(val:bool):void{root.is_open=val}
    function getVal():bool{ return root.is_open; }
  }
}
