pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import theme
import services

// The launcher — a telescope/fzf fuzzy finder. Type to filter apps (matched
// letters highlighted), ↑↓ to move, ↵ to launch, Esc to close. The left list and
// right preview are a reusable pattern (→ lib Picker.Palette later).
Item {
    id: spot

    property bool open: false
    property Item backdrop: null

    readonly property string hl: "#a6e3a1"
    property var results: []
    property int sel: 0

    visible: opacity > 0
    opacity: open ? 1 : 0

    Behavior on opacity { NumberAnimation { duration: Motion.open; easing.type: Motion.ease_out } }

    onOpenChanged: {
        if (open) {
            input.text = ""
            spot.refresh()
            input.forceActiveFocus()
        }
    }

    Component.onCompleted: spot.refresh()

    // ── fuzzy match ─────────────────────────────────────────────────────
    function fuzzy(query, text) {
        if (query === "")
            return { "score": 0, "positions": [] }
        const q = query.toLowerCase()
        const t = text.toLowerCase()
        let qi = 0
        let score = 0
        let last = -2
        const positions = []
        for (let ti = 0; ti < t.length && qi < q.length; ti++) {
            if (t[ti] === q[qi]) {
                positions.push(ti)
                if (ti === last + 1) score += 5
                if (ti === 0) score += 10
                score += 1
                last = ti
                qi++
            }
        }
        if (qi < q.length)
            return null
        return { "score": score, "positions": positions }
    }

    function markup(name, positions) {
        const pset = {}
        for (let i = 0; i < positions.length; i++)
            pset[positions[i]] = true
        let out = ""
        for (let i = 0; i < name.length; i++) {
            if (pset[i])
                out += '<font color="' + spot.hl + '">' + name[i] + '</font>'
            else
                out += name[i]
        }
        return out
    }

    function refresh() {
        const q = input.text
        const r = []
        for (let i = 0; i < Apps.entries.length; i++) {
            const e = Apps.entries[i]
            const m = spot.fuzzy(q, e.name)
            if (m)
                r.push({ "e": e, "score": m.score, "html": spot.markup(e.name, m.positions) })
        }
        r.sort(function (a, b) { return b.score - a.score })
        spot.results = r
        spot.sel = 0
    }

    function launch() {
        if (spot.results.length > 0) {
            Apps.launch(spot.results[spot.sel].e.id)
            spot.open = false
        }
    }

    // ── dim + blur backdrop ─────────────────────────────────────────────
    MultiEffect {
        anchors.fill: parent
        source: spot.backdrop
        visible: spot.backdrop !== null
        blurEnabled: true
        blur: 0.8
        blurMax: 40
    }
    Rectangle { anchors.fill: parent; color: Qt.rgba(0.01, 0.01, 0.03, 0.5) }
    MouseArea { anchors.fill: parent; onClicked: spot.open = false }

    // ── the palette ─────────────────────────────────────────────────────
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.16
        width: Math.min(680, parent.width - Spacing.edge * 4)
        height: 420
        radius: Shape.radius
        color: Colors.surface_container_high
        border.width: Shape.border
        border.color: Colors.outline_variant

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Spacing.gap
            spacing: Spacing.inner

            // prompt
            RowLayout {
                Layout.fillWidth: true
                spacing: Spacing.inner

                Label { text: "❯"; color: Colors.primary; font.family: Type.family; font.pixelSize: Type.title }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: input.implicitHeight

                    TextInput {
                        id: input
                        anchors.fill: parent
                        verticalAlignment: TextInput.AlignVCenter
                        color: Colors.on_surface
                        font.family: Type.family
                        font.pixelSize: Type.title
                        clip: true
                        onTextChanged: spot.refresh()
                        onAccepted: spot.launch()
                        Keys.onEscapePressed: spot.open = false
                        Keys.onDownPressed: function (e) { spot.sel = Math.min(spot.sel + 1, spot.results.length - 1); e.accepted = true }
                        Keys.onUpPressed: function (e) { spot.sel = Math.max(spot.sel - 1, 0); e.accepted = true }
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "search apps…"
                        visible: input.text === ""
                        color: Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.title
                    }
                }

                Label {
                    text: spot.results.length + " / " + Apps.entries.length
                    color: Colors.on_surface_variant
                    font.family: Type.family
                    font.pixelSize: Type.label
                }
            }

            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: Shape.border; color: Colors.outline_variant }

            // results | preview
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: Spacing.gap

                ListView {
                    id: list
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 3
                    Layout.fillWidth: true
                    clip: true
                    model: spot.results
                    currentIndex: spot.sel
                    boundsBehavior: Flickable.StopAtBounds

                    delegate: Rectangle {
                        id: row
                        required property var modelData
                        required property int index
                        readonly property bool cur: row.index === spot.sel
                        width: ListView.view.width
                        height: 40
                        color: row.cur ? Colors.secondary_container : "transparent"
                        radius: Shape.radius

                        Rectangle {
                            width: 2
                            height: parent.height
                            color: row.cur ? Colors.primary : "transparent"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: Spacing.inner
                            anchors.rightMargin: Spacing.inner
                            spacing: Spacing.inner

                            Rectangle {
                                implicitWidth: 26
                                implicitHeight: 26
                                radius: Shape.radius
                                color: Colors.surface_container_highest
                                Text {
                                    anchors.centerIn: parent
                                    text: row.modelData.e.icon
                                    color: Colors.on_surface
                                    font.family: Type.family
                                    font.pixelSize: Type.label
                                }
                            }
                            Text {
                                text: row.modelData.html
                                textFormat: Text.StyledText
                                color: row.cur ? Colors.on_secondary_container : Colors.on_surface
                                font.family: Type.family
                                font.pixelSize: Type.body
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                            Text {
                                text: row.modelData.e.category
                                color: Colors.on_surface_variant
                                font.family: Type.family
                                font.pixelSize: Type.label
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: spot.sel = row.index
                            onDoubleClicked: spot.launch()
                        }
                    }
                }

                Rectangle { Layout.preferredWidth: Shape.border; Layout.fillHeight: true; color: Colors.outline_variant }

                // preview
                Item {
                    id: preview
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 2
                    Layout.fillWidth: true

                    readonly property var cur: spot.results.length > 0 ? spot.results[spot.sel].e : null

                    ColumnLayout {
                        anchors.centerIn: parent
                        visible: preview.cur !== null
                        spacing: Spacing.inner

                        Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            implicitWidth: 56
                            implicitHeight: 56
                            radius: Shape.radius
                            color: Colors.surface_container_highest
                            border.width: Shape.border
                            border.color: Colors.outline_variant
                            Text {
                                anchors.centerIn: parent
                                text: preview.cur ? preview.cur.icon : ""
                                color: Colors.primary
                                font.family: Type.family
                                font.pixelSize: Type.display * 0.6
                            }
                        }
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: preview.cur ? preview.cur.name : ""
                            color: Colors.on_surface
                            font.family: Type.family
                            font.pixelSize: Type.title
                        }
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: preview.cur ? preview.cur.description : ""
                            color: Colors.on_surface_variant
                            font.family: Type.family
                            font.pixelSize: Type.label
                        }
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: Spacing.inner
                            text: "↵  launch"
                            color: Colors.primary
                            font.family: Type.family
                            font.pixelSize: Type.label
                        }
                    }

                    Label {
                        anchors.centerIn: parent
                        visible: spot.results.length === 0
                        text: "no matches"
                        color: Colors.on_surface_variant
                        font.family: Type.family
                        font.pixelSize: Type.body
                    }
                }
            }
        }
    }
}
