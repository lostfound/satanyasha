import QtQuick 2.0

TextButton {
    width: main.s.s(60)
    megabig: 1
    property bool mirror: false
    property int da: 1
    a: (mirror==false)?-da*12:da*12
    ox: (mirror==false)?0:width

}
