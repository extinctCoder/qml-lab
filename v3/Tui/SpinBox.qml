import QtQuick
import QtQuick.Templates as T
import theme

// Our stepper: − value + in a box. Qt owns the value logic, clamping, editing,
// and the buttons' auto-repeat; we skin it.
T.SpinBox {
    id: control

    readonly property int ind: 28

    implicitWidth: 140
    implicitHeight: 28
    padding: 0
    leftPadding: ind
    rightPadding: ind
    font.family: Type.family
    font.pixelSize: Type.body
    editable: true

    validator: IntValidator {
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        text: control.displayText
        font: control.font
        color: control.enabled ? Colors.on_surface : States.disabled_text
        selectionColor: Colors.secondary_container
        selectedTextColor: Colors.on_secondary_container
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    down.indicator: Rectangle {
        x: 0
        y: 0
        width: control.ind
        height: control.height
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "−"
            color: control.enabled ? Colors.primary : States.disabled_text
            font.family: Type.family
            font.pixelSize: Type.title
        }
        Rectangle {
            anchors.fill: parent
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.down.pressed ? States.pressed : control.down.hovered ? States.hover : 0
            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }

    up.indicator: Rectangle {
        x: control.width - width
        y: 0
        width: control.ind
        height: control.height
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "+"
            color: control.enabled ? Colors.primary : States.disabled_text
            font.family: Type.family
            font.pixelSize: Type.title
        }
        Rectangle {
            anchors.fill: parent
            color: Colors.on_surface
            opacity: !control.enabled ? 0 : control.up.pressed ? States.pressed : control.up.hovered ? States.hover : 0
            Behavior on opacity {
                NumberAnimation { duration: Motion.small }
            }
        }
    }

    background: Rectangle {
        implicitWidth: 140
        implicitHeight: 28
        radius: Shape.radius
        color: "transparent"
        border.width: Shape.border
        border.color: control.enabled ? Colors.outline_variant : States.disabled_fill
    }
}
