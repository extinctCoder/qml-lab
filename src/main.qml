import QtQuick
import theme

Rectangle {
    width: 320
    height: 200
    color: Colors.surface

    Rectangle {
        anchors.fill: parent
        anchors.margins: Spacing.edge
        color: Colors.surface_container
        border.color: Colors.outline_variant
        border.width: Shape.border
        radius: Shape.radius

        Text {
            text: "09:27"
            color: Colors.primary
            font.family: Type.family
            font.pixelSize: Type.display
        }
    }
}
