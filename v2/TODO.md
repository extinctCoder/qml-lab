# v2 to-do

Build order is smallest-proof-first, then outward. Each control is the same move:
a `T.<Type>` root + skinned delegates reading `control.*`.

## Phase 0 — scaffold + prove the approach
- [ ] `theme/` singletons: Colors, Type, Spacing, Shape, Motion, States (+ qmldir)
- [ ] `Tui/qmldir`: `module Tui` + `import QtQuick.Controls.Basic auto` fallback
- [ ] `dev.py` live-reload runner (standalone; sets `-style Tui`, adds import paths)
- [ ] `Tui/Button.qml` — `T.Button`, flat look, reads down/hovered/visualFocus/checked/enabled
- [ ] a tiny `gallery/Gallery.qml` with a plain `Button { }` to prove it styles
- [ ] confirm: hover, press, keyboard focus, checkable all work with zero behaviour code

## Phase 1 — core controls
- [ ] Label (text tone, disabled)
- [ ] Button variants (primary / tonal / outline / ghost / danger) — via a style property or attached prop
- [ ] CheckBox (indicator = our check), RadioButton (indicator = our radio)
- [ ] Switch (indicator = our thumb)
- [ ] Slider (groove + handle + current overlay), ProgressBar (determinate + indeterminate)
- [ ] TextField (field box, focus = current, error border), SpinBox (our stepper)
- [ ] ItemDelegate / CheckDelegate / RadioDelegate (list rows)

## Phase 2 — containers, overlays, navigation
- [ ] TabBar + TabButton (underline indicator)
- [ ] Menu + MenuItem + MenuSeparator
- [ ] ComboBox (our Select), + popup
- [ ] Popup / ToolTip (ToolTip timeout = our Transient), Drawer
- [ ] Dialog + DialogButtonBox (our Confirm)
- [ ] ScrollBar (+ ScrollView), Frame / Pane / GroupBox

## Phase 3 — bespoke primitives (not controls)
- [ ] Surface helper for delegates (box look + tone/level), StateLayer overlay helper
- [ ] Divider, Image / Avatar (Canvas clip)
- [ ] Keycap + key-hint Combo
- [ ] charts: Spark, Columns, Lines, Spectrum (Canvas)

## Phase 4 — TUI families that aren't 1:1 Qt controls
- [ ] fuzzy Palette (ComboBox/Popup + the fzf matcher)
- [ ] OSD (Popup + Transient/ToolTip timeout), Toast
- [ ] Cycle (multi-state), Chip (checkable Button), Tag/Count/Dot badges (primitives)
- [ ] range extras: Ring, Steps, Seek (Slider/ProgressBar variants or Canvas)
- [ ] feedback: Empty / Loading (BusyIndicator) / Error

## Phase 5 — polish
- [ ] full gallery of every control + primitive in all states (fake data)
- [ ] headless load + render checks (offscreen), like v1
- [ ] hook for wallpaper-driven tokens later (matugen) — tokens already a singleton

## old → Qt mapping (what each v1 thing becomes)

| v1                                   | v2 (Qt)                                             |
| ------------------------------------ | --------------------------------------------------- |
| Interactive, Roving, StateLayer, Overlay, Popup | **deleted** — Templates provide it         |
| button/Basic                         | `Button` (variants via style prop)                  |
| button/ListItem                      | `ItemDelegate` / `CheckDelegate` / `RadioDelegate`  |
| button/Tile                          | `Button` (checkable) styled as a tile               |
| button/Mark                          | `ToolButton` / `Button`                             |
| mark/Switch, Choice                  | `Switch`, `CheckBox`/`RadioButton` indicators       |
| mark/Spinner                         | `BusyIndicator`                                     |
| section                              | `Frame`/`Pane` + header `Button`; openness via states |
| range/Slider, Progress               | `Slider`, `ProgressBar`                             |
| range/Basic, Steps, Ring, Seek       | ProgressBar/Slider variants or Canvas primitives    |
| tabs                                 | `TabBar` + `TabButton`                              |
| field/Basic, Search, Password        | `TextField` (icons, echoMode)                       |
| field/Stepper                        | `SpinBox`                                           |
| picker/Select, Menu                  | `ComboBox`, `Menu`                                  |
| picker/Palette                       | custom: `Popup` + `TextField` + fuzzy               |
| dialog                               | `Dialog`                                            |
| badge/Tag, Count, Dot                | primitives (Label/Rectangle)                        |
| badge/Chip                           | checkable `Button` (styled chip)                    |
| chart/*, keycap, image, Divider      | primitives (Canvas / Item)                          |
| behaviors Transient, Reveal, Dismissible, WheelAdjust | ToolTip timeout, states, custom, `wheelEnabled`/WheelHandler |

## decisions / open
- Style name = `Tui` (working; rename cheap before much is built).
- Button variants: a style-level attached property (`Tui.variant`) vs a plain
  `property` on a styled Button subtype — decide during Phase 1.
- Confirm Enter activation, `palette`, `focusPolicy` defaults (see NOTES).
