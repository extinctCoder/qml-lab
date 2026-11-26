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
| 2. hierarchy | important vs supporting text | `on_surface` vs `on_surface_variant`                                                      |
| 3. state     | selected, on, active         | a container fill (`secondary_container`) or a thin `primary` border |
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

Depth comes from **levels**: each one a little lighter than the one below,
with 1 px `outline_variant` borders, like boxes in a TUI. No shadows.
A box's level is set where depth matters, and the middle (3) is the default.

| Level | Role                        | Typical use                          |
| ----- | --------------------------- | ------------------------------------ |
| 1     | `surface_container_lowest`  | recessed areas                       |
| 2     | `surface_container_low`     |                                      |
| 3     | `surface_container`         | the default: boxes, sections         |
| 4     | `surface_container_high`    | a framed icon inside a box           |
| 5     | `surface_container_highest` | popups and menus over a panel        |

The desktop and the bar sit on `surface`, below every level.

Content on any layer uses `on_surface` (main) or `on_surface_variant` (secondary).

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

## Button variants

| Variant | Material 3 name | Use                                                              | Colors                                                  |
| ------- | --------------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| primary | filled          | the one final action: _save_, _connect_. At most one per view.   | fill `primary`, label `on_primary`                      |
| tonal   | filled tonal    | lower priority, but more weight than an outline: _next_          | fill `secondary_container`, label `on_secondary_container` |
| outline | outlined        | important, but not the main action: _back_                       | border `outline`, label `primary`                       |
| ghost   | text            | the lowest priority; the default in toolbars and lists: _cancel_ | label `primary`, no fill                                |
| danger  | (Carbon)        | destructive actions only: _delete_                               | `error` roles; outline, or filled to confirm            |

## Interaction rules

1. **One topic per box.** (Material 3)
2. **Interactive boxes keep a visible border**, so they look operable. (Carbon)
3. **One target per clickable thing**: a tile or list item is clicked anywhere.
   A control inside it (a switch in a section header) is its own target, and
   clicks on it never trigger the larger one.
4. **At most one or two actions** inside an interactive box. (Carbon)
5. **Arrows carry meaning**: `→` does something here (scan, open a page),
   `↗` opens something else (an app, a tool).
6. **Keys:** Enter activates, Space toggles. Things that hold a value
   (toggles, switches, radios) react to Space only. Tab moves focus.
7. **Selection never relies on color alone**: every on/off state also changes
   shape or position (a filled radio, a filled check, a switch's thumb).

## Components

The library is built bottom-up. Each family is a folder; what it offers:

| Family     | Public types                            | What they are                                          |
| ---------- | --------------------------------------- | ------------------------------------------------------ |
| (core)     | `Surface`                               | our look for any box                                   |
| `text`     | `Mono`, `Header`                        | text; an icon spanning a title and description         |
| `mark`     | `Switch`, `Choice`, `Chevron`, `Spinner` | small drawn markers that show a state by shape        |
| `button`   | `Basic`, `ListItem`, `Tile`             | everything you press: a button, a list row, a tile     |
| `section`  | `Basic`                                 | a box whose header folds its content open and closed  |
| `feedback` | `Empty`, `Loading`, `Error`             | what's shown when there's nothing (yet) to show        |

### Surface

Every box is a `Surface`: background, border, corners and padding are decided
there once. `appearance` is `outlined`, `filled`, `ghost` (no fill, no border,
keeps padding) or `none` (no look, no padding: just the content). A component
sets its resting colors (`fill`, `line`), never its final color: `Surface`
alone draws the **selected** look (tonal fill, accent border) and the
**disabled** look, so every component shows states the same way.

### Buttons

`Basic` is the button above, in five variants; `checkable: true` makes it hold
a value (a toggle). `ListItem` is one line in a list: an action, or a choice
with a radio (`● ○`, one of several) or a check (`■ □`, on/off). `Tile` is a
box in a grid: an action (`→`), or on/off with a switch.

### Sections

A section's header opens and closes it (pattern A). `checkable: true` adds a
switch at the header's right edge, which toggles on its own. When on, the
header turns tonal and the border accent, like a tile; the content stays calm.
The header's description summarizes the current state (`headphones · 51%`).

### Feedback

Three kinds, in two sizes: **standard** (centered, for a whole empty area)
and **compact** (one line, actions at the far right).

| Kind    | Shows                                   | Its own behavior                    |
| ------- | --------------------------------------- | ----------------------------------- |
| Empty   | a muted icon: nothing here (yet)        | a next step (`action`) and a link   |
| Loading | a spinner: working on it                | can be cancellable                  |
| Error   | the icon in `error`: something went wrong | retry, and the raw error as details |

A positive empty state says so: "all caught up", not "no notifications".

## States (every interactive component)

| State          | Look                                                         |
| -------------- | ------------------------------------------------------------ |
| hover          | a layer of the content color at 8 %                          |
| pressed        | that layer at 10 %                                           |
| keyboard focus | a 2 px `primary` ring                                        |
| selected / on  | a `secondary_container` fill; an accent border if it has one |
| disabled       | neutral gray, never a faded color (Material 3): content at 38 % and containers or outlines at 12 % of `on_surface` |

## Motion

Everything starts moving on the same frame as the click or keypress; nothing
makes you wait at the end.

| What                          | Duration | Curve                 |
| ----------------------------- | -------- | --------------------- |
| small things (hover, toggles) | 100 ms   | ease-out              |
| panel opening                 | 200 ms   | ease-out (fast start) |
| panel closing                 | 150 ms   | ease-in (fast finish) |

Only things that change because of an action or new data move.

In code, every animation uses `Glide` (numbers) or `ColorGlide` (colors) from
`behaviors/`, so these values live in one place.

## Library structure

```
theme/                tokens: Colors, Type, Spacing, Shape, Motion, States
components/behaviors/ how things react: Interactive, Glide, ColorGlide
components/ui/        Surface, and one folder per family
gallery/              every component in its variants and states (fake data)
```

The rules every family follows:

1. **Every family has an internal `Base`**: the family's shared building
   block. Public members inherit it, or contain it where inheriting is
   impossible.
2. **Behavior comes from `behaviors/`**, never written inside a component.
3. **Families import each other qualified** (`import components.ui.mark as Mark`
   → `Mark.Switch`), so each file has exactly one unqualified `Base`: its own.
4. **Content sets a role, not a final color**: texts and marks take a `tone`,
   and their `Base` turns it gray when disabled. Boxes set `fill` and `line`,
   and `Surface` draws the states.
5. **The owner holds the value.** A component is told its value (`checked`,
   `open` where the owner wants it) and reports what happened (`clicked`,
   `switched`, `acted`). It never knows what the value means: no component
   knows about Wi-Fi, Bluetooth or commands. That belongs to the OS controls,
   a separate layer.
6. **Public types are named by kind** (`Button.Tile`); `Basic` is a family's
   plain, everyday member. A file that only sets properties is a preset, not
   a component.
7. **Never name a type after a built-in QML type** (`Row`, `Text`, `State`…):
   inside its own folder, the built-in wins.

## Naming

Roles are an interface; themes implement it (Material from the wallpaper first,
others later). Values and properties are snake_case (`on_primary`,
`padding_x`), types are PascalCase (`Colors`, `ListItem`).
