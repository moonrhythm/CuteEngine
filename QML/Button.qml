import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "Button"

    property alias source: _image.source
    signal clicked()
    signal pressed()
    signal release()
    signal doubleClicked()
    signal pressAndHold()

    width: _image.implicitWidth
    height: _image.implicitHeight

    Image {
        id: _image
        anchors.fill: parent
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        onClicked: self.clicked()
        onPressed: self.pressed()
        onReleased: self.release()
        onDoubleClicked: self.doubleClicked()
        onPressAndHold: self.pressAndHold()
    }
}

