import QtQuick
import QtQuick.Templates as T
import theme

// A ring of green dots that rotates while running. No gradients, no image.
T.BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: Spacing.tight

    contentItem: Item {
        implicitWidth: 28
        implicitHeight: 28
        opacity: control.running ? 1 : 0

        Behavior on opacity { OpacityAnimator { duration: 250 } }

        Item {
            id: spinner
            anchors.fill: parent

            RotationAnimator on rotation {
                running: control.running && control.visible
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
            }

            Repeater {
                model: 8
                Rectangle {
                    required property int index
                    width: 3
                    height: 3
                    radius: width / 2
                    color: Colors.primary
                    opacity: (index + 1) / 8
                    x: spinner.width / 2 - width / 2 + Math.cos(index / 8 * 2 * Math.PI) * (spinner.width / 2 - width)
                    y: spinner.height / 2 - height / 2 + Math.sin(index / 8 * 2 * Math.PI) * (spinner.height / 2 - height)
                }
            }
        }
    }
}
