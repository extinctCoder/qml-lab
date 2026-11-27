import QtQuick
import theme
import components.ui
import components.behaviors

Surface {
    id: root

    property bool checkable: false
    property bool checked: false
    property color tint: Colors.on_surface
    property Roving roving: null
    signal clicked

    selected: checkable && checked

    Interactive {
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        tint: root.tint
        roving: root.roving
        onActivated: root.clicked()
    }
}
