# v2 notes — grounded Qt facts

A reference sheet distilled from the Qt 6 docs, so we don't re-fetch. Where a fact
was read verbatim it's stated plainly; items marked (unverified) need a check
before we rely on them.

## Templates vs Controls

- Qt Quick **Templates 2** = *"non-visual implementations of controls' logic and
  behavior."* *"Any input event handling and state processing is taken care of by
  the underlying template."* The visual layer *"merely needs to position … and
  visualize them in normal, pressed, and disabled states."*
- **One-to-one** mapping: every `QtQuick.Controls` type has a same-named
  `QtQuick.Templates` type. Import as `import QtQuick.Templates as T`.
- Templates are used *"when creating a custom style."*
- Caveat: templates assume *some* visual structure (e.g. a SpinBox template must
  know up vs down button). Not 100% visual-free.
- Caveat: docs don't confirm templates run windowless, so headless unit-testing of
  them is (unverified).

## Base template types

`Control`, `AbstractButton`, `Container`, `Popup` are the bases. Full control set
includes: Button, CheckBox, RadioButton, Switch, Slider, RangeSlider, ProgressBar,
Dial, SpinBox, ComboBox, TextField, TextArea, Label, TabBar, TabButton, Menu,
MenuItem, MenuBar, Popup, Drawer, Dialog, DialogButtonBox, ToolTip, ToolBar,
ToolButton, ScrollBar, ScrollView, Frame, Pane, GroupBox, Page, ItemDelegate,
CheckDelegate, RadioDelegate, SwitchDelegate, SwipeDelegate, BusyIndicator,
PageIndicator, Calendar/MonthGrid/DayOfWeekRow, Tumbler, SplitView, StackView,
SwipeView, SearchField, and more.

## Control (inherits Item) — state/layout surface

- `hovered` (ro bool) + `hoverEnabled` (default `Application.styleHints.useHoverEffects`)
- `visualFocus` (ro bool) — true only when focus reason is Tab/Backtab/Shortcut.
  Docs: prefer it over `activeFocus` for key-focus visuals (so mouse shows no ring).
- `focusReason` (enum)
- `background` (Item) — fills control; its implicit size feeds control implicit size
- `contentItem` (Item) — auto-placed inside padding; x/y/w/h bindings ignored
- `padding` + `left/right/top/bottomPadding` + `horizontal/verticalPadding`;
  `availableWidth`/`availableHeight`
- `leftInset`/`rightInset`/`topInset`/`bottomInset`
- `implicitBackgroundWidth/Height`, `implicitContentWidth/Height`
- `font`, `spacing` (meaning set by the style), `locale`, `mirrored` (ro)
- `wheelEnabled` (default false; consuming wheel blocks Flickable scroll)
- `palette` — not on the Control page we read (unverified; may exist)
- `enabled`, `focusPolicy` — inherited from Item, not on the Control page

## AbstractButton (inherits Control)

Properties: `checkable` (Space/click toggles when focused), `checked`, `down`
(visual press, follows `pressed` unless set), `pressed` (ro), `autoExclusive`
(checkables under one parent act as a group; RadioButton & TabButton default on),
`autoRepeat` + `autoRepeatDelay` (300) + `autoRepeatInterval` (100), `action`,
`text` (also used for a11y), `icon` (name/source/width/height/color/cache),
`display` (IconOnly/TextOnly/TextBesideIcon/TextUnderIcon), `pressX`/`pressY`,
`indicator` (Item).

Signals: `pressed`, `released`, `clicked`, `toggled`, `canceled`, `doubleClicked`,
`pressAndHold`. Methods: `click()`, `animateClick()`, `toggle()`.

Keyboard: Space toggles a focused checkable. Enter/Return activation is
(unverified) from the pages we read — confirm before relying on it.

## Writing a custom style

- Directory of files named after controls: `Tui/Button.qml`, `Tui/CheckBox.qml`, …
- Each file's **root is the Template**: `import QtQuick.Templates as T` → `T.Button { }`.
  Using the Controls type would make it derive from itself.
- `qmldir`:
  ```
  module Tui
  Button Button.qml
  CheckBox CheckBox.qml
  import QtQuick.Controls.Basic auto
  ```
  The `import … Basic auto` line is the **fallback** for controls we haven't styled.
- Parent dir on the QML import path. Select with `-style Tui`,
  `QQuickStyle::setStyle("Tui")`, `QT_QUICK_CONTROLS_STYLE=Tui`, or
  `qtquickcontrols2.conf` (`[Controls] Style=Tui`). Casing matters.
- Delegate rules: **no `id`** on the delegate root; **declarative bindings** only;
  **do not** import `QtQuick.Controls` inside style files.
- State bindings seen in Qt examples: `control.down`, `control.pressed`,
  `control.checked`, `control.highlighted`, `control.enabled` (`opacity: enabled ? 1 : 0.3`),
  `control.visualFocus` (`border.width: control.visualFocus ? 2 : 1`), `control.hovered`.
- Styling `ScrollBar` requires also styling `ScrollView`.

## Tokens

- Shared tokens via a **QML singleton** (`pragma Singleton` + `qmldir singleton`),
  which is what v1's `theme/` already did — reuse that approach. (A C++ attached
  style property is the other Qt-documented route; we don't need it.)

## Built-in styles (for reference / fallback)

Basic (lightest, our fallback), Fusion, Material, Universal, Imagine, plus
platform styles. Basic is the fallback target.

## Open / unverified, to confirm during build

- Enter/Return activates a Button (test it).
- `palette` availability on Control.
- Default `focusPolicy` per control (affects Tab reachability).
- Whether templates can be exercised headless for tests (our v1 trick was loading
  QML offscreen; that still works for rendering checks).
