import QtQuick 2.0
import VPlay 2.0

EntityBase{
    id: trac
    entityType: "tractor"
    width: tractorAnim.width
    height: tractorAnim.height

    property bool died: false
    property bool goingRight: true // flag for going left or right
    property int vel: 120 // velocity

    
    SpriteSequenceVPlay {
      id: tractorAnim
      anchors.centerIn: parent

      mirrorX: !goingRight

      defaultSource: "../../assets/animation_tractor_full.png"

      SpriteVPlay {
        name: "goingAnim"
        frameCount: 4
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 2
      }
      SpriteVPlay {
        name: "burningAnim"
        frameCount: 3
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 3
        to: {"dyingAnim":0.2, "burningAnim":0.8}
      }
      SpriteVPlay {
        name: "dyingAnim"
        frameCount: 4
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 4
        to: {"diedAnim":0.1, "dyingAnime":0.9}
      }
      SpriteVPlay {
        name: "diedAnim"
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 1
        startFrameColumn: 2
        to: {"diedAnim":1}
      }
    }
    
    //collision detection and checks if the object was struck by lightning also plays the sound and increases the score
    CircleCollider{
        categories: Circle.Category2
        collidesWith: Circle.Category3
        collisionTestingOnlyMode: true
        x: 50
        y: 50
        radius: 25
        fixture.onContactChanged: {
            if(gameScene.thunderStrike && !died) {
            tractorAnim.jumpTo("burningAnim");
                gameScene.gameScore++;
                gameScene.scoreSound.play()
                died = true;
            }
          }
    }
    // movement of the object from left to right, if the limit is reached it changes direction
    MovementAnimation {
          id: movement
          target: trac
          property: "x"
          minPropertyValue: ground1.x-150
          maxPropertyValue: ground1.x+1650
          velocity: died ? ground1.vel : goingRight ? vel+ground1.vel : -vel+ground1.vel
          running: true
          onLimitReached: {
              goingRight = !goingRight
          }
    }

    //spawns the object at random x
    Component.onCompleted: {
        x = utils.generateRandomValueBetween(ground1.x,ground1.x+1500)
        y = 200
      }
}

