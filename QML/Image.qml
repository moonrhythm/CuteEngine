import QtQuick 2.4

CuteObject {
    readonly property string __className: "Image"

    property alias source: _image.source
    property string fillMode: "Stretch"
    property alias implicitWidth: _image.implicitWidth
    property alias implicitHeight: _image.implicitHeight

    clip: true
    width: implicitWidth
    height: implicitHeight

    Image {
        id: _image
        anchors.fill: parent
        fillMode: __fillMode()
    }

    function __fillMode() {
        switch (fillMode.toUpperCase()) {
            case "STRETCH":
                return Image.Stretch
            case "PRESERVEASPECTFIT":
                return Image.PreserveAspectFit
            case "PRESERVEASPECTCROP":
                return Image.PreserveAspectCrop
            case "TILE":
                return Image.Tile
            case "TILEVERTICALLY":
                return Image.TileVertically
            case "TILEHORIZONTALLY":
                return Image.TileHorizontally
            case "PAD":
                return Image.Pad
        }
        return Image.Stretch
    }
}
