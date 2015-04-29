import VPlay 2.0
import QtQuick 2.0

Scene {
  id: sceneBase

  //sceneBase is our base class for all the scenes


  // by default, set the opacity to 0 - this will be changed from the main.qml with PropertyChanges
  opacity: 0
  // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
  visible: opacity > 0
  // if the scene is invisible, we disable it.
  enabled: visible
}
