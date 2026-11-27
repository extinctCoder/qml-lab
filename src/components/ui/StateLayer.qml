import QtQuick
import theme
import components.behaviors

// The one and only "you are here" look. A single tint that marks the CURRENT
// element — hovered, keyboard-highlighted, or keyboard-focused, all the same
// state, drawn one way — and a stronger tint while pressed. Every interactive
// component shows its current/pressed state through this and nothing else:
// Surface embeds one, and things that aren't a Surface (a tab, a slider's bar)
// place one themselves. It is fed by Interactive's reported `current`/`pressed`.
// There is no second mechanism — no focus ring, no per-family hover.
Rectangle {
    property bool current: false
    property bool pressed: false
    property color tint: Colors.on_surface

    color: tint
    opacity: !enabled ? 0 : pressed ? States.pressed : current ? States.hover : 0

    Behavior on opacity {
        Glide {}
    }
}
