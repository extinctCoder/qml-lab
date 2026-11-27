import QtQuick
import theme
import components.ui
import components.behaviors
import components.ui.text as Text

Item {
    id: root

    property string text: ""
    property bool active: false
    property Roving roving: null
    readonly property alias word: label
    signal clicked

    implicitWidth: label.implicitWidth + Spacing.gap * 2 - 2
    implicitHeight: label.implicitHeight + Spacing.inner * 2 + 2

    Text.Mono {
        id: label
        anchors.centerIn: parent
        text: root.text
        tone: root.active ? Colors.on_surface : Colors.on_surface_variant

        Behavior on color {
            ColorGlide {}
        }
    }

    StateLayer {
        anchors.fill: parent
        radius: Shape.radius
        tint: label.color
        current: tab_input.current
        pressed: tab_input.pressed
    }

    Interactive {
        id: tab_input
        anchors.fill: parent
        checkable: true
        checked: root.active
        keys: ["enter", "space"]
        roving: root.roving
        onActivated: root.clicked()
    }
}
