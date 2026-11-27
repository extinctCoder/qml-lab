import QtQuick
import theme

Base {
    id: root

    property bool error: false

    look: error ? "alarm" : "filled"
    implicitWidth: 6
    implicitHeight: 6
}
