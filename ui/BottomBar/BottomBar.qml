import QtQuick 2.15

Rectangle {
    id: bottomBar
    color: "black"
    height: parent.height / 12

    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    Image {
        id: carSettingsIcon
        anchors {
            left: parent.left
            leftMargin: 30
            //bottom: parent.bottom
            verticalCenter: parent.verticalCenter
        }

        height: parent.height * 1.2
        fillMode: Image.PreserveAspectFit

        source: "qrc:/ui/assets/carIcon.png"
    }

    HVACComponent {
        id: driverHVACControl
        hvacController: DriverHVAC

        anchors {
            left: carSettingsIcon.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: parent.width / 16
        }
    }

    HVACComponent {
        id: passengerHVACControl
        hvacController: PassengerHVAC

        anchors {
            right: volumeControl.right
            rightMargin: parent.width / 3.5
            top: parent.top
            bottom: parent.bottom
            //leftMargin:
        }
    }

    VolumeComponent {
        id: volumeControl

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 30
        }
    }
}
