# Material 3: shape, motion and states

Source: Google's Material Web repository (`material-components/material-web`),
`docs/theming/shape.md` and `tokens/versions/latest/sass/` (`_md-sys-shape.scss`,
`_md-sys-motion.scss`, `_md-sys-state.scss`). Rewritten in plain words for our
QML design system.

## Shape: how round the corners are

Material 3 uses named corner sizes, from straight to fully round, and says
shape can direct attention, communicate state and express brand.

| Name | Radius |
|---|---|
| none | 0 px |
| extra small | 4 px |
| small | 8 px |
| medium | 12 px |
| large | 16 px |
| extra large | 28 px |
| full | fully round (a pill or circle) |

(It also has in-between sizes like large-increased, 20 px, and
extra-extra-large, 48 px.)

**For us:** a TUI uses only the bottom of this scale. Note that 2 px, which we
used in the mockups, is **not** a Material 3 value; its smallest rounded corner
is extra small, 4 px. One of the open decisions below.

## Motion: how long animations take

| Group | Durations |
|---|---|
| short 1–4 | 50, 100, 150, 200 ms |
| medium 1–4 | 250, 300, 350, 400 ms |
| long 1–4 | 450, 500, 550, 600 ms |
| extra long 1–4 | 700, 800, 900, 1000 ms |

Small things (a button's hover, a toggle) use short durations; large
movements (a panel opening) use medium ones.

**For us** ("calm by default"): probably only the short group, plus one
medium duration for panels.

## States: hover, focus, pressed, disabled

Material 3 shows an interaction state by laying a thin layer of the content
color over the component:

| State | Layer opacity |
|---|---|
| hover | 8 % |
| focus | 10 % |
| pressed | 10 % |
| disabled | content at 38 % opacity |

**For us:** keep these, plus a visible 2 px focus ring for keyboard use.

## Open decisions (DESIGN.md)

- Corners: 0, 2 or 4 px? (2 px is our own value; 4 px is Material 3's smallest.)
- Which durations we allow.
