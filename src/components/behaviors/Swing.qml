import QtQuick
import theme

// A Glide that knows which way it is going. Opening is fast-start (ease-out,
// Motion.open); closing is fast-finish (ease-in, Motion.close). Bind `opened`
// and the open/close timing law lives in exactly one place — used by anything
// that shows and hides (Popup, Dialog, Reveal, a section's body).
NumberAnimation {
    property bool opened: true

    duration: opened ? Motion.open : Motion.close
    easing.type: opened ? Motion.ease_out : Motion.ease_in
}
