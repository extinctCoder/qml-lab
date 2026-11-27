import QtQuick
import QtQuick.Layouts
import theme

// A quick-settings toggle tile (GNOME-style): title + state line, one click to
// act. Active fills with the accent; inactive is a plain surface.
Rectangle {
    id: tile

    property string title
    property string subtitle
    property bool active: false
    signal clicked()

    implicitWidth: 150
    implicitHeight: 56
    radius: Shape.radius
    color: active ? Colors.primary : Colors.surface_container_high
    border.width: Shape.border
    border.color: active ? Colors.primary : Colors.outline_variant

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Spacing.inner
        spacing: 0

        Text {
            text: tile.title
            color: tile.active ? Colors.on_primary : Colors.on_surface
            font.family: Type.family
            font.pixelSize: Type.body
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
        Text {
            text: tile.subtitle
            color: tile.active ? Colors.on_primary : Colors.on_surface_variant
            opacity: tile.active ? 0.8 : 1
            font.family: Type.family
            font.pixelSize: Type.label
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: tile.active ? Colors.on_primary : Colors.on_surface
        opacity: ma.pressed ? States.pressed : ma.containsMouse ? States.hover : 0
        Behavior on opacity { NumberAnimation { duration: Motion.small } }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onClicked: tile.clicked()
    }
}
