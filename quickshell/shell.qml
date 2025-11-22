import Quickshell
import QtQuick
import "modules/bar"

ShellRoot {
    id: loader


    Loader {
        active: true
        sourceComponent: Edge {}
    }
    Loader {
        active:true
        sourceComponent: Bar{}
    }
}

