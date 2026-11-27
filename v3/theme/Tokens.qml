pragma Singleton
import QtQuick

// Only what Qt's palette has NO role for. Colour lives in the native palette
// (theme/Theme.qml); this holds the gaps: status colours, overlay opacities, and
// the geometry/motion/type scales Qt simply doesn't provide.
QtObject {
    // ── status colours (Qt palette has no error/success/warning role) ──────
    readonly property color error: "#f38ba8"
    readonly property color on_error: "#11111b"
    readonly property color success: "#a6e3a1"
    readonly property color warning: "#f9e2af"

    // ── state overlay opacities (palette carries colours, not overlay alphas) ─
    readonly property real hover: 0.08
    readonly property real pressed: 0.10

    // ── spacing · 4px grid ─────────────────────────────────────────────────
    readonly property int tight: 4
    readonly property int inner: 8
    readonly property int gap: 12
    readonly property int edge: 16

    // ── shape ──────────────────────────────────────────────────────────────
    readonly property int radius: 2
    readonly property int border: 1
    readonly property int focus: 2

    // ── motion ─────────────────────────────────────────────────────────────
    readonly property int motion_small: 100
    readonly property int motion_open: 200
    readonly property int motion_close: 150
    readonly property int ease_out: Easing.OutCubic
    readonly property int ease_in: Easing.InCubic

    // ── type scale ─────────────────────────────────────────────────────────
    readonly property string family: "FiraCode Nerd Font"
    readonly property int label: 12
    readonly property int body: 13
    readonly property int title: 15
    readonly property int display: 40
}
