# Design

A design system for a desktop shell that looks and feels like a TUI.

**Foundations:** Material 3 tokens (color roles, type scale, spacing, shape,
motion, states). Colors come from the wallpaper through matugen, which already
speaks Material 3.
**Style:** after IBM Carbon (flat, square, dense), made to look like a TUI.
**Precedent:** Textual, a framework for terminal apps, describes its own design
system as Material Design modified to suit the terminal. Same idea.

References: `docs/reference/` (plain-language Material 3 notes, from Google's
Material Web repository).

## Principles

1. **Calm by default.** Nothing moves without a reason.
2. **Real data only.** No decoration without meaning.
3. **Dense like a terminal.** Information over whitespace.
4. **Keyboard first, mouse welcome.** Everything works from the keyboard,
   and focus is always visible.

When unsure how something should look or behave, these decide.

## Color

Components ask for a **role**, never a color: `primary`, never "green".
The wallpaper decides the actual colors.

### Emphasis comes in tiers; color is the last tier, not the first

| Tier         | Purpose                      | How                                                                                    |
| ------------ | ---------------------------- | -------------------------------------------------------------------------------------- |
| 1. structure | separate areas               | neutral surface tones + 1 px outlines                                                  |
| 2. hierarchy | important vs supporting text | `onSurface` vs `onSurfaceVariant`                                                      |
| 3. state     | selected, on, active         | a container fill (`secondaryContainer`, `primaryContainer`) or a thin `primary` border |
| 4. focus     | where the keyboard is        | a 2 px `primary` ring                                                                  |
| 5. action    | the main thing to do         | a filled `primary` button, at most one per view                                        |
| 6. status    | meaning                      | `error`, `success`, `warning`                                                          |

The accent (`primary`) only ever means: selected, keyboard focus, or the main
action.

### Status colors

`error` comes from Material 3. `success` (green) and `warning` (amber) are
fixed colors **harmonized** toward the wallpaper (matugen custom colors),
so they keep their meaning on every wallpaper and still fit its palette.
Never reuse `primary` or `tertiary` for status.

### Layers

Each layer is slightly lighter than the one below it, and every layer has a
1 px `outlineVariant` border, like boxes in a TUI. No shadows.

| Layer | Example                             | Role                      |
| ----- | ----------------------------------- | ------------------------- |
| base  | desktop, bar                        | `surface`                 |
| panel | quick settings, dashboard, launcher | `surfaceContainer`        |
| card  | a section inside a panel            | `surfaceContainerHigh`    |
| popup | a menu over a panel                 | `surfaceContainerHighest` |

Content on any layer uses `onSurface` (main) or `onSurfaceVariant` (secondary).

## Typography

Font: **FiraCode Nerd Font**, monospaced only. Regular weight; bold rarely,
for emphasis.

| Style   | Size  | Use                                  |
| ------- | ----- | ------------------------------------ |
| label   | 12 px | buttons, captions, the bar           |
| body    | 13 px | normal text, list items              |
| title   | 15 px | the heading of a panel or card       |
| display | 40 px | one big number (the dashboard clock) |

Slightly smaller than Material 3's sizes (12 / 14 / 16 / 45): a monospaced
font on a desktop already takes more room per letter. The shell's text-size
setting scales all of them together.

**Case:** the shell's own words are lowercase (`connect`, `wi-fi`,
`night light`). **Data is shown exactly as received**: names, song titles,
network names, notification text.

## Spacing

A 4 px grid, four steps:

| Step | Use                              |
| ---- | -------------------------------- |
| 4    | tiny gaps (an icon and its text) |
| 8    | inside a card (between rows)     |
| 12   | between cards                    |
| 16   | around a panel's edge            |

## Shape

- Corner radius: **2 px** everywhere (our own value; Material 3's smallest
  rounded corner is 4 px).
- Borders: 1 px.
- Depth comes from surface tone and outlines, never shadows.

## Buttons

| Variant | Material 3 name | Use                                                              | Colors                                                  |
| ------- | --------------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| primary | filled          | the one final action: _save_, _connect_. At most one per view.   | fill `primary`, label `onPrimary`                       |
| tonal   | filled tonal    | lower priority, but more weight than an outline: _next_          | fill `secondaryContainer`, label `onSecondaryContainer` |
| outline | outlined        | important, but not the main action: _back_                       | border `outline`, label `primary`                       |
| ghost   | text            | the lowest priority; the default in toolbars and lists: _cancel_ | label `primary`, no fill                                |
| danger  | (Carbon)        | destructive actions only: _delete_                               | `error` roles; outline, or filled to confirm            |

## States (every interactive component)

| State          | Look                                |
| -------------- | ----------------------------------- |
| hover          | a layer of the content color at 8 % |
| pressed        | that layer at 10 %                  |
| keyboard focus | a 2 px `primary` ring               |
| disabled       | content at 38 % opacity             |

## Motion

Everything starts moving on the same frame as the click or keypress; nothing
makes you wait at the end.

| What                          | Duration | Curve                 |
| ----------------------------- | -------- | --------------------- |
| small things (hover, toggles) | 100 ms   | ease-out              |
| panel opening                 | 200 ms   | ease-out (fast start) |
| panel closing                 | 150 ms   | ease-in (fast finish) |

Only things that change because of an action or new data move.
