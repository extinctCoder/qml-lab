import QtQuick

Base {
    id: root

    property bool indeterminate: false

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
            indeterminate: root.indeterminate
        }
    }
}
