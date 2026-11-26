import QtQuick
import theme
import components.ui

Text {
    id: root

    property string size: "body"
    property bool muted: false
    property bool surface: false

    font.family: Type.family
    font.pixelSize: Type[size]
    color: muted ? Colors.on_surface_variant : Colors.on_surface
    wrapMode: Text.Wrap
    padding: surface ? Spacing.inner : 0

    Surface {
        visible: root.surface
        anchors.fill: parent
        z: -1
    }
}
