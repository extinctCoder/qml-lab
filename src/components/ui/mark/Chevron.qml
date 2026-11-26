import QtQuick
import theme

Base {
    id: root

    on_color: Colors.on_surface_variant
    off_color: Colors.on_surface_variant

    implicitWidth: 12
    implicitHeight: 12
    rotation: on ? 90 : 0

    Behavior on rotation {
        NumberAnimation {
            duration: Motion.small
            easing.type: Motion.ease_out
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = root.tone;
            ctx.lineWidth = 2;
            ctx.lineCap = "square";
            ctx.beginPath();
            ctx.moveTo(width * 0.35, height * 0.2);
            ctx.lineTo(width * 0.7, height * 0.5);
            ctx.lineTo(width * 0.35, height * 0.8);
            ctx.stroke();
        }
    }
    onToneChanged: canvas.requestPaint()
}
