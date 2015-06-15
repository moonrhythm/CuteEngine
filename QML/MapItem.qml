import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "MapItem"
    property alias source: _img.source
    property int blockX: 0
    property int blockY: 0
    signal activated()

    Image {
        id: _img
        anchors.fill: parent
    }
}

