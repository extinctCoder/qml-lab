import QtQuick
import QtQuick.Templates as T
import theme

// A transient hint. Qt owns the show/hide timing (delay, timeout) — the
// "Transient" behaviour we built by hand in v1 is simply ToolTip here.
T.ToolTip {
    id: control

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - Spacing.tight

    margins: Spacing.tight
    padding: Spacing.tight + 2
    delay: 500
    font.family: Type.family
    font.pixelSize: Type.label

    contentItem: Text {
        text: control.text
        font: control.font
        color: Colors.on_surface
        wrapMode: Text.Wrap
    }

    background: Rectangle {
        color: Colors.surface_container_highest
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Motion.open; easing.type: Motion.ease_out }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Motion.close; easing.type: Motion.ease_in }
    }
}
