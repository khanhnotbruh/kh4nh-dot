import Quickshell
import QtQuick
import "modules/bar"
import "modules"

ShellRoot {
    id: loader


    Loader {
        active: true
        sourceComponent: Frame {}
    }
    Loader {
        active:true
        sourceComponent: Bar{}
    }
//    Loader {
//        active:true
//        sourceComponent: Test{}
//    } 
}

