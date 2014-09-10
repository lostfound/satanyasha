import QtQuick 2.0

Rectangle {
  anchors.fill: parent
  color: main.s.c.blue_d1
  
  Grid {
    id: nav_grid
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: main.s.s(20)
    anchors.leftMargin: main.s.s(20)
    columns: 3
    spacing: main.s.s(20)
  
    UnicodeButton {
        id: button_play
        text: "►"
        color: main.s.c.gold_c1
        text_color: main.s.c.gold_d2
    }
    UnicodeButton {
        id: button_pause
        mirror:true
        text: "➠"
        color: main.s.c.gold_c1
        text_color: main.s.c.gold_d2
    }
    UnicodeButton {
        id: button_fullscreen
        text: "❂"
        color: main.s.c.green_c0
        text_color: main.s.c.green_d0
    }
    UnicodeButton {
        id: button_forward1
        text: "↣"
    }
    UnicodeButton {
        id: button_forward2
        text: "⇒"
        mirror: true
    }
    UnicodeButton {
        id: button_forward3
        text: "⇉"
    }
    UnicodeButton {
        id: button_rewind1
        text: "↢"
        da: -1
    }
    UnicodeButton {
        id: button_rewind2
        text: "⇐"
        da: -1
        mirror: true
    }
    UnicodeButton {
        id: button_rewind3
        text: "⇇"
        da: -1
    }
  }//nav_grid

  Grid {
    columns: 1
    spacing: main.s.s(20)
    anchors.left: nav_grid.right
    anchors.top: nav_grid.top
    anchors.leftMargin: main.s.s(20)
    UnicodeButton {
        id: button_next
        text: "↦"
        mirror: true
        color: main.s.c.gold_c1
        text_color: main.s.c.gold_d2
    }
    UnicodeButton {
        id: button_prev
        text: "↤"
        color: main.s.c.gold_c1
        text_color: main.s.c.gold_d2
    }
    UnicodeButton {
        id: button_quit
        text: "×"
        da: -1
        color: main.s.c.red_c1
        text_color: main.s.c.red_d2
    }
    UnicodeButton {
        id: button_osd
        text: "≡"
        color: main.s.c.green_c0
        text_color: main.s.c.green_d2
    }
    UnicodeButton {
        id: button_alert
        text: "!"
        da: -1
        color: main.s.c.red_a
        text_color: main.s.c.red_d2
    }
  }
  Grid {
    id: volume_grid
    rows: 1
    spacing: main.s.s(20)
    anchors.left: nav_grid.left
    anchors.top: nav_grid.bottom
    anchors.topMargin: main.s.s(20)
    anchors.leftMargin: main.s.s(20)

    UnicodeButton {
        id: button_increase_volume
        text: "⇑"
        da: -1
        color: main.s.c.red_c1
        text_color: main.s.c.red_d2
    }
    UnicodeButton {
        id: button_decrease_volume
        text: "⇓"
        da: -1
        mirror: true
        color: main.s.c.red_c1
        text_color: main.s.c.red_d2
    }
  }
  TextButton {
      id: button_openfile
      text: "Open"
      anchors.left: volume_grid.left
      anchors.right: volume_grid.right
      anchors.top: volume_grid.bottom
      anchors.topMargin: main.s.s(20)

      color: main.s.c.green_c0
      text_color: main.s.c.green_d2
  }

  function on_play_pause() {
      net.play_pause()
  }

  Component.onCompleted: {
      button_pause.clicked.connect(net.play_pause)
      button_play.clicked.connect(net.play)
      button_fullscreen.clicked.connect(net.fullscreen)
      button_forward1.clicked.connect(net.forward1)
      button_forward2.clicked.connect(net.forward2)
      button_forward3.clicked.connect(net.forward3)
      button_rewind1.clicked.connect(net.rewind1)
      button_rewind2.clicked.connect(net.rewind2)
      button_rewind3.clicked.connect(net.rewind3)
      button_decrease_volume.clicked.connect(net.decvol)
      button_increase_volume.clicked.connect(net.incvol)
      button_next.clicked.connect(net.next)
      button_prev.clicked.connect(net.prev)
      button_openfile.clicked.connect(main.go_to_files)
      button_osd.clicked.connect(net.next_osd)
      button_quit.clicked.connect(net.quit)
      button_alert.clicked.connect(net.alert)


  }
}
