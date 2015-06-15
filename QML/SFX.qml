import QtQuick 2.4
import QtMultimedia 5.4

CuteObject {
    readonly property string __className: "SFX"

    property alias source: _audio.source
    property alias autoPlay: _audio.autoPlay

    function play() {
        _audio.play()
    }

    function pause() {
        _audio.pause()
    }

    function stop() {
        _audio.stop()
    }

    Audio {
        id: _audio
        autoLoad: true
        autoPlay: false
        onError: console.log(errorString)
    }
}
