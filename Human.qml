import QtQuick 2.0
import VPlay 2.0

EntityBase{
    id: man
    entityType: "human"

    property bool died: false
    property bool goingRight: true
    property int vel: 80

    SpriteSequenceVPlay {
      id: manAnim
      anchors.centerIn: parent
      width: 48
      height: 48
      mirrorX: !goingRight

      defaultSource: Math.random()*100 > 50 ? "../assets/animation_man_full.png" : "../assets/animation_man_full_green.png"

      SpriteVPlay {
        name: "goingAnim"
        frameCount: 4
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 2
        to: {"runningAnim":0.2, "goingAnim":0.8}
      }
      SpriteVPlay {
        name: "runningAnim"
        frameCount: 4
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 3
        to: {"goingAnim":0.2, "runningAnim":0.8}
      }
      SpriteVPlay {
        name: "dyingAnim"
        frameCount: 4
        frameRate: 10
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 4
        to: {"diedAnim":1}
      }
      SpriteVPlay {
        name: "diedAnim"
        frameWidth: 100
        frameHeight: 100
        startFrameRow: 4
        startFrameColumn: 4
        to: {"diedAnim":1}
      }
    }
    CircleCollider{
        categories: Circle.Category2
        collidesWith: Circle.Category3
        collisionTestingOnlyMode: true
        x: 0
        y: 0
        radius: 15
        fixture.onContactChanged: {
            if(gameScene.thunderStrike && !died) {
            manAnim.jumpTo("dyingAnim");
                gameScene.gameScore++;
                gameScene.scoreSound.play()
                died = true;
            }
          }
    }

    MovementAnimation {
          id: movement
          target: man
          property: "x"
          minPropertyValue: ground1.x-150
          maxPropertyValue: ground1.x+1650
          velocity: died ? ground1.vel : goingRight ? vel+ground1.vel : -vel+ground1.vel
          running: true
          onLimitReached: {
              goingRight = !goingRight
          }
    }

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(ground1.x,ground1.x+1500)
        y = 260
      }
}

