import QtQuick 2.0

ListModel {
    function add_json(json) {
        append(JSON.parse(json))

    }
}
