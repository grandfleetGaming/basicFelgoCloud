import QtQuick 2.0
import Felgo 3.0

EntityBase {
  id: player
  entityType: "player"
  width: 26
  height: 26

  SpriteSequence {
    id: bird
    anchors.centerIn: parent

    Sprite {
      frameCount: 3
      frameRate: 10
      frameWidth: 34
      frameHeight: 24
      source: "../assets/bird.png"
    }
  }
}
