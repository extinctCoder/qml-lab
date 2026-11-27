import QtQuick
import QtQuick.Templates as T
import theme

T.MenuBarItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: Spacing.inner
    spacing: Spacing.tight
    font.family: Type.family
    font.pixelSize: Type.body

    readonly property bool current: control.down || control.highlighted

    contentItem: Text {
        text: control.text
        font: control.font
        color: !control.enabled ? States.disabled_text
            : control.current ? Colors.on_secondary_container : Colors.on_surface
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 28
        radius: Shape.radius
        color: control.current ? Colors.secondary_container : "transparent"
    }
}
