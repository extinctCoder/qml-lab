import QtQuick
import QtQuick.Templates as T
import theme

// Our Select. Qt owns the popup, keyboard, and the type-to-jump search; the
// drop list reuses our ItemDelegate, so a row looks the same everywhere.
T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: Spacing.inner
    leftPadding: Spacing.gap
    rightPadding: (control.indicator ? control.indicator.width : 0) + Spacing.inner
    spacing: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.label

    delegate: ItemDelegate {
        required property int index
        required property var modelData
        width: ListView.view ? ListView.view.width : control.width
        text: modelData
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: Text {
        x: control.mirrored ? Spacing.inner : control.width - width - Spacing.inner
        y: control.topPadding + (control.availableHeight - height) / 2
        text: "▾"
        font.family: Type.family
        font.pixelSize: Type.body
        color: control.enabled ? Colors.primary : States.disabled_text
    }

    contentItem: Text {
        text: control.displayText
        font: control.font
        color: control.enabled ? Colors.primary : States.disabled_text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 140
        implicitHeight: 28
        radius: Shape.radius
        color: "transparent"
        border.width: Shape.border
        border.color: !control.enabled ? States.disabled_fill
            : control.visualFocus ? Colors.primary : Colors.outline

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.pressed ? States.pressed
                : (control.hovered || control.visualFocus) ? States.hover : 0

            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }

    popup: T.Popup {
        y: control.height + Spacing.tight
        width: control.width
        implicitHeight: Math.min(contentItem.implicitHeight + 2, 240)
        padding: Shape.border

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            boundsBehavior: Flickable.StopAtBounds

            ScrollIndicator.vertical: ScrollIndicator {}
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
}
