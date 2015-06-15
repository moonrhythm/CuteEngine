import QtQuick 2.4
import QtMultimedia 5.4

CuteObject {
    id: _root
    readonly property string __className: "Video"

    property alias source: _mediaPlayer.source
    property string fillMode: "PreserveAspectFit"
    property bool playing: true

    clip: true

    MediaPlayer {
        id: _mediaPlayer
        autoLoad: true
        autoPlay: _root.playing
        onError: console.log(errorString)
        onPlaybackStateChanged: {
            _root.playing = playbackState == MediaPlayer.PlayingState
        }
    }

    VideoOutput {
        id: _videoOutput
        anchors.fill: parent
        source: _mediaPlayer
        fillMode: __fillMode()
    }

    function __fillMode() {
        switch (fillMode.toUpperCase()) {
            case "STRETCH":
                return VideoOutput.Stretch
            case "PRESERVEASPECTFIT":
                return VideoOutput.PreserveAspectFit
            case "PRESERVEASPECTCROP":
                return VideoOutput.PreserveAspectCrop
        }
        return VideoOutput.PreserveAspectFit
    }

    onPlayingChanged: {
        if (playing == false) _mediaPlayer.stop()
        else _mediaPlayer.play()
    }
}

