import QtQuick
import theme
import components.ui
import components.ui.text as Text

Surface {
    id: root

    property string text: ""
    property string look: "outlined"

    readonly property var looks: ({
            outlined: { appearance: "outlined", fill: "transparent", line: Colors.outline_variant, text: Colors.on_surface_variant },
            accent: { appearance: "outlined", fill: "transparent", line: Colors.primary, text: Colors.primary },
            tonal: { appearance: "filled", fill: Colors.secondary_container, line: Colors.secondary_container, text: Colors.on_secondary_container },
            filled: { appearance: "filled", fill: Colors.primary, line: Colors.primary, text: Colors.on_primary },
            error: { appearance: "outlined", fill: "transparent", line: Colors.error, text: Colors.error },
            alarm: { appearance: "filled", fill: Colors.error, line: Colors.error, text: Colors.on_error }
        })
    readonly property var current: looks[look] ? looks[look] : looks.outlined

    appearance: current.appearance
    fill: current.fill
    line: current.line
    padding_x: text !== "" ? Spacing.tight + 2 : 0
    padding_y: 0

    Text.Mono {
        visible: root.text !== ""
        text: root.text
        size: "label"
        tone: root.current.text
        horizontalAlignment: Qt.AlignHCenter
        width: Math.max(implicitWidth, implicitHeight - (root.padding_x * 2))
    }
}
