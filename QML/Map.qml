import QtQuick 2.4

CuteObject {
    id: self
    readonly property string __className: "Map"
    anchors.fill: parent

    /*
    property string source: ""
    property var mapData: []
    property var objData: []
    property int blockWidth: 32
    property int blockHeight: 32
    property int blockRow: 10
    property int blockCol: 10
    property int row: 32
    property int col: 32

    property Player player

    property double __cellWidth: width / col
    property double __cellHeight: height / row
*/

    property alias source: _map.source
    //property alias scrollX: _scroll.x
    //property alias scrollY: _scroll.y
    property alias scrollX: _scroll.scrollX
    property alias scrollY: _scroll.scrollY
    property alias mapWidth: _scroll.width
    property alias mapHeight: _scroll.height
    property int row: 0
    property int col: 0
    property alias player: _scroll.player
    property var mapProperty
    property alias mapItems: _scroll.mapItems
    property alias mapWarps: _scroll.mapWarps
    property alias npcs: _scroll.npcs

    function init() {
        _scroll.__reset()
    }

    onWidthChanged: _scroll.__scrollToPlayer()
    onHeightChanged: _scroll.__scrollToPlayer()

    function playerMoveUp() {
        var px = player.blockX
        var py = player.blockY
        var pc = mapProperty[py][px] // current block
        var pn = mapProperty[py - 1][px] // new block
        if (Math.abs(pc - pn) <= 1)
            return _scroll.__movePlayer(player.blockX, player.blockY - 1)
        return false
    }

    function playerMoveDown() {
        var px = player.blockX
        var py = player.blockY
        var pc = mapProperty[py][px]
        var pn = mapProperty[py + 1][px]
        if (Math.abs(pc - pn) <= 1)
            return _scroll.__movePlayer(player.blockX, player.blockY + 1)
        return false
    }

    function playerMoveLeft() {
        var px = player.blockX
        var py = player.blockY
        var pc = mapProperty[py][px]
        var pn = mapProperty[py][px - 1]
        if (Math.abs(pc - pn) <= 1)
            return _scroll.__movePlayer(player.blockX - 1, player.blockY)
        return false
    }

    function playerMoveRight() {
        var px = player.blockX
        var py = player.blockY
        var pc = mapProperty[py][px]
        var pn = mapProperty[py][px + 1]
        if (Math.abs(pc - pn) <= 1)
            return _scroll.__movePlayer(player.blockX + 1, player.blockY)
        return false
    }

    function activeMapItem(bX, bY) { _scroll.activeMapItem(bX, bY) }

    function resetNPC() { _scroll.__resetNpcs() }

    Component.onCompleted: {
        //console.log(width + " " + _scroll.width)
        //scrollX = (width - _scroll.width) / 2
        //console.log(scrollX)
        //scrollXChanged()
        //scrollYChanged()
    }

    //    onScrollXChanged: {
    //        var x = scrollX
    //        var w = self.width
    //        var a = _scroll.width
    //        /* if (x < 0)
    //            _scroll.x = 0
    //        else */ if (x + w > a)
    //            _scroll.x = a - w
    //        else
    //            _scroll.x = -x
    //        console.log("_scroll.x = " + _scroll.x + " " + x)
    //    }

    //    onScrollYChanged: {
    //       var y = scrollY
    //        var h = self.height
    //        var b = _scroll.height
    //        /* if (y < 0)
    //            _scroll.y = 0
    //        else */ if (y + h > b)
    //            _scroll.y = b - h
    //        else
    //            _scroll.y = -y
    //    }

    Item {
        // scroll object
        id: _scroll
        clip: true
        width: _map.width
        height: _map.height

        property Player player
        property list<MapItem> mapItems
        property list<MapWarp> mapWarps
        property list<NPC> npcs
        property real scrollX: 0
        property real scrollY: 0
        property real playerX: 0
        property real playerY: 0

        onPlayerChanged: {
            player.parent = this
        }

        onMapItemsChanged: {
            for (var i = 0; i < mapItems.length; ++i) {
                mapItems[i].parent = this
            }
        }

        onNpcsChanged: {
            for (var i = 0; i < npcs.length; ++i) {
                npcs[i].parent = this
            }
        }

        function __reset() {
            __resetPlayer()
            __resetItems()
            __resetNpcs()
            __scrollToPlayer()
        }

        function __resetPlayer() {
            player.x = getX(player.blockX)
            player.y = getY(player.blockY)
        }

        function __resetItems() {
            for (var i = 0; i < mapItems.length; ++i) {
                mapItems[i].x = getX(mapItems[i].blockX)
                mapItems[i].y = getY(mapItems[i].blockY)
                mapItems[i].width = __cw()
                mapItems[i].height = __ch()
            }
        }

        function __resetNpcs() {
            for (var i = 0; i < npcs.length; ++i) {
                npcs[i].x = getX(npcs[i].blockX)
                npcs[i].y = getY(npcs[i].blockY)
                if (npcs[i].intersect &&
                    player.blockX == npcs[i].blockX &&
                    player.blockY == npcs[i].blockY)
                        npcs[i].intersected()
            }
        }

        function __movePlayer(bX, bY) {
            if (__hasItem(bX, bY)) return false
            var npc = __hasNPC(bX, bY)
            if (npc && !npc.intersect) return false
            player.blockX = bX
            player.blockY = bY
            // __resetPlayer()
            player.moveX.to = getX(player.blockX)
            player.moveY.to = getY(player.blockY)
            __scrollToPlayer()
            var w = __hasWrap(bX, bY)
            if (w) {
                w.activated()
                send(w.receiver, w.message)
            }
            if (npc)
                npc.intersected()
            return true
        }

        function __scrollToPlayer() {
            if (width <= 0 || !isFinite(width) || height <= 0 || !isFinite(height))
                return
            var w = col
            var h = row
            var x = player.blockX
            var y = player.blockY
            var sw = parent.width / __cw()
            var sh = parent.height / __ch()

            if (w < sw) { // map width smaller than screen
                scrollX = (parent.width - mapWidth) / 2
            }
            else { // map width bigger than screen
                if (x < sw / 2)
                    scrollX = 0
                else if (x > w - sw / 2)
                    scrollX = -(w - sw) * __cw()
                else
                    scrollX = -(x - sw / 2) * __cw()
            }

            // map height smaller than screen
            if (h < sh) {
                scrollY = (parent.height - mapHeight) / 2
            }
            else { // map height bigger than screen
                if (y < sh / 2)
                    scrollY = 0
                else if (y > h - sh / 2)
                    scrollY = -(h - sh) * __ch()
                else
                    scrollY = -(y - sh / 2) * __ch()
            }
        }

        function __hasWrap(bX, bY) {
            // return MapWarp object if givin block position has warp
            for (var i = 0; i < mapWarps.length; ++i) {
                if (mapWarps[i].blockX == bX && mapWarps[i].blockY == bY) {
                    return mapWarps[i]
                }
            }
            return null
        }

        function __hasItem(bX, bY) {
            // return MapItem object if giving block position has item
            for (var i = 0; i < mapItems.length; ++i) {
                if (mapItems[i].blockX == bX && mapItems[i].blockY == bY) {
                    return mapItems[i]
                }
            }
            return null
        }

        function __hasNPC(bX, bY) {
            for (var i = 0; i < npcs.length; ++i) {
                if (npcs[i].blockX == bX && npcs[i].blockY == bY) {
                    return npcs[i]
                }
            }
            return null
        }

        function activeMapItem(bX, bY) {
            // active mapItem
            var it = __hasItem(bX, bY)
            if (it) it.activated()
            // active npc
            it = __hasNPC(bX, bY)
            if (it) it.activated()
        }

        Component.onCompleted: {
            __reset()
        }

        function __cw() { return width / col } // cell width
        function __ch() { return height / row } // cell height
        function getX(blockX) { return blockX * __cw() }
        function getY(blockY) { return blockY * __ch() }

        Image {
            id: _map
            width: implicitWidth
            height: implicitHeight
            fillMode: Image.Stretch
        }

        NumberAnimation on x { id: _moveX; duration: 200; onToChanged: start() }
        NumberAnimation on y { id: _moveY; duration: 200; onToChanged: start() }

        property bool __setX: false
        property bool __setY: false

        onScrollXChanged: {
            if (__setX)
                _moveX.to = scrollX
            else {
                x = scrollX
                __setX = true
            }
        }

        onScrollYChanged:  {
            if (__setY)
                _moveY.to = scrollY
            else {
                y = scrollY
                __setY = true
            }
        }
    }

    /*
    ListModel {
        id: _model
    }

    Component {
        id: _component

        Item {
            width: __cellWidth
            height: __cellHeight
            AnimatedSprite {
                source: self.source
                frameCount: 1
                frameWidth: self.blockWidth
                frameHeight: self.blockHeight
                running: false
                frameX: blockX
                frameY: blockY
                anchors.centerIn: parent
                width: __cellWidth
                height: __cellHeight
            }

            AnimatedSprite {
                source: self.source
                frameCount: 1
                frameWidth: self.blockWidth
                frameHeight: self.blockHeight
                running: false
                frameX: objX
                frameY: objY
                anchors.centerIn: parent
                width: __cellWidth
                height: __cellHeight
            }
        }


    }

    GridView {
        id: _grid
        interactive: false
        anchors.fill: parent
        cellWidth: __cellWidth
        cellHeight: __cellHeight
        model: _model
        delegate: _component

        Component.onCompleted: {
            var i, j, mapIndex, objIndex
            _model.clear()
            for (i = 0; i < row; ++i) {
                for (j = 0; j < col; ++j) {
                    mapIndex = mapData[i][j] // mapData[i * (row - 1) + j]
                    objIndex = objData[i][j] // objData[i * (row - 1) + j]
                    _model.append({
                        "blockX": Math.floor(mapIndex % blockRow - 1) * blockWidth,
                        "blockY": Math.floor(mapIndex / blockRow) * blockHeight,
                        "objX": Math.floor(objIndex % blockRow - 1) * blockWidth,
                        "objY": Math.floor(objIndex / blockRow) * blockHeight,
                    })
                }
            }
        }
    }
*/



    /*
    function reset() {
        // Re-create Map
        var i, j, tmp, index, indexRow, indexCol
        if (blocks) {
            for (i = 0; i < row; ++i) {
                for (j = 0; j < col; ++j) {
                    if (blocks[i][j])
                    blocks[i][j].destroy()
                }
            }
        }

        blocks = new Array(row)
        for (i = 0; i < row; ++i) {
            blocks[i] = new Array(col)
            for (j = 0; j < col; ++j) {
                index = mapData[i * row + j] + 1
                indexRow = Math.floor(index / blockRow)
                indexCol = Math.floor(index % blockRow - 1)

                tmp = tp.createObject(self)
                tmp.source = source
                tmp.width = Math.ceil(width / col)
                tmp.height = Math.ceil(height / row)
                tmp.imageX = indexRow * blockHeight
                tmp.imageY = indexCol * blockWidth
                tmp.imageWidth = tmp.imageImplicitWidth * tmp.width / blockWidth
                tmp.imageHeight = tmp.imageImplicitHeight * tmp.height / blockHeight
                tmp.x = i * tmp.width
                tmp.y = j * tmp.height
                console.log(tmp.x)
                blocks[i][j] = tmp
            }
        }
    }*/
}

