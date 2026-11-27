# Component architecture

qml-lab is a design system for a TUI-style desktop shell. This describes how the
component library is built. The shell that consumes it is a separate app, planned
in `SHELL.md`; the design principles (Material 3 tokens, the TUI look, the
colour-emphasis tiers) are in `DESIGN.md`.

## The thesis: behaviour is Qt's, look is ours

A Qt Quick Control is two halves. A **Template** (`QtQuick.Templates`) owns every
behaviour — hover, press, keyboard activation, focus, checkable, autoexclusive,
popups, accessibility. A **style** owns the look. We write only the style.

So there is no hand-rolled state machine, no behaviour layer, no projection step.
A control's logic comes free from its Template; a Tui delegate reads the
Template's state (`control.hovered`, `.down`, `.checked`, `.visualFocus`,
`.enabled`) and paints it. ~40 controls, zero behaviour code.

This deliberately replaces an earlier headless/statechart design: Qt already
ships the machine, so building one was redundant.

## The layers

```
lib/theme/        M3 tokens: Colors, States, Shape, Spacing, Motion, Type + Theme.qml (root wrapper)
lib/Tui/          the style — one delegate per Qt Quick Control, rooted on T.<Type>, reads the tokens
lib/primitives/   things Qt has no control for: Divider, Keycap, Avatar, Combo, Image — plain Items, same tokens
gallery/          the showcase + state/popup harnesses; `make run` shows it (native qml)
```

The library modules (`theme`, `Tui`, `primitives`) live under `lib/`, which is
the QML import path; the Makefile (`-I lib`) and the shell add it so `import theme` resolves.

A Tui delegate imports `theme` and `QtQuick.Templates`, never `QtQuick.Controls`
— so it cannot recurse into itself.

## Tokens

Colour is **Material 3 roles**, pruned for a flat TUI — the surface tiers are
colour only, no elevation shadows: `surface`(`_container*`), `on_surface`
(`_variant`), `primary`/`on_primary`, `secondary_container`/`on_…`, `outline`
(`_variant`), and `error`/`success`/`warning`. **States** are the M3 state
layers: `hover` 0.08, `pressed` 0.10, `disabled` 0.38. `Shape`/`Spacing`/
`Motion`/`Type` hold the geometry Qt has no colour role for. `DESIGN.md` has the
full taxonomy and the emphasis tiers.

The one rule that makes the accent uniform: **every active / checked / selected
mark reads `Colors.primary`.** A checkbox check, a radio dot, a switch track, a
slider fill, a selected row — all the same green, by construction. (The built-in
styles get this inconsistently: Fusion draws a switch from `highlight` but a
checkbox from `text`, so they never match. Owning the delegate fixes it.)

## How a control is drawn

Every delegate has the same shape:

- root `T.<Type>` with the implicit-size boilerplate,
- `contentItem` — text/icon, colour from a token, desaturated when `!enabled`,
- `background` / `indicator`, carrying two separate channels:
  - the **mark or fill** = `checked` → `primary` (selection),
  - a **state overlay** = `on_surface` at `States.hover` / `States.pressed`,
    shown for `down`, or `hovered || visualFocus` — so a keyboard-focused
    control looks hovered (keyboard-first),
  - **disabled** desaturates via `States.disabled_text` / `_fill`.

Selection (the mark) and current (the overlay) are different channels on
different items, so they can never fight over the same pixel. `Button.qml` and
`CheckBox.qml` are the clearest to read.

## No palette

Because every delegate reads the tokens directly, nothing depends on Qt's palette
propagation — popups included (a `Menu` / `ComboBox` dropdown / `ToolTip` reads
`Colors` like any other control). `theme/Theme.qml` sets only the app background
and the default mono font. There is no `palette` block anywhere.

## Adding a control

1. `lib/Tui/<Type>.qml`, root `T.<Type>`; copy the implicit-size block from a peer.
2. `contentItem` + `background`/`indicator` reading `Colors` + `States`, per above.
3. Register it in `lib/Tui/qmldir`.
4. Show it in `gallery/` and check every state in `gallery/StatesTest.qml`.

## Invariants

1. A delegate reads Template state; it never stores or computes behaviour.
2. Every active / checked / selected mark reads `primary` — one accent, everywhere.
3. Current (hover ∨ focus) is the state overlay; selection is the mark/fill —
   separate channels, so they never collide.
4. Colour comes from a token role, never a literal; geometry from `Shape`/`Spacing`.
5. Delegates import `theme` + `QtQuick.Templates`, never `QtQuick.Controls`.
6. The library is system-agnostic: nothing here names Wi-Fi, a command, or data.

## Relationship to the shell

The shell (`SHELL.md`) builds panels from these components fed by services; a
component never learns what it is showing. The shell also needs components Qt has
no control for — charts, a fuzzy palette, rings, badges, feedback states — built
on this same foundation (primitives + tokens) when the shell phase begins.
