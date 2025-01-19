import QtQuick 2.15

Item {
    id: rootVolume

    property string fontColor: "grey"
    //property int vol: Volume.volume;

    Rectangle {
        id: decreaseVolume

        color: "black"

        width: height / 2

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: volumeImage.left
            rightMargin: 14
        }

        Text {
            anchors.centerIn: parent

            text: "<"
            font.pixelSize: 20
            font.bold: true
            color: rootVolume.fontColor
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                Volume.changeVolume(-1)
                //console.log("Vol: " + Volume.volume)
            }
        }
    }

    Image {
        id: volumeImage

        anchors {
            // top: parent.top
            // bottom: parent.bottom
            right: volumeDisplayed.left
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }

        height: parent.height * 0.6
        fillMode: Image.PreserveAspectFit

        // function setIcon(vol) {
        //     vol = Volume.volume

        //     if (vol == 0) {
        //         return "qrc:/ui/assets/volume-mute.png"
        //     } else if (vol > 0 && vol < 10) {
        //         return "qrc:/ui/assets/volume-low.png"
        //     } else if (vol >= 10 && vol < 20) {
        //         return "qrc:/ui/assets/volume-up.png"
        //     } else if (vol === 20) {
        //         return "qrc:/ui/assets/volume-max.png"
        //     }
        // }

        // source: setIcon()

        source: {
            if (Volume.volume == 0) {
                return "qrc:/ui/assets/volume-mute.png"
            } else if (Volume.volume > 0 && Volume.volume < 10) {
                return "qrc:/ui/assets/volume-low.png"
            } else if (Volume.volume >= 10 && Volume.volume < 20) {
                return "qrc:/ui/assets/volume-up.png"
            } else if (Volume.volume === 20) {
                return "qrc:/ui/assets/volume-max.png"
            }
        }


    }

    Rectangle {
        id: volumeDisplayed

        width: height / 2
        color: "black"

        anchors {
            right: increaseVolume.left
            //rightMargin: 5
            top: parent.top
            topMargin: 4
            bottom: parent.bottom
        }

        Text {
            color: rootVolume.fontColor
            font.pixelSize: 14
            font.bold: true

            text: Volume.volume
        }
    }

    Rectangle {
        id: increaseVolume

        color: "black"

        width: height / 2

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: 14
        }

        Text {
            anchors.centerIn: parent

            text: ">"
            font.pixelSize: 20
            font.bold: true
            color: rootVolume.fontColor
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                Volume.changeVolume(1)
                //console.log("Vol: " + Volume.volume)
            }
        }

    }
}
