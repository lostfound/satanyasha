import QtQuick 2.0
Item {
  anchors.fill: parent
  ListView {
    anchors.fill: parent
    model: files_list_model
    delegate: Rectangle {
        width: parent.width
        color: {
            if  (model.type === "dir")
              return (index%2 == 0)?main.s.c.gold_c2:main.s.c.blue_c2

            return (index%2 == 0)?main.s.c.green_c2:main.s.c.green_c1
        }
        height: main.s.s(70);
        Item {
          anchors.left:  parent.left
          anchors.top: parent.top
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.leftMargin: (ma && ma.pressed)?main.s.s(15+15):main.s.s(15)
          anchors.topMargin:  main.s.s(10)
          anchors.bottomMargin:  main.s.s(5)
          anchors.rightMargin:   main.s.s(10)
          transform: Rotation { origin.x: 0; origin.y: 0; angle: (ma && ma.pressed)?5:0}
          TextNormal {
              anchors.fill: parent
              id: srv_id
              color: main.s.c.gold_d2
              wrapMode: Text.Wrap
              text: model.name
              maximumLineCount : 2
          }
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            onClicked: {
                if (model.type==="dir") {
                    net.lsdir(model.path)
                } else {
                    net.play_file(model.path)
                    main.back_to_menu()
                }
            }
        }
    }
  }
}
