import QtQuick 2.0

Item {
  anchors.fill: parent
  Item {
      id: manual_srv
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: main.s.s(120)
      TextNormal {
          id: label_ip
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: main.s.s(10)
          anchors.leftMargin: main.s.s(10)
          color: main.s.c.gold_c1
          text:  "IPv4 Address"
      }
      Rectangle {
        id: rect_ip
        anchors.left: label_ip.left
        anchors.leftMargin: main.s.s(3)
        anchors.top: label_ip.bottom
        width: main.s.s(200)
        height: main.s.s(30)
        color: main.s.c.blue_c2
        radius: main.s.s(7)
        border.width: 2
        border.color: main.s.c.gold_c1
        TextInput {
          id: inp_ip
          focus: true
          text: net.get_setting("ip")
          color: main.s.c.green_d2
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin:  main.s.s(10)
          anchors.rightMargin: main.s.s(10)

          verticalAlignment: TextInput.AlignVCenter

          font.pixelSize: main.s.s(16)
          font.family: fnt.name
          //inputMethodHints: Qt.ImhNoPredictiveText;
          inputMethodHints: Qt.ImhFormattedNumbersOnly|Qt.ImhNoPredictiveText;
          Keys.onReturnPressed: {
            inp_port.forceActiveFocus()
          }

        }

      }

      TextNormal {
          id: label_port
          anchors.top: parent.top
          anchors.topMargin: main.s.s(10)
          anchors.right: parent.right
          anchors.rightMargin: main.s.s(10)
          color: main.s.c.gold_c1
          text:  "port"
      }
      Rectangle {
        id: rect_port
        anchors.right: label_port.right
        anchors.rightMargin: main.s.s(3)
        anchors.top: label_port.bottom
        width: main.s.s(80)
        height: main.s.s(30)
        color: main.s.c.blue_c2
        radius: main.s.s(7)
        border.width: 2
        border.color: main.s.c.gold_c1
        TextInput {
          id: inp_port
          focus: true
          text: net.get_setting("port")
          color: main.s.c.green_d2
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin:  main.s.s(10)
          anchors.rightMargin: main.s.s(10)

          verticalAlignment: TextInput.AlignVCenter

          font.pixelSize: main.s.s(16)
          font.family: fnt.name
          inputMethodHints: Qt.ImhFormattedNumbersOnly|Qt.ImhNoPredictiveText;
          Keys.onReturnPressed: {
            inp_passwd.forceActiveFocus()
          }

        }

      }
      TextNormal {
          id: label_passwd
          anchors.top: rect_ip.bottom
          anchors.left: label_ip.left
          anchors.topMargin: main.s.s(3)
          color: main.s.c.gold_c1
          text:  "Password"
      }
      Rectangle {
        id: rect_passwd
        anchors.left: label_passwd.left
        anchors.leftMargin: main.s.s(3)
        anchors.top: label_passwd.bottom
        width: main.s.s(200)
        height: main.s.s(30)
        color: main.s.c.blue_c2
        radius: main.s.s(7)
        border.width: 2
        border.color: main.s.c.gold_c1
        TextInput {
          id: inp_passwd
          focus: true
          text: net.get_setting("password")//"liserginka";
          color: main.s.c.green_d2
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin:  main.s.s(10)
          anchors.rightMargin: main.s.s(10)

          verticalAlignment: TextInput.AlignVCenter

          font.pixelSize: main.s.s(16)
          font.family: fnt.name
          inputMethodHints: Qt.ImhNoPredictiveText;
          echoMode: TextInput.Password

        }

      }
      TextButton {
          id: button_connect
          anchors.right: rect_port.right
          anchors.top: rect_port.bottom
          anchors.topMargin: main.s.s(10)
          width: main.s.s(120)
          text: "Connect"
      }
  }
  Component.onCompleted: {
      button_connect.clicked.connect(on_login)
  }
  function on_login() {
      var ip = inp_ip.text
      var port=inp_port.text
      var password=inp_passwd.text
      Qt.inputMethod.hide()
      net.connectToServer(ip, port, password)
  }
  function get_id() {
      var ip = inp_ip.text
      var port=inp_port.text
      return "[" + ip + ":" + port + "]"
  }

  ListView {
    id: server_view
    anchors.top: manual_srv.bottom
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
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
