pragma Singleton
import QtQuick

// A value that moves on its own: the clock ticks every second.
QtObject {
    id: root

    property string clock: "--:--"
    property string day: ""

    function tick() {
        const d = new Date()
        root.clock = Qt.formatTime(d, "HH:mm")
        root.day = Qt.formatDate(d, "dddd, MMMM d").toLowerCase()
    }

    property Timer _timer: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.tick()
    }

    Component.onCompleted: root.tick()
}
