import QtQuick
import QtQuick.Templates as T
import theme

// Qt owns the popup: positioning beside the opener, focus trapping, Esc,
// click-outside, keyboard navigation. Our v1 Overlay/Popup is all of this, free.
T.Menu {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    overlap: 0
    padding: Spacing.tight

    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: contentHeight > 400
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: Rectangle {
        implicitWidth: 180
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
