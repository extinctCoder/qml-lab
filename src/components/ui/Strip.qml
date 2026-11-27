import QtQuick
import theme

Item {
    id: root

    property alias leading: lead.data
    property alias trailing: trail.data
    default property alias middle: mid.data
    property real spacing: Spacing.inner
    property real gap: Spacing.inner
    property real middle_width: 0

    readonly property real middle_used: middle_width > 0 ? middle_width : mid.children.reduce((w, c) => c.visible ? Math.max(w, c.implicitWidth) : w, 0)
    readonly property real middle_height: mid.children.reduce((h, c) => c.visible ? Math.max(h, c.height) : h, 0)
    readonly property var parts: [lead.width, middle_used, trail.width].filter(w => w > 0)

    implicitWidth: parts.reduce((sum, w) => sum + w, 0) + gap * Math.max(0, parts.length - 1)
    implicitHeight: Math.max(lead.implicitHeight, trail.implicitHeight, middle_height)

    Row {
        id: lead
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: root.spacing
    }

    Item {
        id: mid
        x: lead.width > 0 ? lead.width + root.gap : 0
        anchors.verticalCenter: parent.verticalCenter
        width: root.middle_width > 0 ? root.middle_width : root.width - x - (trail.width > 0 ? trail.width + root.gap : 0)
        height: root.middle_height
    }

    Row {
        id: trail
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: root.spacing
    }
}
