import QtQuick 2.0

QtObject {
    id: me
    property QtObject c: QtObject {
        property color gold_a: "#fec400"
        property color gold_b: "#c49803"
        property color gold_c0: "#c2aa4a"
        property color gold_c1: "#c3b37f"
        property color gold_c2: "#c3b996"
        property color gold_c3: "#c4bea4"
        property color gold_d0: "#796830"
        property color gold_d1: "#4a442e"
        property color gold_d2: "#2c2c22"
        property color gold_d3: "#1c1b17"
        property color turquoise_a: "#00ffb9"
        property color turquoise_b: "#02c48f"

        property color blue_a : "#0011ff"
        property color blue_b : "#0111be"
        property color blue_c0: "#4c54c3"
        property color blue_c1: "#7a7fc3"
        property color blue_c2: "#9699c2"
        property color blue_c3: "#a7a9c2"
        property color blue_d0: "#2d3478"
        property color blue_d1: "#2c3049"
        property color blue_d2: "#252330"
        property color blue_d3: "#19161d"

        property color green_a : "#7aff00"
        property color green_b : "#5fc502"
        property color green_c0: "#87c44b"
        property color green_c1: "#9ec47b"
        property color green_c2: "#aec398"
        property color green_c3: "#b4c4a7"
        property color green_d0: "#537930"
        property color green_d1: "#3c4b2e"
        property color green_d2: "#212f22"
        property color green_d3: "#1a1c17"

        property color red_a : "#ff011d"
        property color red_b : "#c4021a"
        property color red_c0: "#c44c56"
        property color red_c1: "#c57983"
        property color red_c2: "#c6949d"
        property color red_c3: "#c4a7ab"
        property color red_d0: "#782f38"
        property color red_d1: "#4b2e32"
        property color red_d2: "#2d2322"
        property color red_d3: "#1d1719"
    }
    function s(size) {
        return size*zoom
    }
    property double zoom: 1
    function init() {
        zoom = ((main.width<main.height)?main.width:main.height)/360
    }
}
