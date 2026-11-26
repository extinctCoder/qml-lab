import QtQuick
import theme
import components.ui
import components.ui.text
import components.behaviors

Surface {
    id: root

    property string text: ""
    property string variant: "primary"
    property bool checkable: false
    property bool checked: false
    signal clicked

    readonly property var look: ({
            primary: {
                fill: Colors.primary,
                label: Colors.on_primary,
                line: "none"
            },
            tonal: {
                fill: Colors.secondary_container,
                label: Colors.on_secondary_container,
                line: "none"
            },
            outline: {
                fill: "transparent",
                label: Colors.primary,
                line: Colors.outline
            },
            ghost: {
                fill: "transparent",
                label: Colors.primary,
                line: "none"
            },
            danger: {
                fill: "transparent",
                label: Colors.error,
                line: Colors.error
            }
        })[variant]
    readonly property bool selected: checkable && checked

    padding_x: Spacing.gap
    padding_y: Spacing.tight

    color: selected ? Colors.secondary_container : look.fill
    border.width: selected || look.line !== "none" ? Shape.border : 0
    border.color: selected ? Colors.primary : look.line === "none" ? "transparent" : look.line
    opacity: enabled ? 1 : States.disabled

    Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        size: "label"
        color: root.selected ? Colors.on_secondary_container : root.look.label
    }

    Interactive {
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        tint: label.color
        onActivated: root.clicked()
    }
}
