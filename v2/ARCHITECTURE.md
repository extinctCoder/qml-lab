# v2 architecture

v2 is **a custom Qt Quick Controls style**, not a component framework. The whole
design system is the skin we put on Qt's own controls. v2 is self-sufficient: it
carries its own tokens, style, primitives, gallery, runner and docs, and depends
on nothing from the old `src/`.

## The one idea

Qt Quick Controls is already a headless architecture:

- **Qt Quick Templates 2** are *"non-visual implementations of controls' logic and
  behavior"* — *"any input event handling and state processing is taken care of by
  the underlying template."* Hover, press, focus, keyboard, checkable, exclusive
  grouping, auto-repeat, popups, accessibility — all of it, with no looks.
- A **style** supplies the looks: for each control a QML file rooted on the
  template (`import QtQuick.Templates as T` → `T.Button { … }`), whose `background`,
  `contentItem` and `indicator` delegates read `control.*` state and paint it.

So Qt is the behaviour + the state machine. We own exactly two things: **tokens**
and **the look**. Everything we hand-built in v1 (`Interactive`, `Roving`,
`StateLayer`, `Overlay`, `Transient`, keyboard activation…) is deleted — Qt does it.

```
Qt Templates (behaviour, state, a11y)   ←   our Style (look) + Theme (tokens)
                        │
                        ▼
              a styled Control, e.g. Button { }
```

## The three layers of v2

```
theme/        tokens: Colors, Type, Spacing, Shape, Motion, States (QML singletons)
Tui/          the style: one file per control, each a T.<Type> root, skinned flat
primitives/   the bespoke bits Qt has no control for: Keycap, charts, Divider, Image
```

- `theme/` is pure data. The style reads it; nothing else.
- `Tui/` is the design system. Each file is `connect` + `view` from the spec,
  native: it projects the template's state onto our look. No logic lives here.
- `primitives/` are plain `Item`s for things that aren't controls (a keycap, a
  TUI chart). They are not part of the style machinery.

## The seam, native

`machine → connect → view` maps exactly onto Qt:

| our spec   | Qt reality                                              |
| ---------- | ------------------------------------------------------- |
| machine    | the `T.<Type>` template (Qt owns states + transitions)  |
| connect    | the style file's delegate bindings to `control.*`       |
| view       | the `Rectangle`/`Text`/`Canvas` inside those delegates  |

We never write a state machine. We read the template's state and paint it.

## The channel model — now enforced by structure

The v1 bug (selection and current fighting for the background) is impossible here,
because Qt gives each concern its **own delegate**:

| channel            | delegate / source                        | reads                                   |
| ------------------ | ---------------------------------------- | --------------------------------------- |
| the box            | `background`                             | —                                       |
| current / pressed  | an overlay inside `background`           | `control.hovered`, `control.visualFocus`, `control.down`/`pressed` |
| the mark           | `indicator`                              | `control.checked`                       |
| selected fill (mark-less) | `background`                      | `control.checked` / `control.highlighted` |
| error border       | `background` border                      | validity (field)                        |
| content tone       | `contentItem`                            | `control.enabled`                       |

`control.checked` paints the **indicator**; `control.hovered`/`visualFocus` paint
the **background overlay**. Different delegates, different pixels — they cannot
collide. "Current" = `hovered || visualFocus` (and `visualFocus` is key-focus
only, so the mouse never draws a focus ring — exactly our rule).

## The control state surface (what we bind to)

From Qt, free, in every style delegate:

- `control.hovered`, `control.hoverEnabled`
- `control.visualFocus` (Tab/Backtab/Shortcut focus only), `control.focusReason`
- `control.pressed`, `control.down`
- `control.checked`, `control.checkable`, `control.autoExclusive`
- `control.highlighted`
- `control.enabled`
- `control.padding` / insets, `control.font`, `control.mirrored`, `control.spacing`
- signals: `clicked`, `toggled`, `pressed`, `released`, `canceled`, `doubleClicked`, `pressAndHold`

## Style mechanics (the rules Qt imposes)

- Each file's **root is the Template type**: `import QtQuick.Templates as T` then
  `T.Button { … }`. Never the `QtQuick.Controls` type (it would derive from itself).
- A `qmldir`: `module Tui`, one line per control, plus
  `import QtQuick.Controls.Basic auto` as the **fallback** so unimplemented
  controls still render while we build.
- The style's parent dir goes on the QML import path; selected with
  `-style Tui`, `QQuickStyle::setStyle("Tui")`, `QT_QUICK_CONTROLS_STYLE`, or
  `qtquickcontrols2.conf`. Directory casing is the style name.
- Inside a style delegate: **no `id` on the delegate root**, use **declarative
  bindings** (not imperative), and **do not import `QtQuick.Controls`** in style
  files.
- Shared tokens come from our `theme/` QML singletons (the style reads them).
- If we style `ScrollBar`, we must also style `ScrollView`.

## The look (carried from the design philosophy)

Flat, square, dense — a desktop that reads like a TUI. Material 3 tokens, after
IBM Carbon. Corner radius 2 px, 1 px borders, depth from surface tone + outlines,
never shadows. Colour is the last tier of emphasis: `primary` means only
selected, keyboard focus, or the one main action. Keyboard-first; focus is always
visible (as the current tint). Calm — nothing moves without a reason.

## What is NOT a control (lives in `primitives/`)

Qt has no template for these, so they stay plain `Item`s:

- `Keycap` (a drawn key), key-hint rows
- TUI charts: `Spark`, `Columns`, `Lines`, `Spectrum` (Canvas)
- `Divider`, `Image`/`Avatar`
- anything else purely presentational with no interaction

## Invariants

1. `theme/` holds data only; the style reads it; nothing imports upward.
2. We never implement hover/press/focus/keyboard/checkable — that is the template.
3. One concern, one delegate: selection on the indicator, current on the
   background overlay — never the same pixel.
4. Style files root on `T.<Type>`, carry no `id`, bind declaratively, import no
   `QtQuick.Controls`.
5. `primitives/` are not controls and never pretend to be.
6. v2 depends on nothing outside v2.
