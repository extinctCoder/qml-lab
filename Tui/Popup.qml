import QtQuick
import QtQuick.Templates as T
import theme

// The generic floating surface — the base every popup shares. Lifted surface,
// hairline border, square corners.
T.Popup {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: Spacing.inner

    background: Rectangle {
        color: Colors.surface_container_highest
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Motion.open; easing.type: Motion.ease_out }
        NumberAnimation { property: "scale"; from: 0.97; to: 1; duration: Motion.open; easing.type: Motion.ease_out }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Motion.close; easing.type: Motion.ease_in }
    }
}
