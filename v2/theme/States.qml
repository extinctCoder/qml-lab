pragma Singleton
import QtQuick

QtObject {
    readonly property real hover: 0.08
    readonly property real pressed: 0.10
    readonly property real disabled: 0.38
    readonly property real disabled_container: 0.12

    readonly property color disabled_text: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled)
    readonly property color disabled_fill: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled_container)
}
