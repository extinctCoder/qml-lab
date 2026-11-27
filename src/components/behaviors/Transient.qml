import QtQuick

// A presence controller: show it, it lingers, then dismisses itself.
// `shown` is what a component binds its opacity/visibility to. Powers Toast,
// OSD and Tooltip. `held` (e.g. while hovered) pauses the countdown.
// duration 0 means stay until dismiss() is called.
QtObject {
    id: root

    property int duration: 2000
    property bool shown: false
    property bool held: false
    signal dismissed

    function show() {
        shown = true;
        restart();
    }

    function restart() {
        if (shown && duration > 0 && !held)
            timer.restart();
        else
            timer.stop();
    }

    function dismiss() {
        if (!shown)
            return;
        shown = false;
        timer.stop();
        dismissed();
    }

    onHeldChanged: restart()

    property Timer timer: Timer {
        interval: root.duration
        onTriggered: root.dismiss()
    }
}
