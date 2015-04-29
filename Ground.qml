import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: ground
  entityType: "ground1" // was ground before
  property int vel: 0

  state: "idle"

  // the ground has 3 states
  // each state handles either idle or left,right movement of the ground
  states: [
      State {
        name: "idle"
        PropertyChanges {target: ground; vel: 0}
      },
      State {
        name: "goingRight"
        PropertyChanges {target: ground; vel: 120}
      },
      State {
        name: "goingLeft"
        PropertyChanges {target: ground; vel: -120}
      }
    ]

  Image {
    id: groundImage
    source: "../assets/ground.png"

  }

  //movement method behaves with regard to the current state of the ground
  MovementAnimation {
    id: movement
    target: ground
    property: "x"
    minPropertyValue: -1050
    maxPropertyValue: -50
    velocity: vel
    running: true
    onLimitReached: {
        vel = 0
    }
  }
}
