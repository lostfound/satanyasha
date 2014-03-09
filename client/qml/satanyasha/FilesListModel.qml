import QtQuick 2.0

ListModel {
    function parse_json(json) {
        var obj = JSON.parse(json)
        for (var i=0; i<obj.dirs.length; i++) {
            append(obj.dirs[i])
        }
        for (var i=0; i<obj.files.length; i++) {
            append(obj.files[i])
        }
        main.set_caption(obj.name)
        main.path = obj.pwd
    }
}
