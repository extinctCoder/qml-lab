import QtQuick
import theme
import components.ui
import components.behaviors
import components.ui.button as Button
import components.ui.text as Text
import components.ui.mark as Mark

Item {
    id: root

    property var options: []
    property string current: ""
    property string placeholder: "choose…"
    property bool searchable: false
    property int rows: 8
    signal picked(var option)

    implicitWidth: 200
    implicitHeight: button.implicitHeight

    Button.Basic {
        id: button
        anchors.fill: parent
        variant: "outline"
        onClicked: popup.show(button, root.current)
    }

    Text.Mono {
        anchors.left: parent.left
        anchors.leftMargin: Spacing.gap
        anchors.right: chevron.left
        anchors.rightMargin: Spacing.inner
        anchors.verticalCenter: parent.verticalCenter
        text: root.current !== "" ? root.current : root.placeholder
        size: "label"
        muted: root.current === ""
        tone: root.current !== "" ? Colors.primary : Colors.on_surface_variant
        maximumLineCount: 1
        elide: Qt.ElideRight
    }

    Mark.Chevron {
        id: chevron
        anchors.right: parent.right
        anchors.rightMargin: Spacing.inner
        anchors.verticalCenter: parent.verticalCenter
        on: true
        rotation: popup.opened ? -90 : 90
    }

    Drop {
        id: popup
        anchor: button
        box_width: Math.max(root.width, 220)
        searchable: root.searchable
        rows: root.rows
        options: root.options
        onPicked: option => root.picked(option)
    }
}
