import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "TextBox"

    property alias text: _text.text
    property alias font: _text.font
    property alias color: _text.color
    property alias boxColor: _rect.color
    property alias boxOpacity: _rect.opacity
    property alias contentWidth: _text.contentWidth
    property alias contentHeight: _text.contentHeight
    property bool wordWrap: false

    width: contentWidth
    height: contentHeight
    clip: true

    Rectangle {
        id: _rect
        anchors.fill: parent
        color: "white"
    }
    Text {
        id: _text
        anchors.centerIn: parent
        wrapMode: wordWrap ? Text.WordWrap : Text.NoWrap
    }
}
