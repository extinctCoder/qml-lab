import QtQuick
import theme
import components.behaviors

Rectangle {
    id: root

    property real ratio: 0
    property real buffered_ratio: 0
    property color tone: Colors.primary
    property bool indeterminate: false

    width: parent ? parent.width : 200
    height: 10
    radius: Shape.radius
    color: Colors.surface_container_highest
    clip: true

    Rectangle {
        visible: !root.indeterminate && root.buffered_ratio > root.ratio
        width: root.width * root.buffered_ratio
        height: parent.height
        radius: Shape.radius
        color: Colors.outline_variant

        Behavior on width {
            Glide {}
        }
    }

    Rectangle {
        visible: !root.indeterminate
        width: root.width * root.ratio
        height: parent.height
        radius: Shape.radius
        color: root.tone

        Behavior on width {
            Glide {}
        }
    }

    Rectangle {
        id: stripe
        visible: root.indeterminate
        width: root.width * 0.3
        height: parent.height
        radius: Shape.radius
        color: root.tone

        NumberAnimation on x {
            from: -stripe.width
            to: root.width
            duration: 1400
            easing.type: Easing.InOutQuad
            loops: Animation.Infinite
            running: root.indeterminate && root.visible
        }
    }
}
