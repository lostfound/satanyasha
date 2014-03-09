import QtQuick 2.0

Rectangle {
  anchors.fill: parent
  color: main.s.c.blue_d1
  UnicodeButton {
      id: button_play
      text: "►"
      color: main.s.c.gold_c1
      text_color: main.s.c.gold_d2
      anchors.left: parent.left
      anchors.top: parent.top
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_pause
      mirror:true
      text: "➠"
      color: main.s.c.gold_c1
      text_color: main.s.c.gold_d2
      anchors.left: button_play.right
      anchors.top: parent.top
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_fullscreen
      text: "❂"
      color: main.s.c.green_c0
      text_color: main.s.c.green_d0
      anchors.left: button_pause.right
      anchors.top: parent.top
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_forward1
      text: "↣"
      anchors.left: parent.left
      anchors.top: button_play.bottom
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_forward2
      text: "⇒"
      mirror: true
      anchors.left: button_forward1.right
      anchors.top: button_forward1.top
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_forward3
      text: "⇉"
      anchors.left: button_forward2.right
      anchors.top: button_forward1.top
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_rewind1
      text: "↢"
      da: -1
      anchors.left: parent.left
      anchors.top: button_forward1.bottom
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_rewind2
      text: "⇐"
      da: -1
      mirror: true
      anchors.left: button_rewind1.right
      anchors.top: button_rewind1.top
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_rewind3
      text: "⇇"
      da: -1
      anchors.left: button_rewind2.right
      anchors.top: button_rewind1.top
      anchors.leftMargin: main.s.s(20)
  }

  UnicodeButton {
      id: button_next
      text: "↦"
      mirror: true
      color: main.s.c.gold_c1
      text_color: main.s.c.gold_d2
      anchors.left: button_fullscreen.right
      anchors.top: parent.top
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_prev
      text: "↤"
      color: main.s.c.gold_c1
      text_color: main.s.c.gold_d2
      anchors.left: button_fullscreen.right
      anchors.top: button_next.bottom
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }

  UnicodeButton {
      id: button_increase_volume
      text: "⇑"
      da: -1
      color: main.s.c.red_c1
      text_color: main.s.c.red_d2
      anchors.left: button_rewind1.left
      anchors.top: button_rewind1.bottom
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  UnicodeButton {
      id: button_decrease_volume
      text: "⇓"
      da: -1
      mirror: true
      color: main.s.c.red_c1
      text_color: main.s.c.red_d2
      anchors.left: button_increase_volume.right
      anchors.top: button_rewind1.bottom
      anchors.topMargin: main.s.s(20)
      anchors.leftMargin: main.s.s(20)
  }
  TextButton {
      id: button_openfile
      text: "Open"
      anchors.left: button_increase_volume.left
      anchors.right: button_decrease_volume.right
      anchors.top: button_decrease_volume.bottom
      anchors.topMargin: main.s.s(20)

      color: main.s.c.green_c0
      text_color: main.s.c.green_d1
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


  }
}
