import QtQuick 2.15

Item {
    id: rootHVAC

    property string fontColor: "grey"
    property var hvacController // wird in BottomBar.qml bestimmt

    Rectangle {
        id: decrementBtn

        width: height / 2

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        color: "black"

        Text {
            anchors.centerIn: parent

            text: "<"
            font.pixelSize: 20
            font.bold: true
            color: rootHVAC.fontColor
        }

        MouseArea {
            anchors.fill: parent

            onClicked: hvacController.changeTargetTemp(-1)
        }

    }

    Text {
        id: driverTemp

        anchors {
            left: decrementBtn.right
            leftMargin: 14
            verticalCenter: parent.verticalCenter
        }

        text: hvacController.targetTemp + "°"
        font.pixelSize: 32
        color: rootHVAC.fontColor
    }

    Rectangle {
        id: incrementBtn

        width: height / 2

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: driverTemp.right
            leftMargin: 14
        }

        color: "black"

        Text {
            anchors.centerIn: parent

            text: ">"
            font.pixelSize: 20
            font.bold: true
            color: rootHVAC.fontColor
        }

        MouseArea {
            anchors.fill: parent

            onClicked: hvacController.changeTargetTemp(1)
        }

    }

}
