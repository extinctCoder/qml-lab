import QtQuick
import theme

Item {
    id: root

    property bool on: false
    property color on_color: Colors.primary
    property color off_color: Colors.outline
    readonly property color tone: !enabled ? States.disabled_text : on ? on_color : off_color
}
