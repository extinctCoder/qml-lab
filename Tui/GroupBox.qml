import QtQuick
import QtQuick.Templates as T
import theme

// A titled, bordered container. The title sits on the top-left, the frame holds
// the content below it.
T.GroupBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                                 + (implicitLabelWidth > 0 ? label.implicitHeight + spacing : 0))

    spacing: Spacing.inner
    padding: Spacing.gap
    topPadding: padding + (implicitLabelWidth > 0 ? label.implicitHeight + spacing : 0)

    label: Text {
        x: control.leftPadding
        width: control.availableWidth
        text: control.title
        color: Colors.on_surface_variant
        font.family: Type.family
        font.pixelSize: Type.label
        elide: Text.ElideRight
    }

    background: Rectangle {
        y: control.topPadding - control.bottomPadding - control.padding
        width: parent.width
        height: parent.height - control.topPadding + control.padding + control.bottomPadding
        color: "transparent"
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant
    }
}
