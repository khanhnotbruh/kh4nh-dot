pragma Singleton

import Quickshell
import QtQuick
import QtCore

Singleton{
  id:root

  readonly property string home: StandardPaths.home+path.slice(1)
  readonly property string config: `${home}/.config`
}
