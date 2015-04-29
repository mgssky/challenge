import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: cloud

  entityType: "Cloud"

   // the method summons lightning every time the mouse is clicked
  SpriteSequenceVPlay {
    id: boltAnim
    anchors.centerIn: gameScene
    x: -45
    height: 256
    defaultSource: "../../assets/bolt.png"
    visible: gameScene.thunderStrike
    SpriteVPlay {
      frameRate: 10
      frameWidth: 87
      frameHeight: 256
      startFrameColumn: 2
    }
  }

  // the method displays the cloud particle effect
  ParticleVPlay {
              anchors.centerIn: parent
              id: collisionParticleEffect
              fileName: "../../assets/cloud.json"
              autoStart: true
          }

  // this collision detector check whether objects are in the area of the lightning strike
  CircleCollider{
      collisionTestingOnlyMode: true
      x: 0
      y: 220
      radius: 20
      categories: Circle.Category3
      collidesWith: Circle.Category2
  }

}
