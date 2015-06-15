import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "Background"

    property alias source: _image.source
    property string fillMode: "STRETCH"

    property bool animationIn: false
    property bool animationOut: false
    property int animationDelay: 500
    property int animationInDuration: 1000
    property int animationOutDuration: 1000
    signal animationCompleted

    anchors.fill: parent
    clip: true

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

    state: animationIn ? "s0" : "s1"

    states: [
        State {
            name: "s0"
            PropertyChanges {
                target: _image
                opacity: 0.0
            }
            Component.onCompleted: {
                self.state = "s1"
            }
        },
        State {
            name: "s1"
            PropertyChanges {
                target: _image
                opacity: 1.0
            }
        },
        State {
            name: "s2"
            PropertyChanges {
                target: _image
                opacity: 0.0
            }
        }
    ]

    transitions: [
        Transition {
            from: "s0"
            to: "s1"
            SequentialAnimation {
                NumberAnimation {
                    target: _image
                    property: "opacity"
                    duration: animationInDuration
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: animationDelay
                }
                ScriptAction {
                    script: if (animationOut) self.state = "s2"
                }
            }
        },
        Transition {
            from: "s1"
            to: "s2"
            SequentialAnimation {
                NumberAnimation {
                    target: _image
                    property: "opacity"
                    duration: animationOutDuration
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: animationCompleted()
                }
            }
        }
    ]
}
