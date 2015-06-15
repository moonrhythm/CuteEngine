import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "Sequence"

    property list<Source> sources
    property list<Transitor> transitors
    property alias __source: _loader.source

    Loader {
        id: _loader
        anchors.fill: parent
        source: (sources[0]) ? sources[0].source : ""
        focus: true
    }

    anchors.fill: parent

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
        // parent.__handle(msg)
    }

    Component.onCompleted: {
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
    }
}

