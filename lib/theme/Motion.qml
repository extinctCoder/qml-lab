pragma Singleton
import QtQuick

QtObject {
    readonly property int small: 100
    readonly property int open: 200
    readonly property int close: 150

    readonly property int ease_out: Easing.OutCubic
    readonly property int ease_in: Easing.InCubic
}
