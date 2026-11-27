import QtQuick
import components.ui

Base {
    id: root

    readonly property alias bar: bar

    implicitHeight: line.implicitHeight

    Labeled {
        id: line
        anchors.fill: parent
        icon: root.icon
        title: root.title
        title_width: root.title_width
        label: root.label

        Bar {
            id: bar
            ratio: root.ratio
            buffered_ratio: root.buffered_ratio
            tone: root.shown_tone
        }
    }
}
