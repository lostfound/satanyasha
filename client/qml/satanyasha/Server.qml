import QtQuick 2.0

Rectangle {
  anchors.fill: parent
  color: main.s.c.green_c0
  Item {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.topMargin: main.s.s(20)
    anchors.rightMargin: main.s.s(20)
    anchors.leftMargin: main.s.s(20)

    TextBig {
       id: password_label
       anchors.left: parent.left
       anchors.leftMargin: main.s.s(10)
       anchors.right: parent.right
       anchors.top: parent.top
       text: "PASSWORD:"
       color: main.s.c.green_d3
    }
    Rectangle {
       id: pass_rect
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.top: password_label.bottom
       anchors.topMargin: main.s.s(10)
       height: main.s.s(50)
       color: main.s.c.green_c2
       radius: main.s.s(10)
       border.width: 2
       border.color: main.s.c.green_d2
       TextInput {
          id: pass_field;
          focus: true
          text: "liserginka";
          color: main.s.c.green_d2
          anchors.top: parent.top;
          anchors.bottom: parent.bottom;
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin:  main.s.s(10)
          anchors.rightMargin: main.s.s(10)

          verticalAlignment: TextInput.AlignVCenter

          font.pixelSize: main.s.s(24)
          font.family: fnt.name
          inputMethodHints: Qt.ImhNoPredictiveText;
          echoMode: TextInput.Password
        }
    }
    TextButton {
        id: button_connect
        anchors.right: pass_rect.right
        anchors.top: pass_rect.bottom
        anchors.topMargin: main.s.s(10)
        width: main.s.s(120)
        text: "Connect"
    }
  }
  function on_login() {
      var password = pass_field.text
      console.log(password)
      main.connect_to_server(password);
  }

  Component.onCompleted: {
      button_connect.clicked.connect(on_login)
  }

}
