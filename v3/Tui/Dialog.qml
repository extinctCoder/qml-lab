import QtQuick
import QtQuick.Templates as T
import theme

T.Dialog {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: Spacing.gap

    background: Rectangle {
        color: Colors.surface_container_high
        radius: Shape.radius
        border.width: Shape.border
        border.color: Colors.outline_variant
    }

    header: Text {
        text: control.title
        visible: control.title
        elide: Text.ElideRight
        padding: Spacing.gap
        bottomPadding: Spacing.inner
        color: Colors.on_surface
        font.family: Type.family
        font.pixelSize: Type.title
    }

    footer: DialogButtonBox { visible: count > 0 }

    T.Overlay.modal: Rectangle { color: Qt.rgba(0.02, 0.02, 0.04, 0.6) }
    T.Overlay.modeless: Rectangle { color: Qt.rgba(0.02, 0.02, 0.04, 0.4) }
}
