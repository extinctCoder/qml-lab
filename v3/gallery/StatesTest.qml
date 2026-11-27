import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// State matrix: every control × every state that changes colour, so the palette
// can be proven not to break anywhere. Forced states: down (pressed), checked,
// highlighted, disabled — declaratively. hover + visualFocus are forced by the
// driver (states_driver.py) via synthetic events.
Theme {
    id: root
    width: 1180
    height: 1400

    // one labelled cell: caption on top, the control below
    component Cell: ColumnLayout {
        property string cap
        default property alias body: holder.data
        spacing: 3
        Label {
            text: parent.cap
            color: palette.placeholderText
            font.pixelSize: 11
            font.family: Tokens.family
        }
        RowLayout { id: holder; spacing: 0 }
    }

    // one control-type row: name on the left, state cells on the right
    component Line: RowLayout {
        property string name
        Layout.fillWidth: true
        spacing: Tokens.gap
        Label {
            text: parent.name
            color: palette.accent
            font.pixelSize: Tokens.body
            font.family: Tokens.family
            Layout.preferredWidth: 110
            Layout.alignment: Qt.AlignTop
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        ColumnLayout {
            width: root.width
            spacing: Tokens.edge

            Item { implicitHeight: 4 }
            Label {
                text: "state matrix · Fusion · one injected palette"
                color: palette.accent
                font.pixelSize: Tokens.title
                Layout.leftMargin: Tokens.edge
            }

            ColumnLayout {
                Layout.leftMargin: Tokens.edge
                Layout.rightMargin: Tokens.edge
                Layout.fillWidth: true
                spacing: Tokens.edge

                Line {
                    name: "Button"
                    Cell { cap: "default"; Button { text: "btn" } }
                    Cell { cap: "pressed"; Button { text: "btn"; down: true } }
                    Cell { cap: "hover"; Button { objectName: "hoverBtn"; text: "btn" } }
                    Cell { cap: "focus"; Button { objectName: "focusBtn"; text: "btn" } }
                    Cell { cap: "accent"; Button { text: "btn"; highlighted: true } }
                    Cell { cap: "accent·down"; Button { text: "btn"; highlighted: true; down: true } }
                    Cell { cap: "checked"; Button { text: "btn"; checkable: true; checked: true } }
                    Cell { cap: "flat"; Button { text: "btn"; flat: true } }
                    Cell { cap: "disabled"; Button { text: "btn"; enabled: false } }
                }

                Line {
                    name: "CheckBox"
                    Cell { cap: "off"; CheckBox { text: "x" } }
                    Cell { cap: "on"; CheckBox { text: "x"; checked: true } }
                    Cell { cap: "partial"; CheckBox { text: "x"; tristate: true; checkState: Qt.PartiallyChecked } }
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
                    name: "ToolButton"
                    Cell { cap: "default"; ToolButton { text: "tool" } }
                    Cell { cap: "pressed"; ToolButton { text: "tool"; down: true } }
                    Cell { cap: "checked"; ToolButton { text: "tool"; checkable: true; checked: true } }
                    Cell { cap: "disabled"; ToolButton { text: "tool"; enabled: false } }
                }

                Line {
                    name: "TextField"
                    Cell { cap: "placeholder"; TextField { placeholderText: "host…"; implicitWidth: 140 } }
                    Cell { cap: "filled"; TextField { text: "home"; implicitWidth: 140 } }
                    Cell { cap: "focus"; TextField { objectName: "focusField"; text: "home"; implicitWidth: 140 } }
                    Cell { cap: "disabled"; TextField { text: "home"; enabled: false; implicitWidth: 140 } }
                }

                Line {
                    name: "ComboBox"
                    Cell { cap: "default"; ComboBox { model: ["eco", "perf"]; implicitWidth: 130 } }
                    Cell { cap: "pressed"; ComboBox { model: ["eco", "perf"]; down: true; implicitWidth: 130 } }
                    Cell { cap: "editable"; ComboBox { model: ["eco", "perf"]; editable: true; implicitWidth: 130 } }
                    Cell { cap: "disabled"; ComboBox { model: ["eco", "perf"]; enabled: false; implicitWidth: 130 } }
                }

                Line {
                    name: "SpinBox"
                    Cell { cap: "default"; SpinBox { value: 3; implicitWidth: 130 } }
                    Cell { cap: "disabled"; SpinBox { value: 3; enabled: false; implicitWidth: 130 } }
                }

                Line {
                    name: "Slider"
                    Cell { cap: "value"; Slider { value: 0.55; implicitWidth: 160 } }
                    Cell { cap: "focus"; Slider { objectName: "focusSlider"; value: 0.55; implicitWidth: 160 } }
                    Cell { cap: "disabled"; Slider { value: 0.55; enabled: false; implicitWidth: 160 } }
                }

                Line {
                    name: "RangeSlider"
                    Cell { cap: "value"; RangeSlider { first.value: 0.25; second.value: 0.75; implicitWidth: 160 } }
                    Cell { cap: "disabled"; RangeSlider { first.value: 0.25; second.value: 0.75; enabled: false; implicitWidth: 160 } }
                }

                Line {
                    name: "ProgressBar"
                    Cell { cap: "value"; ProgressBar { value: 0.62; implicitWidth: 160 } }
                    Cell { cap: "indeterminate"; ProgressBar { indeterminate: true; implicitWidth: 160 } }
                    Cell { cap: "disabled"; ProgressBar { value: 0.62; enabled: false; implicitWidth: 160 } }
                }

                Line {
                    name: "Dial"
                    Cell { cap: "value"; Dial { value: 0.3; implicitWidth: 56; implicitHeight: 56 } }
                    Cell { cap: "disabled"; Dial { value: 0.3; enabled: false; implicitWidth: 56; implicitHeight: 56 } }
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
                    Label { text: "TabBar"; color: palette.accent; font.pixelSize: Tokens.body }
                    TabBar {
                        implicitWidth: 420
                        TabButton { text: "current" }
                        TabButton { text: "other" }
                        TabButton { text: "disabled"; enabled: false }
                    }
                }
            }
            Item { implicitHeight: Tokens.edge }
        }
    }
}
