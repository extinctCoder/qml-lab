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

    readonly property color disabled_container: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled_container)
    readonly property color disabled_content: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled)
    readonly property bool has_fill: look.fill !== "transparent"
    readonly property bool has_line: look.line !== "none"

    padding_x: Spacing.gap
    padding_y: Spacing.tight

    color: !enabled ? (has_fill || selected ? disabled_container : "transparent") : selected ? Colors.secondary_container : look.fill
    border.width: selected || has_line ? Shape.border : 0
    border.color: !enabled ? disabled_container : selected ? Colors.primary : has_line ? look.line : "transparent"

    Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        size: "label"
        color: !root.enabled ? root.disabled_content : root.selected ? Colors.on_secondary_container : root.look.label
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
