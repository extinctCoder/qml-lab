import QtQuick
import theme
import components.ui
import components.behaviors

Surface {
    id: root

    property bool checkable: false
    property bool checked: false
    property color tint: Colors.on_surface
    signal clicked

    readonly property bool selected: checkable && checked

    readonly property color disabled_container: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled_container)
    readonly property color disabled_content: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, States.disabled)

    Interactive {
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        tint: root.tint
        onActivated: root.clicked()
    }
}
