import QtQuick
import QtQuick.Templates as T
import theme

T.PageIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: Spacing.tight
    spacing: Spacing.tight

    delegate: Rectangle {
        required property int index
        implicitWidth: 6
        implicitHeight: 6
        radius: width / 2
        color: index === control.currentIndex ? Colors.primary : Colors.outline
        opacity: index === control.currentIndex ? 1 : 0.5

        Behavior on opacity { OpacityAnimator { duration: Motion.small } }
    }

    contentItem: Row {
        spacing: control.spacing
        Repeater {
            model: control.count
            delegate: control.delegate
        }
    }
}
