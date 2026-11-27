import QtQuick
import theme
import components.ui
import components.behaviors

Surface {
    id: root

    property bool checkable: false
    property bool checked: false
    property Roving roving: null
    property bool highlighted: false
    property bool focusable: true
    readonly property bool hovered: interactive.hovered
    readonly property Item focus_target: interactive
    signal clicked

    selected: checkable && checked
    current: interactive.current
    pressed: interactive.pressed

    Interactive {
        id: interactive
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        roving: root.roving
        highlighted: root.highlighted
        focusable: root.focusable
        onActivated: root.clicked()
    }
}
