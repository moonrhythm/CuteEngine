import QtQuick 2.4

QtObject {
    id: self
    property string name: ""
    property string next: ""
    property var message
    signal activated()

    function __activate(host) {
        host.state = next
        var sources = host.sources
        for (var i = 0; i < sources.length; ++i) {
            if (sources[i].name == next) {
                host.__source = sources[i].source
                break
            }
        }
        activated()
    }
}

