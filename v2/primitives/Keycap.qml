import QtQuick
import theme

// A keyboard key: a small framed box with a thin accent along the bottom edge,
// so it reads as a key. For keybind hints — on-brand for a keyboard-first shell.
Rectangle {
    id: root

    property string text: ""

    implicitWidth: Math.max(label.implicitWidth + (Spacing.tight + 1) * 2, implicitHeight)
    implicitHeight: label.implicitHeight + 1 * 2 + 2
    radius: Shape.radius
    color: Colors.surface_container_high
    border.width: Shape.border
    border.color: Colors.outline_variant

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: Colors.on_surface
        font.family: Type.family
        font.pixelSize: Type.label
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Shape.border
        height: Shape.border
        color: Colors.outline_variant
    }
}
