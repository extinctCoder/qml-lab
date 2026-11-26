import QtQuick
import theme

// How a number changes: it glides instead of jumping, with the design system's motion
// (Motion.small, fast start). Use it in a Behavior: `Behavior on x { Glide {} }`.
// For a different duration or easing (e.g. opening and closing), set them on it.
NumberAnimation {
    duration: Motion.small
    easing.type: Motion.ease_out
}
