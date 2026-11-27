import QtQuick
import theme
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

    Interactive {
        anchors.fill: parent
        checkable: true
        checked: root.active
        keys: ["enter", "space"]
        tint: label.color
        roving: root.roving
        onActivated: root.clicked()
    }
}
