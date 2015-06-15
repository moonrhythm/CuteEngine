import QtQuick 2.4
import "lib.js" as Lib

Item {
    readonly property string __id: Lib.getID()
    readonly property string __className: "CuteObject"
    property string name: ""
    signal __handle(var msg)
    signal handle(var msg)

    on__Handle: handle(msg)

    function getIDString() { return Lib.getIDString(this) }
    function send(name, msg) { Lib.__send(name, msg) }

    Component.onCompleted: Lib.addObject(this)
    Component.onDestruction: Lib.removeObject(this)

    function random(min, max) { return Math.floor(Math.random() * (max - min + 1)) + min }
}
