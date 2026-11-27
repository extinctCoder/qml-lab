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
   A **group** (tabs, a radio list, segmented buttons, a check list) is a
   single Tab stop: the arrows move inside it, Home and End jump to its ends,
   and Tab leaves it. In tabs, radios and segmented buttons, moving also
   selects; in a check list, it only moves, and Space toggles.
7. **Selection never relies on color alone**: every on/off state also changes
   shape or position (a filled radio, a filled check, a switch's thumb).
8. **Searching keeps focus in the field.** In a list you filter by typing,
   ↑ ↓ (or Ctrl+N/P) move a highlight while you keep typing, and Enter picks
   the highlighted one. The highlight looks exactly like hover, and hovering
   moves it: one current item, whichever device you use.
9. **Popups stay with what opened them.** A select or a menu opens next to
   its opener (above it when there's no room below). Esc closes it and gives
   focus back to the opener; a click outside or scrolling closes it; Tab and
   Shift+Tab close it and continue from the opener, as if it had never been
   open.

## Components

The library is built bottom-up. Each family is a folder; what it offers:

| Family     | Public types                            | What they are                                          |
| ---------- | --------------------------------------- | ------------------------------------------------------ |
| (core)     | `Surface`, `Strip`, `Labeled`           | our look for any box; the row layout; a labeled row    |
| `text`     | `Mono`, `Header`                        | text; an icon spanning a title and description         |
| `mark`     | `Switch`, `Choice`, `Chevron`, `Spinner`, `Eye` | small drawn markers that show a state by shape |
| `button`   | `Basic`, `ListItem`, `Tile`, `Mark`     | everything you press: a button, a list row, a tile, a mark |
| `section`  | `Basic`                                 | a box whose header folds its content open and closed  |
| `feedback` | `Empty`, `Loading`, `Error`             | what's shown when there's nothing (yet) to show        |
| `range`    | `Basic`, `Slider`, `Progress`, `Steps`, `Ring`, `Seek` | a value between a minimum and a maximum |
| `tabs`     | `Basic`                                 | switching between views of the same place              |
| `field`    | `Basic`, `Search`, `Password`           | typing one line of text                                |
| `picker`   | `Palette`, `Select`, `Menu`             | finding and picking one of many options                |
| `badge`    | `Tag`, `Count`, `Dot`                   | small labels: a word, a number, something new          |
| `chart`    | `Spark`, `Columns`, `Lines`             | many values over time                                  |

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
box in a grid: an action (`→`), or on/off with a switch. `Mark` is a small
button that shows a drawn mark (a section's switch, a password's eye); the
mark shows the state, so it never takes the tonal selected fill.

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

### Ranges

A value between a minimum and a maximum, drawn as a **block bar**: a track,
and the filled part in the accent. Every kind shares the same colors, 2 px
corners and square ends, and the same row: an icon or a title on the left,
a label on the right. Rows in a list share a `title_width`, so their bars
line up like columns.

| Kind     | Shows                                   | Where                              |
| -------- | --------------------------------------- | ---------------------------------- |
| Basic    | a value, read-only                      | battery, cpu, memory               |
| Slider   | a value you can change (drag, click, ← →) | volume, brightness, per-app volume |
| Progress | how far work has got, or a moving stripe when unknown | updates, scanning, countdowns |
| Steps    | a few rising bars                       | signal, levels in the bar          |
| Ring     | the bar bent into a circle              | dashboard gauges                   |
| Seek     | a slider in seconds (`m:ss`), with what's loaded | media position            |

### Fields

One line of text in a box. Focus is shown by the border itself (2 px in the
accent) instead of a ring around it, since you type inside it; an error turns
that border `error` and shows a short message below, and the field stays
editable so it can be fixed. The cursor is a calm blinking block. Enter
submits, Esc clears the text, then leaves. `Search` adds a search icon and a
clear button `×`; `Password` hides the text, and its eye shows it.

### Pickers

A list of options (`{ icon, title, description, meta }`) to find one and pick
it. Matching is fuzzy, like fzf: the typed letters must appear in order, and
letters that start words, follow each other or start the name rank higher
(`gst` finds **g**ho**st**ty). The matched letters show in the accent.

| Kind    | Shows                                           | Where                           |
| ------- | ----------------------------------------------- | ------------------------------- |
| Palette | a search field with the results under it        | launcher, clipboard, emoji      |
| Select  | a button with the current value; opens on it    | profiles, layouts, any dropdown |
| Menu    | a popup list; typing jumps to a match           | context and tray menus          |

### Badges

Small labels in the same box language: 2 px corners and a 1 px border or a
fill. A `Tag` is a short word (outlined, accent, tonal or error), a `Count` a
number on an icon's corner (`99+` above the limit, hidden at 0), and a `Dot`
says "something new" without a number.

### Charts

Many values over time, in the range colors: the track and the accent, with a
second series in muted gray. A `Spark` is a small line with a faint filled
area next to its value, `Columns` one block per value, and `Lines` two series
in one plot. No axes or gridlines; the latest value is the label. The scale is
fixed (0 to 100) or follows the highest value.

### Tabs

Tabs switch between views of the same place. The active tab's word is bright,
the others muted, and a 2 px accent line under the active word slides to the
new tab. The bar is one Tab stop; the arrows select. Showing the view is the
owner's job.

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
components/behaviors/ how things react: Interactive, Roving, Highlight, Popup,
                      Glide, ColorGlide, and the fuzzy matcher
components/ui/        Surface, Strip and Labeled, and one folder per family
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
8. **Groups move with the arrows.** Anything with an `Interactive` can join a
   `Roving` group; the group keeps one Tab stop and handles the arrows.
9. **Every row is a `Strip`**: a leading group, a middle that fills, and a
   trailing group. Rows are never laid out by hand, so they all line up the
   same way.
10. **Drawn things draw in their `Base`.** A mark's or a chart's `Base` owns
   the canvas and repaints it; each kind only writes `draw()`.
11. **Size from what children want, not where they are.** A box measures its
   children's sizes (implicit sizes), never their positions (`childrenRect`),
   since children often position themselves relative to the box: that's a
   binding loop.

## Naming

Roles are an interface; themes implement it (Material from the wallpaper first,
others later). Values and properties are snake_case (`on_primary`,
`padding_x`), types are PascalCase (`Colors`, `ListItem`).
