pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import theme
import services

// Workspace overview (GNOME Activities): a blurred, dimmed desktop with a search
// field, a strip of all workspaces up top, the current workspace shown large in
// the centre with its neighbours peeking, and an app dash at the bottom.
Item {
    id: ov

    property bool open: false
    property Item backdrop: null

    visible: opacity > 0
    opacity: open ? 1 : 0
    focus: open

    Behavior on opacity { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }
    Keys.onEscapePressed: ov.open = false

    readonly property real aspect: ov.width / Math.max(1, ov.height)
    readonly property int currentIndex: Math.max(0, Workspaces.list.findIndex(function (w) { return w.id === Workspaces.focused_id; }))

    // ── blurred wallpaper + dim ─────────────────────────────────────────
    MultiEffect {
        anchors.fill: parent
        source: ov.backdrop
        visible: ov.backdrop !== null
        blurEnabled: true
        blur: 1.0
        blurMax: 48
    }
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.02, 0.02, 0.05, 0.42)
    }
    MouseArea { anchors.fill: parent; onClicked: ov.open = false }

    // ── search ──────────────────────────────────────────────────────────
    TextField {
        id: search
        anchors.horizontalCenter: parent.horizontalCenter
        y: Spacing.gap + 34
        width: 360
        placeholderText: "Type to search"
    }

    // ── workspace thumbnails (all, small, up top) ───────────────────────
    Row {
        id: thumbs
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: search.bottom
        anchors.topMargin: Spacing.gap
        spacing: Spacing.inner

        Repeater {
            model: Workspaces.list
            Rectangle {
                id: thumb
                required property var modelData
                required property int index
                readonly property bool cur: thumb.index === ov.currentIndex
                height: 46
                width: height * ov.aspect
                radius: Shape.radius
                color: Colors.surface_container_low
                border.width: thumb.cur ? Shape.focus : Shape.border
                border.color: thumb.cur ? Colors.primary : Colors.outline_variant
                MouseArea { anchors.fill: parent; onClicked: Workspaces.focus(thumb.modelData.id) }
            }
        }
    }

    // ── big workspace carousel (current large, neighbours peeking) ───────
    Item {
        id: stage
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: thumbs.bottom
        anchors.bottom: dash.top
        anchors.topMargin: Spacing.edge
        anchors.bottomMargin: Spacing.edge
        clip: true

        readonly property real bigW: Math.min(width * 0.66, (height * 0.96) * ov.aspect)
        readonly property real bigH: bigW / ov.aspect
        readonly property real gap: Spacing.edge

        Row {
            y: (stage.height - stage.bigH) / 2
            x: stage.width / 2 - stage.bigW / 2 - ov.currentIndex * (stage.bigW + stage.gap)
            spacing: stage.gap
            Behavior on x { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }

            Repeater {
                model: Workspaces.list
                Rectangle {
                    id: big
                    required property var modelData
                    required property int index
                    readonly property bool cur: big.index === ov.currentIndex
                    width: stage.bigW
                    height: stage.bigH
                    radius: Shape.radius
                    color: Colors.surface_container_low
                    opacity: big.cur ? 1 : 0.55
                    border.width: big.cur ? Shape.focus : Shape.border
                    border.color: big.cur ? Colors.primary : Colors.outline_variant

                    Flow {
                        anchors.fill: parent
                        anchors.margins: Spacing.gap
                        spacing: Spacing.inner

                        Repeater {
                            model: big.modelData.windows
                            Rectangle {
                                id: win
                                required property var modelData
                                width: (big.width - Spacing.gap * 2 - Spacing.inner) / 2
                                height: big.height * 0.4
                                radius: Shape.radius
                                color: Colors.surface_container_high
                                border.width: Shape.border
                                border.color: Colors.outline_variant
                                Text {
                                    anchors.fill: parent
                                    anchors.margins: Spacing.inner
                                    text: win.modelData.title
                                    color: Colors.on_surface
                                    font.family: Type.family
                                    font.pixelSize: Type.body
                                    wrapMode: Text.Wrap
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        visible: big.modelData.windows.length === 0
                        text: "empty"
                        color: Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.body
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (big.cur)
                                ov.open = false
                            else
                                Workspaces.focus(big.modelData.id)
                        }
                    }
                }
            }
        }
    }

    // ── dash (favourite apps, bottom) ───────────────────────────────────
    Rectangle {
        id: dash
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Spacing.edge
        radius: Shape.radius
        color: Colors.surface_container_high
        border.width: Shape.border
        border.color: Colors.outline_variant
        width: dashRow.width + Spacing.gap * 2
        height: dashRow.height + Spacing.inner * 2

        Row {
            id: dashRow
            anchors.centerIn: parent
            spacing: Spacing.inner

            Repeater {
                model: ["Firefox", "Files", "kitty", "nvim", "Spotify"]
                Rectangle {
                    id: app
                    required property var modelData
                    width: 40
                    height: 40
                    radius: Shape.radius
                    color: Colors.surface_container_highest
                    border.width: Shape.border
                    border.color: Colors.outline_variant
                    Text {
                        anchors.centerIn: parent
                        text: app.modelData.charAt(0)
                        color: Colors.on_surface
                        font.family: Type.family
                        font.pixelSize: Type.title
                    }
                }
            }

            Rectangle {
                width: 40
                height: 40
                radius: Shape.radius
                color: Colors.surface_container_highest
                border.width: Shape.border
                border.color: Colors.outline_variant
                Grid {
                    anchors.centerIn: parent
                    columns: 3
                    rowSpacing: 3
                    columnSpacing: 3
                    Repeater {
                        model: 9
                        Rectangle { width: 3; height: 3; radius: 1; color: Colors.on_surface_variant }
                    }
                }
            }
        }
    }
}
