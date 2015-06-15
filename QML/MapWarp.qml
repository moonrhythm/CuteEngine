import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "MapWarp"
    property int blockX: 0
    property int blockY: 0
    property string receiver: ""
    property string message: ""
    signal activated()
}

