import QtQuick

Base {
    id: root

    property int count: 0
    property int max: 99
    property bool error: false

    visible: count > 0
    look: error ? "alarm" : "filled"
    text: count > max ? max + "+" : String(count)
}
