import QtQuick
import QtLocation
import QtPositioning

Rectangle {
    id: rightScreen
    // color: "orange"
    width: parent.width * 2/3

    anchors {
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(51.07, 13.73) // Chemo
        zoomLevel: 14

        property geoCoordinate startCentroid

        /*
        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                                 map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                             }
            onScaleChanged: (delta) => {
                                map.zoomLevel += Math.log2(delta)
                                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                            }
            onRotationChanged: (delta) => {
                                   map.bearing -= delta
                                   map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                               }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        */

        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }

    }

    Image {
        id: lockIcon

        anchors {
            left: parent.left
            top: parent.top
            margins: 20
        }

        width: parent.width / 45
        fillMode: Image.PreserveAspectFit

        source: SystemHandler.carLocked ? "qrc:/ui/assets/closed.png" : "qrc:/ui/assets/unlock.png"

        MouseArea {
            anchors.fill: parent

            onClicked: SystemHandler.setCarLocked(!SystemHandler.carLocked)
            //SystemHandler.carLocked = !SystemHandler.carLocked
        }
    }

    Text {
        id: time

        anchors {
            left: lockIcon.right
            top: parent.top
            leftMargin: 35
            topMargin: 18
        }

        font.pixelSize: 18
        font.bold: true
        color: "black"

        text: SystemHandler.currentTime
    }

    Text {
        id: outdoorTemp

        anchors {
            left: time.right
            top: parent.top
            leftMargin: 35
            topMargin: 18
        }

        font.pixelSize: 18
        font.bold: true
        color: "black"
        text: SystemHandler.outdoorTemp + " °C"
    }

    Image {
        id: userIcon

        anchors {
            left: outdoorTemp.right
            top: parent.top
            leftMargin: 35
            topMargin: 22
        }
        width: parent.width / 48
        fillMode: Image.PreserveAspectFit

        source: "qrc:/ui/assets/user.png"
    }

    Text {
        id: userName

        anchors {
            left: userIcon.right
            top: parent.top
            leftMargin: 6
            topMargin: 18
        }
        color: "black"
        font.bold: true
        font.pixelSize: 18

        text: SystemHandler.userName
    }

    NavigationSearchBox {
        id: navSearchBox

        width: parent.width / 3
        height: parent.height / 17

        anchors {
            top: lockIcon.bottom
            left: lockIcon.left
            topMargin: 20
            //leftMargin: 35
        }

        Image {
            id: searchIcon

            fillMode: Image.PreserveAspectFit

            anchors {
                top: parent.top
                bottom:parent.bottom
                left: parent.left
                topMargin: 13
                bottomMargin: 13
                leftMargin: 18
            }
            source: "qrc:/ui/assets/search.png"
        }

        Text {
            id: searchText

            //visible: searchInput.text === "" ? true : false
            visible: searchInput.text === ""

            anchors {
                left: searchIcon.right
                leftMargin: 12
                verticalCenter: parent.verticalCenter
            }

            font.pixelSize: 13
            font.bold: true
            color: "grey"
            text: "Navigate"
        }

        TextInput {
            id: searchInput

            clip: true // text doesn't overshoot the searchbox
            color: "grey"
            font.pixelSize: 16
            font.bold: true

            anchors {
                left: searchIcon.right
                leftMargin: 12
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            verticalAlignment: Text.AlignVCenter

        }
    }
}
