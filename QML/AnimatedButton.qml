import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "AnimatedButton"

    property string source: ""
    property list<Sprite> __sprites
    property alias mouseArea: _mouseArea
    default property alias sprites: self.__sprites
    property alias running: _seq.running
    property alias interpolate: _seq.interpolate
    property alias current: _seq.currentSprite

    function jumpTo(sprite) {
        _seq.jumpTo(sprite)
    }

    SpriteSequence {
        id: _seq
        anchors.fill: parent
        interpolate: true
        running: true
    }

    onSpritesChanged: __reset()
    onSourceChanged: __reset()

    function __reset() {
        for (var i = 0; i < sprites.length; ++i) {
            if (sprites[i].source == "") sprites[i].source = self.source
        }
        _seq.sprites = sprites
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}

