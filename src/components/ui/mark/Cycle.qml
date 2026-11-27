import QtQuick
import theme

// A marker for a value with three or more states (a media loop: off → all →
// one). It draws `count` pips with the current `index` filled in the accent;
// the rest are outlined. The shape shows the state, so a button wrapping it
// never needs the tonal selected fill. The owner advances `index` on click.
Base {
    id: root

    property int index: 0
    property int count: 3

    drawn: true
    on: index > 0
    implicitWidth: count * 6 - 2
    implicitHeight: 6

    onIndexChanged: repaint()
    onCountChanged: repaint()

    function draw(ctx, w, h) {
        const fill = enabled ? on_color : States.disabled_text;
        const line = enabled ? off_color : States.disabled_text;
        const r = 2;
        for (let i = 0; i < count; i++) {
            const cx = r + i * 6;
            ctx.beginPath();
            ctx.arc(cx, h / 2, r, 0, Math.PI * 2);
            if (i === index) {
                ctx.fillStyle = fill;
                ctx.fill();
            } else {
                ctx.strokeStyle = line;
                ctx.lineWidth = 1;
                ctx.stroke();
            }
        }
    }
}
