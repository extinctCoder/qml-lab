import QtQuick
import QtQuick.Controls
import theme

// The theme, injected ONCE. Qt Quick Controls read their palette from the QML
// object tree (NOT the C++ app palette, NOT a config file — both are ignored).
// So this sets the native palette on the root, and Qt propagates it down to
// every control inside automatically. Wrap a window's content in `Theme { }`.
// These are Qt's own palette role names — zero translation.
//
// FINALISED for the Fusion style (QQuickStyle "Fusion" — the one built-in that
// honours this palette). Verified against the full state matrix in
// gallery/StatesTest.qml: every control × { default, pressed, checked, accent,
// focus, selected, disabled } — zero contrast breakage. Text-on-green uses dark
// roles (brightText + highlightedText = crust) so highlighted fills stay legible.
// Known Fusion exception: Dial renders its body in a hardcoded periwinkle and
// ignores accent — not palette-controllable; avoid Dial or override it in a thin
// style file if a knob is ever needed.
Pane {
    id: root

    padding: 0
    font.family: Tokens.family
    font.pixelSize: Tokens.body

    palette {
        window: "#1e1e2e"          // base   — app background
        windowText: "#cdd6f4"      // text   — primary foreground
        base: "#181825"            // mantle — input field wells
        alternateBase: "#313244"   // surface0 — striped rows
        button: "#313244"          // surface0 — button face
        buttonText: "#cdd6f4"
        brightText: "#11111b"       // crust — Fusion uses this as the label ON a green fill
        text: "#cdd6f4"
        accent: "#a6e3a1"          // green  — focus / checked emphasis
        highlight: "#a6e3a1"       // green  — selection / checked bg
        highlightedText: "#11111b" // crust  — text on the green
        placeholderText: "#7f849c" // overlay1
        light: "#585b70"           // surface2
        midlight: "#45475a"        // surface1
        mid: "#6c7086"             // overlay0 — borders
        dark: "#11111b"            // crust
        shadow: "#11111b"
        link: "#89b4fa"            // blue
        toolTipBase: "#313244"
        toolTipText: "#cdd6f4"

        disabled {
            windowText: "#6c7086"
            text: "#6c7086"
            buttonText: "#6c7086"
            base: "#181825"
            button: "#232334"
        }
    }

    background: Rectangle {
        color: root.palette.window
    }
}
