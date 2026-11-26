import QtQuick
import theme
import components.behaviors
import components.ui.text as Text

Base {
    id: root

    property int size: 64
    property int thickness: 8

    property real shown_ratio: ratio
    Behavior on shown_ratio {
        Glide {}
    }

    implicitWidth: Math.max(size, title_text.implicitWidth)
    implicitHeight: size + (title_text.visible ? Spacing.tight + title_text.implicitHeight : 0)

    Canvas {
        id: canvas
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.size
        height: root.size
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            const r = (width - root.thickness) / 2;
            const start = -Math.PI / 2;
            ctx.lineWidth = root.thickness;
            ctx.lineCap = "butt";
            ctx.strokeStyle = Colors.surface_container_highest;
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, r, 0, Math.PI * 2);
            ctx.stroke();
            if (root.shown_ratio > 0) {
                ctx.strokeStyle = root.shown_tone;
                ctx.beginPath();
                ctx.arc(width / 2, height / 2, r, start, start + Math.PI * 2 * root.shown_ratio);
                ctx.stroke();
            }
        }
    }
    onShown_ratioChanged: canvas.requestPaint()
    onShown_toneChanged: canvas.requestPaint()
    onSizeChanged: canvas.requestPaint()

    Text.Mono {
        anchors.centerIn: canvas
        text: root.label
        size: "label"
    }

    Text.Mono {
        id: title_text
        visible: root.title !== ""
        anchors.top: canvas.bottom
        anchors.topMargin: Spacing.tight
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.title
        size: "label"
        muted: true
    }
}
