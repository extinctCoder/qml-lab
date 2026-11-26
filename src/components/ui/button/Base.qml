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

    selected: checkable && checked                  // Surface draws the selected look

    Interactive {
        parent: root
        anchors.fill: parent
        checkable: root.checkable
        checked: root.checked
        tint: root.tint
        onActivated: root.clicked()
    }
}
