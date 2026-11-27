import QtQuick

// Fills a control and turns the mouse wheel over it into a value change:
// scroll up for `up`/+step, down for `down`/-step. The hallmark shell gesture
// (scroll over the volume or brightness bar). Place it over a Range or a
// workspace strip and wire `adjusted`.
Item {
    id: root

    property real step: 1
    property bool enabled_: true
    signal adjusted(real delta)
    signal up
    signal down

    WheelHandler {
        enabled: root.enabled_
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {
            const dir = event.angleDelta.y >= 0 ? 1 : -1;
            if (dir > 0)
                root.up();
            else
                root.down();
            root.adjusted(dir * root.step);
        }
    }
}
