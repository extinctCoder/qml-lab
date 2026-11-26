import QtQuick
import theme

// How a color changes: it glides instead of jumping, with the design system's motion
// (Motion.small, fast start). Use it in a Behavior: `Behavior on color { ColorGlide {} }`.
ColorAnimation {
    duration: Motion.small
    easing.type: Motion.ease_out
}
