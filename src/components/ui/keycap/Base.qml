import QtQuick
import theme
import components.ui
import components.ui.text as Text

// A single keyboard key: a small framed, level-4 box with a thin accent along
// its bottom edge, so it reads as a key, not a tag. For keybind hints and
// cheatsheets — on-brand for a keyboard-first shell. A single character sits in
// a square; longer labels (ctrl, ↵) stretch to fit.
Surface {
    id: root

    property string text: ""

    appearance: "outlined"
    level: 4
    padding_x: Spacing.tight + 1
    padding_y: 1

    Text.Mono {
        id: label
        text: root.text
        size: "label"
        horizontalAlignment: Qt.AlignHCenter
        width: Math.max(implicitWidth, label.implicitHeight)

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.topMargin: 1
            height: Shape.border
            color: Colors.outline_variant
        }
    }
}
