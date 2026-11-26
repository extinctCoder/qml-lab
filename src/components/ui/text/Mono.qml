import QtQuick
import theme

Text {
    property string size: "body"
    property bool muted: false

    font.family: Type.family
    font.pixelSize: Type[size]
    color: muted ? Colors.on_surface_variant : Colors.on_surface
}
