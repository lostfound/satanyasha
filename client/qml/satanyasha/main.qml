import QtQuick 2.0
import lsd.satanyasha 1.0

Rectangle {
    id: main
    property int is_compleated: 0
    property var place: {"id": "menu"}
    property string sid: ""
    property string path: ""
    focus: true
    //property string json_data: "{}"
    FontLoader { id: fnt; source: "fonts/AnonymousPro-Regular.ttf";}
    NetControl {
        id: net;
    }
    Style {
        id: style
    }
    property QtObject s: style
    color: s.c.blue_d1

    ServersListModel {
        id: servers_list_model
    }
    FilesListModel {
        id: files_list_model
    }

    MouseArea {
        anchors.fill:parent
    }


    Loader {
        id: body
        anchors.left:  parent.left
        anchors.right: parent.right
        anchors.top:   header.bottom
        anchors.bottom: parent.bottom
    }
    Rectangle {
        id: header
        anchors.left:  parent.left
        anchors.right: parent.right
        height: main.s.s(80)
        color: main.s.c.gold_d3
        TextBig {
            id: caption
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: main.s.c.gold_b
            text: "Сервера"
        }
    }

    function on_server_discovered(json) {
        servers_list_model.add_json(json)
    }
    function on_server_selected(server_id) {
        console.log(server_id)
        caption.text = server_id
        place = {"id": "server", "sid": server_id}
        sid = server_id
        body.setSource("Server.qml")
    }
    function back_to_menu(){
        caption.text = sid
        place = {"type": "menu"}
        body.setSource("ControlMenu.qml")
    }

    function connect_to_server(password) {
        var server_id = place.sid
        if (!server_id) {
            return;
        }
        net.connectToServer(server_id, password);
    }
    function on_files(json)
    {
        place = {"type": "files"}
        files_list_model.clear()
        body.setSource("FilesModel.qml")
        files_list_model.parse_json(json)
    }
    function set_caption(name) {
        caption.text = name
    }
    function go_to_files() {
        if (path.length === 0) {
            net.get_files()
        }else {
            net.lsdir(path)
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            console.log(place.type)
            if (place.type === "files") {
                back_to_menu()
            } else {
                Qt.quit()
            }
            event.accepted = true
        }
    }
    Component.onCompleted: {
        is_compleated = 1
        on_completed()
    }
    function on_authorized() {
        console.log("Authorized")
        place = {"type": "menu"}
        body.setSource("ControlMenu.qml")
    }
    function on_error(msg) {
        console.log(msg);
    }
    function on_playpause() {
        net.play_pause()
    }

    function on_completed() {
        if (is_compleated === 1 && width != 0 && height != 0) {
          main.s.init()
          header.height = main.s.s(80)
          caption.font.pixelSize = main.s.s(24)
          body.setSource("ServersList.qml")
          is_compleated = 2;
          net.server_discovered.connect(on_server_discovered)
          net.authorized.connect(on_authorized)
          net.files_received.connect(on_files)
          net.startUdpReceiver();
        }
    }

    onWidthChanged: {
        on_completed()
    }
    onHeightChanged: {
        on_completed()
    }
}
