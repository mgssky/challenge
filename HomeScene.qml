import VPlay 2.0
import QtQuick 2.0

SceneBase {
  id:gameScene

  property bool thunderStrike: false
  property int time: 60
  property int gameScore: 0
  property bool gameRunning: false
  property int maxScore: 6
  property int targets: 0

  property alias scoreSound: scoreSound

  EntityManager {
      id: entityManager
      entityContainer: gameScene
    }

  PhysicsWorld{
      //this game does not rely on precise physics calculations, therefore 10 is a good value
      updatesPerSecondForPhysics: 10
      }

       //setting up the background image
  Image {
      id: background
      anchors.fill: parent.gameWindowAnchorItem
      source: "../assets/background.png"

  }

  //setting up the ground image
  Ground {
      id: ground1
      x: -500
      y: 250

  }

  //cloud is a particle effect that was made in the V-Play particle editor
  //cloud is responsible for the lighting and the cloud
  Cloud{
      id: cloud
      y: 50
      x: 240
  }

  //handle the mouse clicking and making sure it stops when the game is over
  MouseArea {
    anchors.fill: gameScene.gameWindowAnchorItem
    onPressed: {
        if(gameScene.thunderStrike == false && gameRunning)
        gameScene.thunderStrike = true;
    }
    onReleased:{
        gameScene.thunderStrike = false;
    }
  }

  ////handle the keyboard input for the screen movement
      Keys.onPressed: {
          if (event.key == Qt.Key_Left && gameRunning) {
              ground1.state = "goingLeft"
              event.accepted = true;
          }
          if (event.key == Qt.Key_Right && gameRunning) {
              ground1.state = "goingRight"
              event.accepted = true;
          }
      }
      Keys.onReleased: {
          if (event.key == Qt.Key_Left || event.key == Qt.Key_Right) {
              ground1.state = "idle"
              event.accepted = true;
          }
      }

      //gameTimer checks if the maxScore was reached or the time is over
      Timer {
          id: gameTimer
          running: gameRunning // time only counts down if game is running
          repeat: true
          onTriggered: {
            time--
            if(time === 0 || gameScore === maxScore) {
              gameRunning = false
            }
          }
        }

      //Message rectangle displays the score
      Rectangle {
                  color: "yellow"
                  anchors.centerIn: gameScene
                  width: 250
                  height: 120
                  visible: !gameRunning

                  Text {
                      text: "Score " + gameScene.gameScore
                      color: "black"
                      anchors.centerIn: parent
                  }

              }
      //Gametime countdown
      Text {
          text: "Time " + gameScene.time
          color: "White"
          visible: gameRunning
      }


        // score sound
        SoundEffectVPlay {id: scoreSound; source:"../assets/Stomp.wav"}

        // background music
        BackgroundMusic {source:"../assets/music.mp3"}

        //this method spawns 2 tractors and 4 human before the game starts
        Timer {
            interval: 20
            running: true
            repeat: true
            onTriggered: {
              entityManager.createEntityFromUrl(Qt.resolvedUrl("Tractor.qml"));
              entityManager.createEntityFromUrl(Qt.resolvedUrl("Human.qml"));
                entityManager.createEntityFromUrl(Qt.resolvedUrl("Human.qml"));
              targets++

              if(targets === 2) {
                running = false
                gameRunning = true
              }
            }
          }

}
