# Component architecture

This is the architecture of the component **library** — how the parts are built
and composed. It is not the shell architecture. The shell (services, panels, the
system bus) is a separate application built *from* this library and documented on
its own. The firewall between them: a component never knows what Wi‑Fi is; a
service never knows what a slider looks like.

The design follows three established ideas, not invention:

- **Headless** — behaviour (logic) and presentation (look) are separate layers
  that never reach into each other. (React Aria, Radix, Zag.js.)
- **Atomic** — everything is composed from small, pure, single‑purpose atoms.
  (Atomic Design.)
- **Statechart** — interactive state is a real state machine: states, events,
  transitions, guards, actions, context — not a scatter of boolean flags.
  (Harel statecharts / XState; Zag.js models every component this way.)

One rule falls out of all three: **one concern, one owner.** A look is drawn in
exactly one place, a state is decided in exactly one place, an input is handled
in exactly one place. Everything below is that rule, applied.

## 1. The layers

```
patterns/     compound components: Tabs, Picker, Menu, Dialog — own state, feed children
components/    the interactive families, composed from primitives + behaviours
state/         the state model: regions, events, the channel map, the connect contract
behaviours/    pure logic, no looks: Interactive, Roving, Transient, Overlay … — emit state
primitives/    pure look, no logic: Surface, StateLayer, Strip, Text, Mark, Divider
theme/         tokens: Colors, Type, Spacing, Shape, Motion, States
```

A lower layer never imports a higher one. **`primitives/` and `behaviours/`
never import each other** — that is the headless firewall. The only place they
meet is a component, which composes both.

Sorting rule for where a thing lives:

- no interactive state, just draws → **primitive** (`Surface`, `Text`, `Mark`, `Divider`, charts)
- has interactive state → **component** (`button`, `field`, `range`, `section`)
- owns state and distributes it to children → **pattern** (`tabs`, `picker`, `menu`, `dialog`)

## 2. The seam: machine → connect → view

Every interactive component is three separable pieces. This is Zag.js's data flow
(`machine + props → service → connect → element props`), made native:

```
events ──▶  machine  ──state──▶  connect  ──channels──▶  view
          (pure logic)         (projection)           (primitives)
```

- **machine** — pure logic. States + events + transitions + guards + actions +
  context. Knows nothing about colour. **Testable without a window.**
- **connect** — the projection. A pure function from the machine snapshot (plus
  reflected props) to two outputs: **visual channels** and **semantics**. The
  *only* place a state becomes a look.
- **view** — primitives. Binds the projected channels to pixels. Decides nothing.

The invariant: logic is testable without pixels; looks are swappable without
touching logic.

## 3. Who owns the state

Not all state is the component's to keep. Two kinds:

- **Ephemeral — the component owns it** (its internal machine): the pointer
  (idle / hover / press), focus, and lifecycle transients (opening / closing).
- **Authoritative — the owner owns it, the component only reflects it** (props):
  selection (`checked`), openness (`open`), `value`, `text`, `invalid`. The
  component is *told* these and emits **intents** (`switched`, `moved`, `open`);
  it never stores them.

This is the existing "the owner holds the value" rule, and it is exactly Zag's
*controlled* mode. `connect` reads both: the internal machine and the reflected
props.

## 4. The machine: parallel regions

An interactive component is never in one state — it is in several at once (it can
be checked **and** focused **and** enabled). We model that as **parallel
regions** (orthogonal statecharts), each independent. This avoids state
explosion: two dimensions of 3 and 2 states are two regions, not 6 combined
states.

| region        | states                                | events                      | owned by        |
| ------------- | ------------------------------------- | --------------------------- | --------------- |
| `enablement`  | `enabled ⇄ disabled`                  | enable / disable            | prop            |
| `pointer`     | `idle → hover → press`                | enter / leave / down / up   | component       |
| `focus`       | `unfocused ⇄ focused`                 | focus / blur                | component       |
| `selection`   | `off ⇄ on`                            | `activate` [guard: enabled] | prop (reflected)|
| `validity`    | `valid ⇄ invalid`                     | —                           | prop            |
| `openness`\*  | `closed → opening → open → closing`   | open / close / toggle       | component / prop|

\* compound components only (popup, section, picker, dialog) — this is where real
transitions and guards (focus return, Esc, click‑outside) earn their keep.

**Context** (quantitative data, *not* finite states): `value`, `text`, a list's
highlight `index`. Updated by actions; never encoded as state names. The test
(from XState): a value that changes *which events are handled* is a **state**; a
value that only parameterises is **context**. Guards bridge the two.

## 5. The channel model

Each region projects onto **one visual channel**. Two regions never share a
channel, so two states can never fight over a pixel — the exact bug we hit, where
`selected` stole the background that `current` owns.

| channel                     | fed by                                                         | precedence           |
| --------------------------- | -------------------------------------------------------------- | -------------------- |
| content (desaturate)        | `enablement.disabled`                                          | gates all others     |
| background overlay (`StateLayer`) | `pointer.press` (strong) › `pointer.hover ∨ focus ∨ highlight` (soft) | press > current |
| the mark (■ ● switch)       | `selection.on` — components **with** a mark                    | —                    |
| fill + border               | `selection.on` — mark‑**less** components (tile, segment)      | —                    |
| border (error)              | `validity.invalid`                                             | —                    |

Precedence exists only *within* a channel (press over current) and for
`disabled`, which gates everything. Across channels there is no precedence —
they are orthogonal by construction, so nothing collides.

The rule that fixes the list bug, plainly: **a component with a mark shows
selection on the mark, never on the background.** The tonal background fill is a
selection channel *only* for mark‑less components. "Current" (the soft
background) is hover **or** focus **or** keyboard highlight — one concept, one
channel, any device.

## 6. Worked example — the toggle (checkbox / switch)

- **context:** none. `checked` is authoritative (owner‑owned), reflected in.
- **regions:** `enablement`, `pointer`, `focus`, `selection`.
- **events:** `pointer_enter/leave`, `press_down/up`, `focus/blur`, `activate`
  (Space / Enter / click).
- **transition:** `activate` [guard: `enabled`] → action: emit `switched`. The
  component does **not** flip `checked`; the owner does, and feeds it back.
- **connect (projection):**
  - background ← `pointer`/`focus` (current / press)
  - the mark (checkbox fill, switch thumb) ← reflected `checked`
  - content desaturate ← `disabled`
  - **never:** background ← `checked`
- **view:** `StateLayer` bound to the background projection; `Mark` bound to
  `checked`; `Surface` draws the box.

A list item, a tile, a tab, a menu item are all this same machine with a
different mark/fill projection. That is the payoff: one model, many skins.

## 7. QML substrate

The seam maps onto QML idioms:

- **machine** — for a simple component, the ephemeral interaction state is derived
  (hovered / pressed / focused booleans that `Interactive` already reports); a
  hover needs no heavyweight machine. For **compound / lifecycle** components
  (popup, picker, section, dialog) — where coordination bugs actually live — an
  **explicit machine**: a plain `QtObject` holding `states` / `events` /
  `transitions` / `guards` (framework‑free, unit‑testable), preferred over
  `QtQml.StateMachine` because it runs without a window.
- **connect** — a small projection: `readonly` derived properties (or a plain
  object) turning machine + reflected props into channel values.
- **view** — `primitives` bind to the projection. Qt Quick `States` / `Transitions`
  may drive the *visual* projection, but that is the view's business, never the
  machine's.

So the state model is a spectrum: a shared projection for the simple states, an
explicit machine where a lifecycle is real. The **seam** (logic apart from look,
one region per channel) is universal; the ceremony scales with the component.

## 8. Mapping the current code

| today                                                   | becomes                                                       |
| ------------------------------------------------------- | ------------------------------------------------------------ |
| `Surface`                                               | primitive (view): box look + reflected box‑states            |
| `StateLayer`                                            | the background‑channel renderer                              |
| `Interactive`                                           | behaviour: emits pointer/focus/press, reports `current`; draws nothing |
| `Roving`, `Highlight`                                   | behaviours: current/selection coordination for groups        |
| `Transient`, `Reveal`, `Overlay`, `Popup`, `Dismissible`, `WheelAdjust` | behaviours: lifecycle machines               |
| `Glide`, `ColorGlide`, `Swing`, `Drawn`                 | motion / render helpers                                      |
| `text/*`, `mark/*`, `chart/*`, `image/*`                | primitives (view)                                           |
| `button`, `field`, `range`, `section`, `badge`, `feedback`, `keycap` | components, composed per the state model        |
| `Picker`, `Tabs`, `Menu`, `Dialog`                      | patterns (compound, own state)                              |

Most atoms already fit. The gaps to build: an explicit `state/` layer (region
definitions + channel map + the connect contract), and promoting the compound
components to real lifecycle machines.

## 9. The folder remap

```
theme/
primitives/      Surface · StateLayer · Strip · Labeled · Divider · Scrollbar
  text/  mark/  chart/  image/
behaviours/      Interactive · Roving · Highlight · Transient · Reveal · Overlay
                 Popup · Dismissible · WheelAdjust · Drawn · Swing · Glide · fuzzy
state/           regions · channels · connect
components/      button/ field/ range/ section/ badge/ feedback/ keycap/
patterns/        tabs/ picker/ menu/ dialog/
gallery/
```

The folders stop being flat — they *are* the layers.

## 10. Invariants

1. `primitives/` never imports `behaviours/`, and vice‑versa.
2. A state is decided once — in the machine or a reflected prop — never recomputed
   in a view.
3. A look is drawn once: one channel, one primitive.
4. Each region owns one channel; **selection never uses the background.**
5. The component reflects authoritative state and emits intents; the owner holds
   the value.
6. A machine is testable without a window; a view is swappable without touching a
   machine.

---

**Sources this is grounded in:** Zag.js (component‑as‑machine, the machine/connect
split), XState & Harel statecharts (states, events, transitions, guards, actions,
context, parallel regions), React Aria / Radix (headless state/behaviour/view
separation), Atomic Design (the layer taxonomy).
