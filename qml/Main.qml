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
    screenWidth: 960
    screenHeight: 640

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 480
        height: 320

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        // see here for more details on content scaling and safe zone: https://felgo.com/doc/felgo-different-screen-sizes/
        Rectangle {
            id: rectangle
            anchors.fill: parent
            color: "grey"

            Text {
                id: textElement
                // qsTr() uses the internationalization feature for multi-language support
                text: qsTr("Hello Felgo World")
                color: "#ffffff"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent

                // when the rectangle that fits the whole scene is pressed, change the background color and the text
                onPressed: {
                    textElement.text = qsTr("Scene-Rectangle is pressed at position " + Math.round(mouse.x) + "," + Math.round(mouse.y))
                    rectangle.color = "black"
                    console.debug("pressed position:", mouse.x, mouse.y)
                }

                onPositionChanged: {
                    textElement.text = qsTr("Scene-Rectangle is moved at position " + Math.round(mouse.x) + "," + Math.round(mouse.y))
                    console.debug("mouseMoved or touchDragged position:", mouse.x, mouse.y)
                }

                // revert the text & color after the touch/mouse button was released
                // also States could be used for that - search for "QML States" in the doc
                onReleased: {
                    textElement.text = qsTr("Hello Felgo World")
                    rectangle.color = "grey"
                    console.debug("released position:", mouse.x, mouse.y)
                }
            }
        }// Rectangle with size of logical scene

        Image {
            id: felgoLogo
            source: "../assets/felgo-logo.png"

            // 50px is the "logical size" of the image, based on the scene size 480x320
            // on hd or hd2 displays, it will be shown at 100px (hd) or 200px (hd2)
            // thus this image should be at least 200px big to look crisp on all resolutions
            // for more details, see here: https://felgo.com/doc/felgo-different-screen-sizes/
            width: 50
            height: 50

            // this positions it absolute right and top of the GameWindow
            // change resolutions with Ctrl (or Cmd on Mac) + the number keys 1-8 to see the effect
            anchors.right: scene.gameWindowAnchorItem.right
            anchors.top: scene.gameWindowAnchorItem.top

            // this animation sequence fades the Felgo logo in and out infinitely (by modifying its opacity property)
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                PropertyAnimation {
                    to: 0
                    duration: 1000 // 1 second for fade out
                }
                PropertyAnimation {
                    to: 1
                    duration: 1000 // 1 second for fade in
                }
            }
        }

    }
}
