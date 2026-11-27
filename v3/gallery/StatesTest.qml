import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// State matrix for the Tui style. Every Tui-styled control × every colour-bearing
// state. The point to verify: the active mark is the SAME green everywhere
// (checkbox, radio, switch, slider, progress, selected row), because every Tui
// delegate reads Colors.primary. Forced states: down/checked/disabled declaratively;
// visualFocus via the driver. Focus reuses the hover layer by design.
Theme {
    id: root
    width: 1180
    height: 1180

    component Cell: ColumnLayout {
        property string cap
        default property alias body: holder.data
        spacing: 3
        Label {
            text: parent.cap
            color: Colors.on_surface_variant
            font.pixelSize: 11
            font.family: Type.family
        }
        RowLayout { id: holder; spacing: 0 }
    }

    component Line: RowLayout {
        property string name
        Layout.fillWidth: true
        spacing: Spacing.gap
        Label {
            text: parent.name
            color: Colors.primary
            font.pixelSize: Type.body
            font.family: Type.family
            Layout.preferredWidth: 120
            Layout.alignment: Qt.AlignTop
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        ColumnLayout {
            width: root.width
            spacing: Spacing.edge

            Item { implicitHeight: 4 }
            Label {
                text: "state matrix · Tui style · M3 tokens"
                color: Colors.primary
                font.pixelSize: Type.title
                Layout.leftMargin: Spacing.edge
            }

            ColumnLayout {
                Layout.leftMargin: Spacing.edge
                Layout.rightMargin: Spacing.edge
                Layout.fillWidth: true
                spacing: Spacing.edge

                Line {
                    name: "Button variant"
                    Cell { cap: "outline"; Button { text: "btn" } }
                    Cell { cap: "primary"; Button { text: "btn"; variant: "primary" } }
                    Cell { cap: "tonal"; Button { text: "btn"; variant: "tonal" } }
                    Cell { cap: "ghost"; Button { text: "btn"; variant: "ghost" } }
                    Cell { cap: "danger"; Button { text: "btn"; variant: "danger" } }
                }

                Line {
                    name: "Button state"
                    Cell { cap: "default"; Button { text: "btn"; variant: "primary" } }
                    Cell { cap: "pressed"; Button { text: "btn"; variant: "primary"; down: true } }
                    Cell { cap: "focus"; Button { objectName: "focusBtn"; text: "btn"; variant: "primary" } }
                    Cell { cap: "checked"; Button { text: "btn"; checkable: true; checked: true } }
                    Cell { cap: "disabled"; Button { text: "btn"; variant: "primary"; enabled: false } }
                }

                Line {
                    name: "CheckBox"
                    Cell { cap: "off"; CheckBox { text: "x" } }
                    Cell { cap: "on"; CheckBox { text: "x"; checked: true } }
                    Cell { cap: "pressed"; CheckBox { text: "x"; checked: true; down: true } }
                    Cell { cap: "focus"; CheckBox { objectName: "focusCheck"; text: "x"; checked: true } }
                    Cell { cap: "disabled"; CheckBox { text: "x"; checked: true; enabled: false } }
                }

                Line {
                    name: "RadioButton"
                    Cell { cap: "off"; RadioButton { text: "x" } }
                    Cell { cap: "on"; RadioButton { text: "x"; checked: true } }
                    Cell { cap: "pressed"; RadioButton { text: "x"; checked: true; down: true } }
                    Cell { cap: "focus"; RadioButton { objectName: "focusRadio"; text: "x"; checked: true } }
                    Cell { cap: "disabled"; RadioButton { text: "x"; checked: true; enabled: false } }
                }

                Line {
                    name: "Switch"
                    Cell { cap: "off"; Switch { text: "x" } }
                    Cell { cap: "on"; Switch { text: "x"; checked: true } }
                    Cell { cap: "pressed"; Switch { text: "x"; checked: true; down: true } }
                    Cell { cap: "focus"; Switch { objectName: "focusSwitch"; text: "x"; checked: true } }
                    Cell { cap: "disabled"; Switch { text: "x"; checked: true; enabled: false } }
                }

                Line {
                    name: "TextField"
                    Cell { cap: "placeholder"; TextField { placeholderText: "host…"; implicitWidth: 140 } }
                    Cell { cap: "filled"; TextField { text: "home"; implicitWidth: 140 } }
                    Cell { cap: "focus"; TextField { objectName: "focusField"; text: "home"; implicitWidth: 140 } }
                    Cell { cap: "disabled"; TextField { text: "home"; enabled: false; implicitWidth: 140 } }
                }

                Line {
                    name: "ComboBox · SpinBox"
                    Cell { cap: "combo"; ComboBox { model: ["eco", "perf"]; implicitWidth: 130 } }
                    Cell { cap: "combo·off"; ComboBox { model: ["eco", "perf"]; enabled: false; implicitWidth: 130 } }
                    Cell { cap: "spin"; SpinBox { value: 3; implicitWidth: 130 } }
                    Cell { cap: "spin·off"; SpinBox { value: 3; enabled: false; implicitWidth: 130 } }
                }

                Line {
                    name: "Slider"
                    Cell { cap: "value"; Slider { value: 0.55; implicitWidth: 160 } }
                    Cell { cap: "focus"; Slider { objectName: "focusSlider"; value: 0.55; implicitWidth: 160 } }
                    Cell { cap: "disabled"; Slider { value: 0.55; enabled: false; implicitWidth: 160 } }
                }

                Line {
                    name: "ProgressBar"
                    Cell { cap: "value"; ProgressBar { value: 0.62; implicitWidth: 160 } }
                    Cell { cap: "indeterminate"; ProgressBar { indeterminate: true; implicitWidth: 160 } }
                    Cell { cap: "disabled"; ProgressBar { value: 0.62; enabled: false; implicitWidth: 160 } }
                }

                Line {
                    name: "ItemDelegate"
                    Cell { cap: "default"; ItemDelegate { text: "row"; implicitWidth: 150 } }
                    Cell { cap: "selected"; ItemDelegate { text: "row"; highlighted: true; implicitWidth: 150 } }
                    Cell { cap: "pressed"; ItemDelegate { text: "row"; down: true; implicitWidth: 150 } }
                    Cell { cap: "disabled"; ItemDelegate { text: "row"; enabled: false; implicitWidth: 150 } }
                }

                ColumnLayout {
                    spacing: 3
                    Label { text: "TabBar"; color: Colors.primary; font.pixelSize: Type.body }
                    TabBar {
                        implicitWidth: 420
                        TabButton { text: "current" }
                        TabButton { text: "other" }
                        TabButton { text: "third" }
                    }
                }
            }
            Item { implicitHeight: Spacing.edge }
        }
    }
}
