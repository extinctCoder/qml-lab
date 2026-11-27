import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// The full default Qt Quick Controls catalogue, themed by ONE injected palette.
// Root is Theme — Qt propagates its palette to every control below. There is no
// per-control palette anywhere in this file.
Theme {
    id: gallery
    width: 1020
    height: 760

    // ── one reusable section frame ──────────────────────────────────────────
    component Section: ColumnLayout {
        default property alias content: box.data
        property string title
        Layout.fillWidth: true
        spacing: Tokens.inner
        Label {
            text: parent.title
            color: palette.accent
            font.pixelSize: Tokens.title
            font.family: Tokens.family
        }
        Flow {
            id: box
            Layout.fillWidth: true
            spacing: Tokens.gap
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: gallery.width
            spacing: Tokens.edge * 1.5

            // leave room so the scrollbar never sits on content
            Item { implicitHeight: Tokens.inner; Layout.fillWidth: true }

            Label {
                text: "qml-lab · full catalogue · one injected palette"
                color: palette.accent
                font.pixelSize: Tokens.display * 0.5
                font.family: Tokens.family
                Layout.leftMargin: Tokens.edge
            }

            ColumnLayout {
                Layout.leftMargin: Tokens.edge
                Layout.rightMargin: Tokens.edge
                Layout.fillWidth: true
                spacing: Tokens.edge * 1.2

                // ── buttons ──────────────────────────────────────────────
                Section {
                    title: "Buttons"
                    Button { text: "button" }
                    Button { text: "accent"; highlighted: true }
                    Button { text: "flat"; flat: true }
                    Button { text: "checked"; checkable: true; checked: true }
                    RoundButton { text: "+" }
                    ToolButton { text: "tool" }
                    DelayButton { text: "hold"; delay: 800 }
                    Button { text: "off"; enabled: false }
                }

                // ── toggles ──────────────────────────────────────────────
                Section {
                    title: "Toggles"
                    CheckBox { text: "wi-fi"; checked: true }
                    CheckBox { text: "mixed"; tristate: true; checkState: Qt.PartiallyChecked }
                    CheckBox { text: "bluetooth" }
                    RadioButton { text: "eco"; checked: true }
                    RadioButton { text: "balanced" }
                    Switch { text: "on"; checked: true }
                    Switch { text: "off" }
                }

                // ── selection & numeric ──────────────────────────────────
                Section {
                    title: "Selection · numeric"
                    ComboBox { model: ["eco", "balanced", "performance"] }
                    ComboBox { editable: true; model: ["eth0", "wlan0", "lo"] }
                    SpinBox { value: 3; from: 0; to: 10 }
                }

                // ── sliders & dial ───────────────────────────────────────
                Section {
                    title: "Sliders · dial"
                    Slider { implicitWidth: 240; value: 0.55 }
                    RangeSlider { implicitWidth: 240; first.value: 0.25; second.value: 0.75 }
                    Dial { implicitWidth: 72; implicitHeight: 72; value: 0.3 }
                }

                // ── progress & activity ──────────────────────────────────
                Section {
                    title: "Progress · activity"
                    ProgressBar { implicitWidth: 200; value: 0.62 }
                    ProgressBar { implicitWidth: 200; indeterminate: true }
                    BusyIndicator { running: true }
                    PageIndicator { count: 5; currentIndex: 2 }
                }

                // ── text input ───────────────────────────────────────────
                Section {
                    title: "Text input"
                    TextField { placeholderText: "hostname…"; text: "home" }
                    TextField { placeholderText: "password"; echoMode: TextInput.Password; text: "secret" }
                    Frame {
                        implicitWidth: 240
                        TextArea {
                            anchors.fill: parent
                            placeholderText: "multi-line…"
                            text: "journalctl -f\n systemctl status"
                        }
                    }
                }

                // ── containers ───────────────────────────────────────────
                Section {
                    title: "Containers"
                    Frame {
                        ColumnLayout {
                            Label { text: "Frame"; color: palette.text }
                            Label { text: "bordered box"; color: palette.placeholderText }
                        }
                    }
                    GroupBox {
                        title: "GroupBox"
                        ColumnLayout {
                            CheckBox { text: "autostart"; checked: true }
                            CheckBox { text: "notify" }
                        }
                    }
                    Pane {
                        ColumnLayout {
                            Label { text: "Pane"; color: palette.text }
                            Label { text: "flat surface"; color: palette.placeholderText }
                        }
                    }
                }

                // ── tabs & paged views ───────────────────────────────────
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.inner
                    Label {
                        text: "Tabs · paged views"
                        color: palette.accent
                        font.pixelSize: Tokens.title
                    }
                    TabBar {
                        Layout.fillWidth: true
                        TabButton { text: "overview" }
                        TabButton { text: "media" }
                        TabButton { text: "system" }
                    }
                    SwipeView {
                        id: swipe
                        Layout.fillWidth: true
                        implicitHeight: 54
                        clip: true
                        Pane { Label { text: "page one · swipe →"; color: palette.text } }
                        Pane { Label { text: "page two"; color: palette.text } }
                        Pane { Label { text: "page three"; color: palette.text } }
                    }
                    PageIndicator { count: swipe.count; currentIndex: swipe.currentIndex; Layout.alignment: Qt.AlignHCenter }
                }

                // ── toolbar ──────────────────────────────────────────────
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.inner
                    Label { text: "ToolBar"; color: palette.accent; font.pixelSize: Tokens.title }
                    ToolBar {
                        Layout.fillWidth: true
                        RowLayout {
                            anchors.fill: parent
                            ToolButton { text: "file" }
                            ToolButton { text: "edit" }
                            ToolSeparator {}
                            ToolButton { text: "view" }
                            Item { Layout.fillWidth: true }
                            ToolButton { text: "⋯" }
                        }
                    }
                }

                // ── list delegates ───────────────────────────────────────
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.inner
                    Label { text: "List delegates"; color: palette.accent; font.pixelSize: Tokens.title }
                    Frame {
                        Layout.fillWidth: true
                        padding: 0
                        ColumnLayout {
                            width: parent ? parent.width : 0
                            spacing: 0
                            ItemDelegate { text: "ItemDelegate · selected"; highlighted: true; Layout.fillWidth: true }
                            CheckDelegate { text: "CheckDelegate"; checked: true; Layout.fillWidth: true }
                            RadioDelegate { text: "RadioDelegate"; checked: true; Layout.fillWidth: true }
                            SwitchDelegate { text: "SwitchDelegate"; checked: true; Layout.fillWidth: true }
                        }
                    }
                }

                // ── popups (wired to triggers) ───────────────────────────
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
                        text: "dialog"
                        onClicked: dlg.open()
                    }
                    Button {
                        text: "tooltip"
                        ToolTip.visible: hovered
                        ToolTip.text: "hover tooltip"
                    }
                }
            }

            Item { implicitHeight: Tokens.edge; Layout.fillWidth: true }
        }
    }

    Dialog {
        id: dlg
        title: "confirm"
        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        Label { text: "apply changes?"; color: palette.text }
    }
}
