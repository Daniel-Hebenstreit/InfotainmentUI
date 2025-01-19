import QtQuick

Rectangle {
    id: leftScreen
    // color: "grey"

    anchors {
        top: parent.top
        bottom: bottomBar.top
        left: parent.left
        right: rightScreen.left
    }

    Image {
        id: carRender
        anchors.centerIn: parent
        width: parent.width * 0.85
        fillMode: Image.PreserveAspectFit

        source: "qrc:/ui/assets/carRender2.png"
    }
}
