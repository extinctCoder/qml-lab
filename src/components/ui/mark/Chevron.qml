import QtQuick
import theme
import components.behaviors

Base {
    id: root

    drawn: true
    on_color: Colors.on_surface_variant
    off_color: Colors.on_surface_variant
    implicitWidth: 12
    implicitHeight: 12
    rotation: on ? 90 : 0

    Behavior on rotation {
        Glide {}
    }

    function draw(ctx, w, h) {
        ctx.strokeStyle = root.tone;
        ctx.lineWidth = 2;
        ctx.lineCap = "square";
        ctx.beginPath();
        ctx.moveTo(w * 0.35, h * 0.2);
        ctx.lineTo(w * 0.7, h * 0.5);
        ctx.lineTo(w * 0.35, h * 0.8);
        ctx.stroke();
    }
}
