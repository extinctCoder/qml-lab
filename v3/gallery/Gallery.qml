import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// The Tui style showcase. Plain Qt Controls — the Tui style gives them the look,
// the M3 Colors tokens give them the colour. One accent (green) on every active
// mark. Controls not yet in the Tui set fall back to Basic, themed by the slim
// palette in Theme.qml.
Theme {
    id: gallery
    width: 560
    height: 720

    component Section: ColumnLayout {
        default property alias content: box.data
        property string title
        Layout.fillWidth: true
        spacing: Spacing.inner
        Label {
            text: parent.title
            color: Colors.primary
            font.pixelSize: Type.title
            font.family: Type.family
        }
        Flow {
            id: box
            Layout.fillWidth: true
            spacing: Spacing.gap
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: gallery.width
            spacing: Spacing.edge

            Item { implicitHeight: Spacing.tight; Layout.fillWidth: true }

            Label {
                text: "qml-lab · Tui style · M3 tokens"
                color: Colors.primary
                font.pixelSize: Type.display * 0.5
                font.family: Type.family
                Layout.leftMargin: Spacing.edge
            }

            ColumnLayout {
                Layout.leftMargin: Spacing.edge
                Layout.rightMargin: Spacing.edge
                Layout.fillWidth: true
                spacing: Spacing.edge

                Section {
                    title: "Buttons"
                    Button { text: "outline" }
                    Button { text: "primary"; variant: "primary" }
                    Button { text: "tonal"; variant: "tonal" }
                    Button { text: "ghost"; variant: "ghost" }
                    Button { text: "danger"; variant: "danger" }
                    Button { text: "checked"; checkable: true; checked: true }
                    Button { text: "off"; variant: "primary"; enabled: false }
                }

                Section {
                    title: "Toggles"
                    CheckBox { text: "wi-fi"; checked: true }
                    CheckBox { text: "bluetooth" }
                    RadioButton { text: "eco"; checked: true }
                    RadioButton { text: "balanced" }
                    Switch { text: "on"; checked: true }
                    Switch { text: "off" }
                }

                Section {
                    title: "Selection · numeric"
                    ComboBox { model: ["eco", "balanced", "performance"] }
                    SpinBox { value: 3; from: 0; to: 10 }
                }

                Section {
                    title: "Sliders · progress"
                    Slider { implicitWidth: 200; value: 0.55 }
                    ProgressBar { implicitWidth: 200; value: 0.62 }
                    ProgressBar { implicitWidth: 200; indeterminate: true }
                }

                Section {
                    title: "Text"
                    TextField { placeholderText: "hostname…"; text: "home" }
                    TextField { placeholderText: "password"; echoMode: TextInput.Password; text: "secret" }
                }

                Section {
                    title: "Containers"
                    Frame {
                        ColumnLayout {
                            Label { text: "Frame"; color: Colors.on_surface }
                            Label { text: "bordered"; color: Colors.on_surface_variant }
                        }
                    }
                    Pane {
                        ColumnLayout {
                            Label { text: "Pane"; color: Colors.on_surface }
                            Label { text: "surface"; color: Colors.on_surface_variant }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Spacing.inner
                    Label { text: "Tabs"; color: Colors.primary; font.pixelSize: Type.title }
                    TabBar {
                        Layout.fillWidth: true
                        TabButton { text: "overview" }
                        TabButton { text: "media" }
                        TabButton { text: "system" }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Spacing.inner
                    Label { text: "List"; color: Colors.primary; font.pixelSize: Type.title }
                    Frame {
                        Layout.fillWidth: true
                        padding: 0
                        ColumnLayout {
                            width: parent ? parent.width : 0
                            spacing: 0
                            ItemDelegate { text: "selected row"; highlighted: true; Layout.fillWidth: true }
                            ItemDelegate { text: "a plain row"; Layout.fillWidth: true }
                            CheckDelegate { text: "a check row"; checked: true; Layout.fillWidth: true }
                            RadioDelegate { text: "a radio row"; checked: true; Layout.fillWidth: true }
                        }
                    }
                }

                Section {
                    title: "Popups (click / hover)"
                    Button {
                        text: "menu ▾"
                        onClicked: ctxMenu.open()
                        Menu {
                            id: ctxMenu
                            MenuItem { text: "open" }
                            MenuItem { text: "rename" }
                            MenuSeparator {}
                            MenuItem { text: "delete" }
                        }
                    }
                    Button {
                        text: "tooltip"
                        ToolTip.visible: hovered
                        ToolTip.text: "hover tooltip"
                    }
                }

                Item { implicitHeight: Spacing.edge; Layout.fillWidth: true }
            }
        }
    }
}
