import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme

// The newly-styled controls, so the palette strip can be verified: everything
// below is painted purely from Colors tokens, no palette in Theme.qml.
Theme {
    id: root
    width: 640
    height: 860

    component Sec: ColumnLayout {
        property string t
        default property alias d: f.data
        Layout.fillWidth: true
        spacing: Spacing.inner
        Label { text: parent.t; color: Colors.primary; font.pixelSize: Type.title; font.family: Type.family }
        Flow { id: f; Layout.fillWidth: true; spacing: Spacing.gap }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        ColumnLayout {
            width: root.width
            spacing: Spacing.edge

            Item { implicitHeight: 6 }

            ColumnLayout {
                Layout.leftMargin: Spacing.edge
                Layout.rightMargin: Spacing.edge
                Layout.fillWidth: true
                spacing: Spacing.edge

                Label { text: "newly styled · Tui · no palette"; color: Colors.primary; font.pixelSize: Type.title }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Spacing.inner
                    Label { text: "ToolBar"; color: Colors.primary }
                    ToolBar {
                        Layout.fillWidth: true
                        RowLayout {
                            anchors.fill: parent
                            ToolButton { text: "file" }
                            ToolButton { text: "edit" }
                            ToolSeparator {}
                            ToolButton { text: "view"; checkable: true; checked: true }
                            Item { Layout.fillWidth: true }
                            ToolButton { text: "⋯" }
                        }
                    }
                }

                Sec {
                    t: "Buttons"
                    RoundButton { text: "+" }
                    ToolButton { text: "tool" }
                    DelayButton { text: "hold"; delay: 800 }
                }

                Sec {
                    t: "Sliders · dial"
                    RangeSlider { implicitWidth: 180; first.value: 0.25; second.value: 0.75 }
                    Dial { value: 0.3 }
                }

                Sec {
                    t: "Activity"
                    ProgressBar { implicitWidth: 160; value: 0.6 }
                    BusyIndicator { running: true }
                    PageIndicator { count: 5; currentIndex: 2 }
                }

                GroupBox {
                    title: "GroupBox"
                    ColumnLayout {
                        CheckBox { text: "autostart"; checked: true }
                        CheckBox { text: "notify" }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Spacing.inner
                    Label { text: "MenuBar"; color: Colors.primary }
                    MenuBar {
                        Layout.fillWidth: true
                        Menu { title: "File"; MenuItem { text: "New" } MenuItem { text: "Open" } }
                        Menu { title: "Edit"; MenuItem { text: "Undo" } }
                        Menu { title: "View" }
                    }
                }
            }
            Item { implicitHeight: 320 }
        }
    }

    Dialog {
        id: dlg
        title: "confirm"
        x: 360
        y: 560
        width: 240
        modal: false
        standardButtons: Dialog.Ok | Dialog.Cancel
        Label { text: "apply changes?"; color: Colors.on_surface }
    }

    Component.onCompleted: dlg.open()
}
