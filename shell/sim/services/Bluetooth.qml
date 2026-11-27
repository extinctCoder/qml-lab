pragma Singleton
import QtQuick

// `available` is the adapter: a desktop without Bluetooth reports false and the
// panel hides the whole control.
QtObject {
    id: root

    property bool available: true
    property bool enabled: true

    function set_enabled(on) {
        root.enabled = on
    }
}
