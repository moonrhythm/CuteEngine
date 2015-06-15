.pragma library

var __objs = []
var __countID = 0
var __countLength = 8
var __countString = "00000000"

String.format = function() {
    var s = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        s = s.replace(regEx, arguments[i]);
    }
    return s;
}

function getID() {
    return __countID++
}

function getIDString(obj) {
    return obj.__className + "@" + (__countString + obj.__id.toString(16)).substring(-__countLength)
}

function __findObjectFromID(id) {
    for (var i = 0; i < __objs.length; ++i) {
        if (__objs[i].__id === id) return i
    }
    return -1
}

function __findObjectFromName(name) {
    for (var i = 0; i < __objs.length; ++i) {
        if (__objs[i].name === name) return i
    }
    return -1
}

function __send(name, msg) {
    // var sender = args.sender
    // var receiver = args.receiver
    // var cmd = args.cmd
    // var value = args.value
    // var i = __findObjectFromName(receiver)
    var i = __findObjectFromName(name)
    // console.log(String.format("[Transitor] __send: \{sender: {0}, receiver: {1}, cmd: {2}, value: {3}\}", sender, receiver, cmd, value))
    // __objs[i].__handle({sender: sender, receiver: receiver, cmd: cmd, value: value})
    __objs[i].__handle(msg)
}

function addObject(obj) {
    __objs.push(obj)
    // console.log("[Transitor] addObject: " + obj.getIDString())
    // console.log(__objs.toString())
}

function removeObject(obj) {
    var i = __findObjectFromID(obj.__id)
    if (i !== -1) __objs.splice(i, 1)
    // console.log("[Transitor] removeObject: " + obj.getIDString())
}
