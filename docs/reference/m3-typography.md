# Material 3: typography

Source: Google's Material Web repository (`material-components/material-web`),
`docs/theming/typography.md` and `tokens/versions/latest/sass/_md-sys-typescale.scss`.
Rewritten in plain words for our QML design system.

## In one sentence

Text uses a small set of **named styles** (like "title" or "label"), each with
a fixed size, line height and weight, instead of picking a font size every time.

## Two terms

- **Typeface:** the font itself (family and weights). Material 3's default is
  Roboto; **ours is FiraCode Nerd Font** (monospaced).
- **Typescale:** the set of named styles. Each style comes in **large**,
  **medium** and **small**.

## The styles and their default sizes

| Style | Large | Medium | Small | Weight | Typical use |
|---|---|---|---|---|---|
| display | 57 / 64 | 45 / 52 | 36 / 44 | regular | huge numbers or short headings (a big clock) |
| headline | 32 / 40 | 28 / 36 | 24 / 32 | regular | section headings |
| title | 22 / 28 | 16 / 24 | 14 / 20 | regular (large), medium | panel titles, list headers |
| body | 16 / 24 | 14 / 20 | 12 / 16 | regular | normal text |
| label | 14 / 20 | 12 / 16 | 11 / 16 | medium | buttons, chips, small captions |

Sizes are font size / line height in px (Material lists them in rem at 16 px).

## In our QML

A `Type` (or `Style`) singleton exposing the styles we pick, e.g.
`Type.body.size`, and one `Text` component taking a `style` property
(`"body"`, `"label"`…). The font family is set once, for everything.

## Open decisions (DESIGN.md)

- Which styles we use. A TUI needs few: maybe `label`, `body`, `title`, and
  `display` for the clock.
- Our sizes: Material 3's numbers are designed for a proportional font on a
  phone; a monospaced font on a desktop often wants slightly smaller ones.
- Weights: monospaced TUIs often use only regular and bold.
