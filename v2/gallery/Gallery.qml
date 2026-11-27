import QtQuick
import QtQuick.Controls
import theme
import primitives as P

// Plain Qt Controls, skinned by the Tui style. We wrote no behaviour — hover,
// press, focus, keyboard, checkable, exclusive groups all come from the templates.
Rectangle {
    width: 560
    height: 620
    color: Colors.surface

    property int power: 1
    property bool wifi: true
    property bool night: false
    property real volume: 55
    property real bright: 70

    Flickable {
        anchors.fill: parent
        contentWidth: width
        contentHeight: col.implicitHeight + Spacing.edge * 2
        clip: true

        Column {
            id: col
            x: Spacing.edge
            y: Spacing.edge
            width: parent.width - Spacing.edge * 2
            spacing: Spacing.gap

            Label {
                text: "Button · variants"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.inner
                Button {
                    text: "save"
                    variant: "primary"
                }
                Button {
                    text: "next"
                    variant: "tonal"
                }
                Button {
                    text: "back"
                    variant: "outline"
                }
                Button {
                    text: "cancel"
                    variant: "ghost"
                }
                Button {
                    text: "delete"
                    variant: "danger"
                }
                Button {
                    text: "off"
                    enabled: false
                }
            }

            Label {
                text: "Button · checkable · one of several (← →, auto-exclusive)"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.inner
                Button {
                    text: "eco"
                    checkable: true
                    autoExclusive: true
                    checked: true
                }
                Button {
                    text: "balanced"
                    checkable: true
                    autoExclusive: true
                }
                Button {
                    text: "performance"
                    checkable: true
                    autoExclusive: true
                }
            }

            Label {
                text: "CheckBox · RadioButton · Switch"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.edge
                Column {
                    spacing: Spacing.tight
                    CheckBox {
                        text: "wi-fi"
                        checked: true
                    }
                    CheckBox {
                        text: "bluetooth"
                    }
                    CheckBox {
                        text: "airplane"
                        enabled: false
                    }
                }
                Column {
                    spacing: Spacing.tight
                    RadioButton {
                        text: "speakers"
                    }
                    RadioButton {
                        text: "headphones"
                        checked: true
                    }
                    RadioButton {
                        text: "hdmi"
                        enabled: false
                    }
                }
                Column {
                    spacing: Spacing.tight
                    Switch {
                        text: "night light"
                        checked: night
                        onToggled: night = checked
                    }
                    Switch {
                        text: "wi-fi"
                        checked: wifi
                        onToggled: wifi = checked
                    }
                    Switch {
                        text: "off"
                        enabled: false
                    }
                }
            }

            Label {
                text: "Slider · drag, click, ← → · Tab to focus"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Slider {
                width: 360
                value: volume
                from: 0
                to: 100
                onMoved: volume = value
            }
            Slider {
                width: 360
                value: 30
                enabled: false
            }

            Label {
                text: "ProgressBar · determinate · indeterminate"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            ProgressBar {
                width: 360
                value: 0.62
            }
            ProgressBar {
                width: 360
                indeterminate: true
            }

            Label {
                text: "TextField · focus shows on the border · placeholder"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            TextField {
                width: 360
                text: "home"
            }
            TextField {
                width: 360
                placeholderText: "name this network…"
            }

            Label {
                text: "Delegates · list rows · selection: fill · check · radio"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.inner

                Rectangle {
                    width: 168
                    height: list1.height + Spacing.tight * 2
                    radius: Shape.radius
                    color: "transparent"
                    border.width: Shape.border
                    border.color: Colors.outline_variant
                    Column {
                        id: list1
                        y: Spacing.tight
                        width: parent.width
                        ItemDelegate {
                            width: parent.width
                            text: "home"
                            highlighted: true
                        }
                        ItemDelegate {
                            width: parent.width
                            text: "office-5g"
                        }
                        ItemDelegate {
                            width: parent.width
                            text: "cafe"
                            enabled: false
                        }
                    }
                }

                Rectangle {
                    width: 168
                    height: list2.height + Spacing.tight * 2
                    radius: Shape.radius
                    color: "transparent"
                    border.width: Shape.border
                    border.color: Colors.outline_variant
                    Column {
                        id: list2
                        y: Spacing.tight
                        width: parent.width
                        CheckDelegate {
                            width: parent.width
                            text: "wi-fi"
                            checked: true
                        }
                        CheckDelegate {
                            width: parent.width
                            text: "bluetooth"
                        }
                        CheckDelegate {
                            width: parent.width
                            text: "airplane"
                            enabled: false
                        }
                    }
                }

                Rectangle {
                    width: 168
                    height: list3.height + Spacing.tight * 2
                    radius: Shape.radius
                    color: "transparent"
                    border.width: Shape.border
                    border.color: Colors.outline_variant
                    Column {
                        id: list3
                        y: Spacing.tight
                        width: parent.width
                        RadioDelegate {
                            width: parent.width
                            text: "speakers"
                        }
                        RadioDelegate {
                            width: parent.width
                            text: "headphones"
                            checked: true
                        }
                        RadioDelegate {
                            width: parent.width
                            text: "hdmi"
                            enabled: false
                        }
                    }
                }
            }

            Label {
                text: "SpinBox · stepper · − value + · type, or ↑ ↓"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.gap
                SpinBox {
                    value: 3
                    from: 0
                    to: 10
                }
                SpinBox {
                    value: 50
                    from: 0
                    to: 100
                    stepSize: 5
                }
                SpinBox {
                    value: 2
                    enabled: false
                }
            }

            Label {
                text: "TabBar · ComboBox · Menu · ToolTip"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            TabBar {
                width: 360
                TabButton {
                    text: "overview"
                }
                TabButton {
                    text: "media"
                }
                TabButton {
                    text: "system"
                }
            }
            Row {
                spacing: Spacing.gap
                ComboBox {
                    width: 180
                    model: ["eco", "balanced", "performance"]
                }
                Button {
                    id: menuBtn
                    text: "⋯ actions"
                    variant: "outline"
                    onClicked: ctxMenu.popup()
                }
                Button {
                    text: "hover me"
                    variant: "ghost"
                    ToolTip.text: "a transient hint"
                    ToolTip.visible: hovered
                    ToolTip.delay: 300
                }
            }
            Menu {
                id: ctxMenu
                MenuItem {
                    text: "copy"
                }
                MenuItem {
                    text: "rename"
                }
                MenuSeparator {}
                MenuItem {
                    text: "delete"
                }
            }

            Label {
                text: "Frame · ScrollView · ScrollBar"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Frame {
                width: 360
                height: 128
                ScrollView {
                    anchors.fill: parent
                    ListView {
                        model: 20
                        delegate: ItemDelegate {
                            required property int index
                            width: ListView.view.width
                            text: "row " + (index + 1)
                        }
                    }
                }
            }

            Label {
                text: "Primitives · Divider · Keycap · Image (not controls)"
                color: Colors.primary
                font.pixelSize: Type.title
            }
            Row {
                spacing: Spacing.edge
                Column {
                    width: 150
                    spacing: Spacing.inner
                    Label {
                        text: "display"
                    }
                    P.Divider {}
                    Label {
                        text: "sound"
                    }
                    P.Divider {}
                    Label {
                        text: "network"
                    }
                }
                Column {
                    spacing: Spacing.inner
                    Row {
                        spacing: Spacing.tight
                        P.Keycap {
                            text: "⌃"
                        }
                        P.Keycap {
                            text: "esc"
                        }
                        P.Keycap {
                            text: "↵"
                        }
                    }
                    P.Combo {
                        keys: ["super", "shift", "q"]
                    }
                }
            }
            Row {
                spacing: Spacing.gap
                P.Image {
                    width: 44
                    height: 44
                    fallback: "♪"
                }
                P.Image {
                    width: 44
                    height: 44
                    fallback: "▣"
                }
                P.Avatar {
                    width: 44
                    height: 44
                    fallback: "s"
                }
                P.Avatar {
                    width: 44
                    height: 44
                    fallback: "k"
                }
            }
        }
    }
}
