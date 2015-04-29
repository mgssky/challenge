import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "entities"

GameWindow {
  id: gameWindow
  width: 800
  height: 480

  HomeScene {
      id: homeScene
    }

 //Normally you would have several states each responsible for each scene
 //even though there is only "HomeScene" present at the moment, we will also make some room for any future scenes


  state: "home" // this is our default scene

   states: [
     State {
       name: "home"
       PropertyChanges {target: homeScene; opacity: 1}
       PropertyChanges {target: gameWindow; activeScene: homeScene}
     },
     State {
       //in case you want to add more scenes change this code
       name: "credits"
     }
   ]
}
