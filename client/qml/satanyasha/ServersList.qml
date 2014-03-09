import QtQuick 2.0

Item {
  anchors.fill: parent
  ListView {
    id: server_view
    anchors.fill: parent
    model: servers_list_model
    delegate: Rectangle {
        width: parent.width
        color: (index%2 == 0)?main.s.c.blue_c2:main.s.c.blue_c1
        height: main.s.s(70);
        TextNormal {
            id: srv_id
            color: main.s.c.gold_d2
            anchors.left:  parent.left
            anchors.top: parent.top
            anchors.leftMargin: (ma && ma.pressed)?main.s.s(15+15):main.s.s(15)
            anchors.topMargin:  main.s.s(15)
            text: model.id
            transform: Rotation { origin.x: 0; origin.y: 0; angle: (ma && ma.pressed)?-5:0}
        }
        TextSmall {
            color: main.s.c.blue_d1
            anchors.left:  parent.left
            anchors.top: srv_id.bottom
            anchors.leftMargin: (ma && ma.pressed)?main.s.s(20+15):main.s.s(20)
            text: model.ip + ":" + model.port
            transform: Rotation { origin.x: 0; origin.y: 0; angle: (ma && ma.pressed)?2:0}
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            onClicked: {
                main.on_server_selected(model.id)
            }
        }
    }
  }
}
