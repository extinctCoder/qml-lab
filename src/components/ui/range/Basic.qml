import QtQuick

Base {
    id: root

    implicitHeight: line.implicitHeight

    Line {
        id: line
        anchors.fill: parent
        icon: root.icon
        title: root.title
        title_width: root.title_width
        label: root.label

        Bar {
            ratio: root.ratio
            tone: root.shown_tone
        }
    }
}
