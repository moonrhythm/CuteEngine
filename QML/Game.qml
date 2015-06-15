import QtQuick 2.4
import QtQuick.Controls 1.3
import Qt.labs.settings 1.0
import "lib.js" as Lib

ApplicationWindow {
    readonly property string __id: Lib.getID()
    readonly property string __className: "Game"

    id: self
    title: "Cute Engine"
    width: gameWidth
    height: gameHeight
    visible: true
    color: "black"

    property string name: ""
    property list<Source> sources
    property list<Transitor> transitors
    signal __handle(var msg)
    property string state: ""
    property alias __source: _loader.source
    property int gameWidth: 640
    property int gameHeight: 480
    property Settings settings
    signal completed()

    Item {
        anchors.centerIn: parent
        width: gameWidth
        height: gameHeight
        scale: self.width / gameWidth
        Loader {
            id: _loader
            anchors.fill: parent
            source: (sources[0]) ? sources[0].source : ""
            focus: true
        }
    }

    on__Handle: {
        var ts = self.transitors
        for (var i = 0; i < ts.length; ++i) {
            if (ts[i].name == state && ts[i].message == msg) {
                ts[i].__activate(this)
                var p = sources
                for (var j = 0; j < p.length; ++j) {
                    if (p[j].name == state) {
                        _loader.source = p[j].source
                    }
                }
                return
            }
        }
    }

    Component.onCompleted: {
        Lib.addObject(this)
        if (!sources[0])
            return
        if (state == "") {
            state = sources[0].name
        }
        else
        {
            var p = sources
            for (var i = 0; i < p.length; ++i) {
                if (p[i].name == state) {
                    _loader.source = p[i].source
                }
            }
        }
        completed()
    }

    function getIDString() {
        return Lib.getIDString(this)
    }

    function send(name, msg) {
        Lib.__send(name, msg)
    }
}
