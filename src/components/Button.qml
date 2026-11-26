import QtQuick
import theme

Rectangle {
    id: root

    property string text: ""
    property string variant: "primary"
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

    implicitWidth: label.implicitWidth + Spacing.gap * 2
    implicitHeight: label.implicitHeight + Spacing.tight * 2
    radius: Shape.radius
    color: look.fill
    border.width: look.line === "none" ? 0 : Shape.border
    border.color: look.line === "none" ? "transparent" : look.line
    opacity: enabled ? 1 : 0.38
    activeFocusOnTab: true

    Rectangle {
        anchors.fill: parent
        radius: Shape.radius
        color: root.look.label
        opacity: tap.pressed ? 0.10 : hover.hovered ? 0.08 : 0
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -(Shape.focus + 1)
        radius: Shape.radius + Shape.focus
        color: "transparent"
        border.width: Shape.focus
        border.color: Colors.primary
        visible: root.activeFocus
    }

    Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        size: "label"
        color: root.look.label
    }

    HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
    }

    TapHandler {
        id: tap
        onTapped: root.clicked()
    }

    Keys.onReturnPressed: root.clicked()
    Keys.onSpacePressed: root.clicked()
}
