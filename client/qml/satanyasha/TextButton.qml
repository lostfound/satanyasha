import QtQuick 2.0

Rectangle {
    height: main.s.s(50)
    radius: main.s.s(10)
    signal clicked()
    property color  text_color: main.s.c.blue_d1
    property string text: "button"
    property int a: -5
    property int megabig: 0
    property int ox: 0
    property int oy: 0

    color: main.s.c.blue_c1
    TextBig {
        color: parent.text_color
        text: parent.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        transform: Rotation { origin.x: 0; origin.y: 0; angle: (ma && ma.pressed)?-a:0}
        Component.onCompleted: {
            if (parent.megabig != 0) font.pixelSize = main.s.s(42)
        }
    }
    MouseArea {
        id: ma
        anchors.fill:parent
        onClicked: {
            parent.clicked()
        }
    }
    transform: Rotation { origin.x: ox; origin.y: oy; angle: (ma && ma.pressed)?a:0}

}
