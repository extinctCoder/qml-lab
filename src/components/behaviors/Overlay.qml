import QtQuick

// The shared shell for anything that floats over the whole window and takes the
// keyboard: it finds the window overlay, tracks opened/opener, and returns
// focus to the opener on close. Popup adds placement beside its anchor and the
// Tab-chain rules; Dialog adds a scrim and centering. Give it an `anchor` in
// the scene so it can reach the overlay. Subclasses provide their own box and,
// on `openedChanged`, focus it.
FocusScope {
    id: root

    property Item anchor: null
    property bool opened: false
    property Item opener: null
    property int z_order: 1000
    signal closed

    readonly property Item overlay: anchor ? anchor.Window.contentItem : null

    function open(from) {
        const source = from ? from : anchor;
        opener = source && source.focus_target ? source.focus_target : source;
        opened = true;
    }

    function close() {
        if (!opened)
            return;
        opened = false;
        if (opener)
            opener.forceActiveFocus();
        closed();
    }

    parent: overlay
    anchors.fill: parent
    z: z_order
    visible: opened
}
