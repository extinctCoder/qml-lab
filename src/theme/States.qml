pragma Singleton
import QtQuick

// The state layers and the disabled look (Material 3).
// hover / pressed: the tint over something you point at or press.
// disabled: content at 38 % and containers or outlines at 12 % of on_surface,
// as ready-made colors (disabled_text, disabled_fill), so every component uses the same.
QtObject {
    readonly property real hover: 0.08
    readonly property real pressed: 0.10
    readonly property real disabled: 0.38
    readonly property real disabled_container: 0.12

    readonly property color disabled_text: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled)
    readonly property color disabled_fill: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled_container)
}
