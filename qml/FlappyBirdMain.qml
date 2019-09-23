import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
  id: window
  screenWidth: 640
  screenHeight: 960

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"
  licenseKey: "E80C7CF416974F2C94E017F56AF1CB0E02DB2C3334653ECA056F21E5C1382FAB4BA1F680A568273467160B147709396A872964B791437F369E39AAFFF6D23406E4CCEA400BAFC9A0C4D5484A0EE4FC9520902F4E085D50E215CFFBAC783063997834BB9F608E4570CF7E64F0016DE81D7238DD5652C6ED8B4DC336AB91AF58D8242E24DAB6CAEFB632D2487CE934A3B7AECC2F1C3F5149F395FECB356EFA8602186497942444EA9FF72ED6E197F79EB6C5C33D2051EF46D4C38BA2AF3C8E5D99948384C3E71A0D8DF3DD658513EF580F6EB83E695A6060DD462754AAD68E0572623073348D06AD70C009390CBDCCFB1B097641CA0B99503091013904C1264B727909776E8246752D7337CC02C44FC4EE3F5572F767B8C8670A9D9DE4D3340867334A01401A17DC85E98D9B61ECB20F10CC099838562C0B80B56174492986C028"
  property alias window: window
  activeScene: splash

  // show the splash and start the loading process as soon as the GameWindow is ready
  Component.onCompleted: {
    splash.opacity = 1
    mainItemDelay.start()
  }

  // since the splash has a fade in animation, we delay the loading of the game until the splash is fully displayed for sure
  Timer {
    id: mainItemDelay
    interval: 500
    onTriggered: {
      mainItemLoader.source = "MainItem.qml"
    }
  }

  // as soon as we set the source property, the loader will load the game
  Loader {
    id: mainItemLoader
    onLoaded: {
      if(item) {
        hideSplashDelay.start()
      }
    }
  }

  // give the game a little time to fully display before hiding the splash, just to be sure it looks smooth also on low-end devices
  Timer {
    id: hideSplashDelay
    interval: 200
    onTriggered: {
      splash.opacity = 0
    }
  }

  SplashScene {
    id: splash
  }
}