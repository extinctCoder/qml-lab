import QtQuick

// A Canvas that repaints through a supplied painter(ctx, w, h). The drawn
// families (mark, chart) share this one scaffold instead of each re-owning a
// Canvas with the same reset-then-draw boilerplate. Each family's Base points
// `painter` at its own draw(); each kind writes that draw().
Canvas {
    id: root

    property var painter: null

    function repaint() {
        requestPaint();
    }

    onPaint: {
        const ctx = getContext("2d");
        ctx.reset();
        if (painter)
            painter(ctx, width, height);
    }
}
