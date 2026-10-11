pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
QtObject {
  id: root
  property BrightnessSv brightness:BrightnessSv{}
  property ControlCenterSv control_center:ControlCenterSv{}
  property LockScreenSv lock_screen:LockScreenSv{}
  property ScreenSv screen:ScreenSv{}
  property IpcHandler ipc:IpcHandler{
    target:"service"
    function reset():void{
      return;
    }
  }
}
