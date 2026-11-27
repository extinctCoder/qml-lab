pragma Singleton
import QtQuick

// M3 state-layer opacities. The Tui delegates paint `on_surface` at these alphas
// over a control to signal current/pressed. Keyboard focus reuses the hover layer
// (keyboard-first: a focused control looks hovered), so focus == hover here.
QtObject {
    readonly property real hover: 0.08
    readonly property real focus: 0.08
    readonly property real pressed: 0.10
    readonly property real disabled: 0.38
    readonly property real disabled_container: 0.12

    readonly property color disabled_text: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled)
    readonly property color disabled_fill: Qt.rgba(Colors.on_surface.r, Colors.on_surface.g, Colors.on_surface.b, disabled_container)
}
