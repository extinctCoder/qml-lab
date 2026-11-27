import QtQuick
import QtQuick.Templates as T
import theme

// A transient hint. Qt owns the show/hide timing. Explicit implicit sizing so the
// background always wraps the text (a bare Text with no width can collapse it).
T.ToolTip {
    id: control

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - Spacing.tight

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    margins: Spacing.tight
    padding: Spacing.inner
    verticalPadding: Spacing.tight
    delay: 500
    font.family: Type.family
    font.pixelSize: Type.label

    contentItem: Text {
        text: control.text
        font: control.font
        color: Colors.on_surface
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 24
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
