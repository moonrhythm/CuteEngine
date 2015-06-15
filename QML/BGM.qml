import QtQuick 2.4
import QtMultimedia 5.4

CuteObject {
    readonly property string __className: "BGM"

    property alias source: _audio.source

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
        autoPlay: true
        loops: Audio.Infinite
        onError: console.log(errorString)
        onPlaybackStateChanged: if (playbackState != playbackState.PlayingState) play()
    }
}

