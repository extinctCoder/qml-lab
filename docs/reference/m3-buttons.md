# Material 3: buttons

Source: Google's Material Web repository (`material-components/material-web`),
`docs/components/button.md` and `tokens/`. Rewritten in plain words for our
QML design system.

## In one sentence

Buttons come in levels of emphasis: the louder the button, the more important
the action, and only one action per view gets the loudest one.

## The five types, loudest to quietest

| Material 3 name | Our name | Use it for | Colors (roles) |
|---|---|---|---|
| filled | **primary** | the important, final action that completes something: *Save*, *Confirm*, *Connect*. One per view. | fill `primary`, label `onPrimary` |
| filled tonal | **tonal** | a lower-priority action that needs a bit more weight than an outline: *Next* | fill `secondaryContainer`, label `onSecondaryContainer` |
| outlined | **outline** | important, but not the main action: *Back* | border `outline`, label `primary` |
| text | **ghost** | the lowest priority, especially when there are several options (toolbars, lists, *Cancel*) | label `primary`, no fill, no border |
| elevated | *(dropped)* | a tonal button with a shadow, only when absolutely necessary | we have no shadows |

Plus **danger** (Carbon's name): destructive actions only (*Delete*, *Forget*),
using the `error` roles, as an outline or, when confirming, filled.

## States (all buttons)

| State | Material 3 | Our TUI skin |
|---|---|---|
| hover | a layer of the label color at 8 % opacity | same |
| pressed | that layer at 10 % | same |
| keyboard focus | a focus indicator | a 2 px `primary` ring (keyboard first) |
| disabled | content at 38 % opacity | same |

## In our QML

One `Button` component with a `variant` property
(`"primary"`, `"tonal"`, `"outline"`, `"ghost"`, `"danger"`) that picks the
roles above. Every button looks right in every theme, because it only ever
asks for roles, never for colors.

## Open decisions (DESIGN.md)

- Do we keep all five, or start with fewer?
- Label text: lowercase (TUI) or sentence case (Material 3 and Carbon)?
