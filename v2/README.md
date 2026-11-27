# qml-lab v2

A desktop design system for a TUI-style shell, built the Qt-native way: **a custom
Qt Quick Controls style**. Qt's Templates provide all behaviour, state, keyboard
and accessibility; we provide the tokens and the flat, square, dense look.

v2 is self-sufficient — it depends on nothing in the old `src/`.

## Layout

```
theme/        tokens: Colors, Type, Spacing, Shape, Motion, States (singletons)
Tui/          the style: one QML file per control, each rooted on a QtQuick.Templates type
primitives/   bespoke non-control bits: Keycap, charts, Divider, Image
gallery/      every control + primitive in its states (fake data)
dev.py        live-reload runner
```

## Run

```
uv run v2/dev.py
```

The runner sets the `Tui` style and loads the gallery; unstyled controls fall back
to the Basic style while we build.

## Read first

- `ARCHITECTURE.md` — the one idea and how the layers fit.
- `NOTES.md` — the grounded Qt facts (Templates, Control/AbstractButton, custom-style how-to).
- `TODO.md` — the build order and the old → Qt mapping.

## The look

Flat, square, dense — a desktop that reads like a terminal. Material 3 tokens after
IBM Carbon: 2 px corners, 1 px borders, depth from surface tone and outlines (no
shadows). Colour is the last tier of emphasis. Keyboard-first, focus always
visible, calm by default.
