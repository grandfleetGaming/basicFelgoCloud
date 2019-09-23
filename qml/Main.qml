import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    licenseKey: "E80C7CF416974F2C94E017F56AF1CB0E02DB2C3334653ECA056F21E5C1382FAB4BA1F680A568273467160B147709396A872964B791437F369E39AAFFF6D23406E4CCEA400BAFC9A0C4D5484A0EE4FC9520902F4E085D50E215CFFBAC783063997834BB9F608E4570CF7E64F0016DE81D7238DD5652C6ED8B4DC336AB91AF58D8242E24DAB6CAEFB632D2487CE934A3B7AECC2F1C3F5149F395FECB356EFA8602186497942444EA9FF72ED6E197F79EB6C5C33D2051EF46D4C38BA2AF3C8E5D99948384C3E71A0D8DF3DD658513EF580F6EB83E695A6060DD462754AAD68E0572623073348D06AD70C009390CBDCCFB1B097641CA0B99503091013904C1264B727909776E8246752D7337CC02C44FC4EE3F5572F767B8C8670A9D9DE4D3340867334A01401A17DC85E98D9B61ECB20F10CC099838562C0B80B56174492986C028"
    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 640
    screenHeight: 960

   Scene {
    id: scene
    property string gameState: "wait"
    property int score: 0
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 320
    height: 480
    sceneAlignmentY: "bottom"
    PhysicsWorld {
      debugDrawVisible: true // set this to false to hide the physics debug overlay
      gravity.y: scene.gameState != "wait" ? 9.81 : 0 // 9.81 would be earth-like gravity, so this one will be pretty strong
      z: 1000 // set this high enough to draw on top of everything else
    }
    Image {
      id: bg
      source: "../assets/bg.png"
      anchors.horizontalCenter: scene.horizontalCenter
      anchors.bottom: scene.gameWindowAnchorItem.bottom
    }
    Pipe {
      id: pipe1
      x: 400
      y: 60+Math.random()*200
    }
    Pipe {
      id: pipe2
      x: 640
      y: 60+Math.random()*200
    }
    Ground {
      anchors.bottom: scene.bottom
      anchors.horizontalCenter: scene.horizontalCenter
    }
    Player {
      id: player
      x: 47
      y: 167
    }
    Text {
      text: scene.score
      color: "white"
      anchors.horizontalCenter: scene.horizontalCenter
      y: 30
      font.pixelSize: 30
    }
    Text {
      text: scene.gameState == "gameOver" ? "Game Over.\nPress to Restart" : ''
      color: "white"
      anchors.horizontalCenter: scene.horizontalCenter
      y: 80
      font.pixelSize: 30
    }
    MouseArea {
       anchors.fill: scene.gameWindowAnchorItem
       onPressed: {
           if(scene.gameState == "wait") {
              scene.startGame()
              player.push()
            } else if(scene.gameState == "play") {
              player.push()
            } else if(scene.gameState == "gameOver") {
              scene.reset()
            }
       }
    }
    function startGame() {
      scene.gameState = "play"
    }
    function stopGame() {
      scene.gameState = "gameOver"
    }
    function reset() {
      scene.gameState = "wait"
      pipe1.x = 400
      pipe1.y = 60+Math.random()*200
      pipe2.x = 640
      pipe2.y = 60+Math.random()*200
      player.x = 47
      player.y = 167
      scene.score = 0
    }
  }
}
