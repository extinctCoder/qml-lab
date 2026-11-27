import QtQuick
import theme

// A live audio spectrum: one thin bar per frequency bin, mirrored around the
// middle like an equaliser. The block-bar shape is the terminal's own (cava).
// Unlike Columns (a record of values over time), this is a snapshot of a
// signal right now — the owner feeds it new `values` each frame.
Base {
    id: root

    property bool mirror: true

    plot_height: 28

    function draw(ctx, w, h) {
        const n = values.length;
        if (n === 0)
            return;
        const gap = 1;
        const bw = Math.max(1, (w - gap * (n - 1)) / n);
        ctx.fillStyle = shown_tone;
        for (let i = 0; i < n; i++) {
            const x = i * (bw + gap);
            const mag = ratio(values[i]);
            if (root.mirror) {
                const half = Math.max(0.5, mag * h / 2);
                ctx.fillRect(x, h / 2 - half, bw, half * 2);
            } else {
                const bh = Math.max(1, mag * h);
                ctx.fillRect(x, h - bh, bw, bh);
            }
        }
    }
}
