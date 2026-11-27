pragma ComponentBehavior: Bound

import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.mark as Mark
import components.ui.button as Button
import components.ui.section as Section
import components.ui.feedback as Feedback
import components.ui.range as Range
import components.ui.tabs as Tabs
import components.ui.field as Field
import components.ui.picker as Picker
import components.ui.badge as Badge
import components.ui.chart as Chart
import components.behaviors

Rectangle {
    id: gallery
    width: 680
    height: 800
    color: Colors.surface

    property string power: "eco"
    property bool silent: false
    property string output: "headphones"
    property bool wifi: true
    property bool bluetooth: false
    property bool night_light: true
    property bool stay_awake: false
    property real volume: 51
    property real brightness: 70
    property real firefox: 40
    property real spotify: 72
    property real discord: 20
    property real position: 84
    property int tab: 0
    property string network: "home"
    property string query: "ze"
    property string password: "correct horse"
    property string launched: ""
    property string layout: ""
    property string action: ""
    property var cpu: [30, 34, 31, 40, 38, 45, 42, 37, 35, 41, 47, 44, 39, 36, 33, 38, 42, 46, 43, 37]
    property var memory: [61, 61, 62, 62, 63, 62, 62, 63, 64, 63, 63, 62, 62, 63, 63, 64, 64, 63, 62, 62]
    property var cores: [37, 62, 18, 80, 44, 25, 55, 30]
    property var history: Array.from({ length: 60 }, (_, i) => 30 + Math.round(Math.sin(i / 6) * 15))
    property var download: Array.from({ length: 40 }, (_, i) => 50 + Math.round(Math.sin(i / 5) * 20))
    property var upload: Array.from({ length: 40 }, (_, i) => 10 + Math.round(Math.cos(i / 4) * 4))
    property int notifications: 3

    function walk(list, step, low, high) {
        const last = list[list.length - 1];
        const next = Math.max(low, Math.min(high, Math.round(last + (Math.random() * 2 - 1) * step)));
        return list.slice(1).concat([next]);
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            gallery.cpu = gallery.walk(gallery.cpu, 9, 3, 97);
            gallery.memory = gallery.walk(gallery.memory, 1, 40, 90);
            gallery.cores = gallery.cores.map(v => Math.max(2, Math.min(100, Math.round(v + (Math.random() * 2 - 1) * 14))));
            gallery.history = gallery.walk(gallery.history, 10, 3, 97);
            gallery.download = gallery.walk(gallery.download, 12, 5, 95);
            gallery.upload = gallery.walk(gallery.upload, 3, 2, 30);
        }
    }
    readonly property var apps: [
        { icon: "▣", title: "zen browser", description: "web browser" },
        { icon: "▣", title: "zed", description: "editor" },
        { icon: "▣", title: "ghostty", description: "terminal" },
        { icon: "▣", title: "spotify", description: "music" },
        { icon: "▣", title: "thunar", description: "files" },
        { icon: "▣", title: "gnome-system-monitor", description: "system" },
        { icon: "▣", title: "obs studio", description: "recording" },
        { icon: "▣", title: "steam", description: "games" },
        { icon: "▣", title: "settings", description: "system" },
        { icon: "▣", title: "VisualStudioCode", description: "editor" },
        { icon: "▣", title: "libreoffice-calc", description: "spreadsheets" }
    ]

    Flickable {
        id: scroller
        anchors.fill: parent
        contentWidth: width
        contentHeight: sections.implicitHeight + Spacing.edge * 2
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Column {
            id: sections
            x: Spacing.edge
            y: Spacing.edge
            width: scroller.width - Spacing.edge * 2
            spacing: Spacing.gap

            Text.Mono {
                text: "1 · Surface"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "appearance: outlined · filled · ghost"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.gap
                Surface {
                    Text.Mono {
                        text: "outlined"
                    }
                }
                Surface {
                    appearance: "filled"
                    Text.Mono {
                        text: "filled"
                    }
                }
                Surface {
                    appearance: "ghost"
                    Text.Mono {
                        text: "ghost"
                    }
                }
            }

            Text.Mono {
                text: "level: 1 (deepest) to 5 (front) · 3 is the default"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner
                Surface {
                    level: 1
                    Text.Mono {
                        text: "1"
                    }
                }
                Surface {
                    level: 2
                    Text.Mono {
                        text: "2"
                    }
                }
                Surface {
                    Text.Mono {
                        text: "3 default"
                    }
                }
                Surface {
                    level: 4
                    Text.Mono {
                        text: "4"
                    }
                }
                Surface {
                    level: 5
                    Text.Mono {
                        text: "5"
                    }
                }
            }

            Text.Mono {
                text: "holds anything: here a Column with a header and a line"
                size: "label"
                muted: true
            }
            Surface {
                Column {
                    spacing: Spacing.tight
                    Text.Header {
                        icon: "≋"
                        title: "wi-fi"
                        description: "home network"
                    }
                    Text.Mono {
                        text: "connected · 92%"
                    }
                }
            }

            Text.Mono {
                text: "2 · Text"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Mono · sizes: display · title · body · label · and muted"
                size: "label"
                muted: true
            }
            Column {
                spacing: Spacing.tight
                Text.Mono {
                    text: "09:27"
                    size: "display"
                    tone: Colors.primary
                }
                Text.Mono {
                    text: "title · quick settings"
                    size: "title"
                }
                Text.Mono {
                    text: "body · wi-fi · home · 92%"
                }
                Text.Mono {
                    text: "body, muted · connected since 08:14"
                    muted: true
                }
            }

            Text.Mono {
                text: "Mono · surface: true · long text wraps when it has a width"
                size: "label"
                muted: true
            }
            Text.Mono {
                text: "a short boxed text"
                surface: true
            }
            Text.Mono {
                width: 320
                surface: true
                text: "Night light lowers blue light after sunset. It follows your location's sunset time and fades in over 30 minutes."
            }

            Text.Mono {
                text: "Header · the icon spans the title and description · title only"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Text.Header {
                    icon: "≋"
                    title: "wi-fi"
                    description: "home network · 92%"
                }
                Text.Header {
                    icon: "≋"
                    title: "wi-fi"
                }
            }

            Text.Mono {
                text: "Header · bigger sizes: the icon grows with the text"
                size: "label"
                muted: true
            }
            Text.Header {
                icon: "♪"
                title: "Back in Black"
                description: "AC/DC · 1980"
                title_size: "display"
                description_size: "body"
            }

            Text.Mono {
                text: "Header · surface · icon_outline · both: any header becomes a card"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.gap
                Text.Header {
                    icon: "≋"
                    title: "wi-fi"
                    description: "home network · 92%"
                    surface: true
                }
                Text.Header {
                    icon: "≋"
                    title: "wi-fi"
                    description: "home network · 92%"
                    icon_outline: true
                }
                Text.Header {
                    icon: "≋"
                    title: "wi-fi"
                    description: "home network · 92%"
                    surface: true
                    icon_outline: true
                }
            }

            Text.Mono {
                text: "3 · Mark"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Switch · Choice radio · Choice check · Chevron · Spinner · Eye · click to flip them"
                size: "label"
                muted: true
            }
            Row {
                id: marks
                spacing: Spacing.edge
                property bool flipped: false

                Mark.Switch {
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Mark.Choice {
                    kind: "radio"
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Mark.Choice {
                    kind: "check"
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Mark.Chevron {
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Mark.Spinner {
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Mark.Eye {
                    on: marks.flipped
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text.Mono {
                    text: marks.flipped ? "on / open" : "off / closed"
                    size: "label"
                    muted: true
                    anchors.verticalCenter: parent.verticalCenter
                }

                TapHandler {
                    onTapped: marks.flipped = !marks.flipped
                }
            }

            Text.Mono {
                text: "4 · Button"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Basic · five variants · disabled · click: see the terminal · Tab moves focus"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner
                Button.Basic {
                    text: "save"
                    onClicked: console.log("save")
                }
                Button.Basic {
                    text: "next"
                    variant: "tonal"
                    onClicked: console.log("next")
                }
                Button.Basic {
                    text: "back"
                    variant: "outline"
                    onClicked: console.log("back")
                }
                Button.Basic {
                    text: "cancel"
                    variant: "ghost"
                    onClicked: console.log("cancel")
                }
                Button.Basic {
                    text: "delete"
                    variant: "danger"
                    onClicked: console.log("delete")
                }
                Button.Basic {
                    text: "off"
                    enabled: false
                }
            }

            Text.Mono {
                text: "Basic · stretched: the width comes from the layout"
                size: "label"
                muted: true
            }
            Button.Basic {
                width: 420
                text: "connect"
                onClicked: console.log("connect")
            }

            Text.Mono {
                text: "Basic · checkable: one of several (← → once inside), and an on/off (Space or click)"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Row {
                    spacing: Spacing.tight
                    Roving {
                        id: power_group
                    }
                    Button.Basic {
                        variant: "outline"
                        checkable: true
                        roving: power_group
                        text: "eco"
                        checked: gallery.power === "eco"
                        onClicked: gallery.power = "eco"
                    }
                    Button.Basic {
                        variant: "outline"
                        checkable: true
                        roving: power_group
                        text: "balanced"
                        checked: gallery.power === "balanced"
                        onClicked: gallery.power = "balanced"
                    }
                    Button.Basic {
                        variant: "outline"
                        checkable: true
                        roving: power_group
                        text: "performance"
                        checked: gallery.power === "performance"
                        onClicked: gallery.power = "performance"
                    }
                }
                Button.Basic {
                    variant: "outline"
                    checkable: true
                    text: gallery.silent ? "silent: on" : "silent: off"
                    checked: gallery.silent
                    onClicked: gallery.silent = !gallery.silent
                }
            }

            Text.Mono {
                text: "ListItem · radio (↑ ↓ select) · check (↑ ↓ move, Space toggles) · actions with meta and a second line"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner
                Surface {
                    width: 200
                    Column {
                        width: parent.width
                        Roving {
                            id: output_group
                            orientation: "column"
                        }
                        Button.ListItem {
                            title: "speakers"
                            checkable: true
                            roving: output_group
                            checked: gallery.output === "speakers"
                            onClicked: gallery.output = "speakers"
                        }
                        Button.ListItem {
                            title: "headphones"
                            checkable: true
                            roving: output_group
                            checked: gallery.output === "headphones"
                            onClicked: gallery.output = "headphones"
                        }
                        Button.ListItem {
                            title: "hdmi"
                            checkable: true
                            roving: output_group
                            enabled: false
                        }
                    }
                }
                Surface {
                    width: 200
                    Column {
                        width: parent.width
                        Roving {
                            id: switches_group
                            orientation: "column"
                            selects: false
                        }
                        Button.ListItem {
                            title: "wi-fi"
                            mark: "check"
                            roving: switches_group
                            checkable: true
                            checked: gallery.wifi
                            onClicked: gallery.wifi = !gallery.wifi
                        }
                        Button.ListItem {
                            title: "bluetooth"
                            mark: "check"
                            roving: switches_group
                            checkable: true
                            checked: gallery.bluetooth
                            onClicked: gallery.bluetooth = !gallery.bluetooth
                        }
                        Button.ListItem {
                            title: "airplane"
                            mark: "check"
                            roving: switches_group
                            checkable: true
                            enabled: false
                        }
                    }
                }
                Surface {
                    width: 216
                    Column {
                        width: parent.width
                        Button.ListItem {
                            icon: "≋"
                            title: "home"
                            meta: "92%"
                            onClicked: console.log("open: home")
                        }
                        Button.ListItem {
                            icon: "▣"
                            title: "zen"
                            description: "web browser"
                            meta: "↵"
                            onClicked: console.log("launch: zen")
                        }
                    }
                }
            }

            Text.Mono {
                text: "Tile · on/off with a switch (Space or click) · an action (→) · disabled"
                size: "label"
                muted: true
            }
            Grid {
                columns: 3
                spacing: Spacing.inner
                Button.Tile {
                    width: 200
                    icon: "☾"
                    title: "night light"
                    description: gallery.night_light ? "on" : "off"
                    checkable: true
                    checked: gallery.night_light
                    onClicked: gallery.night_light = !gallery.night_light
                }
                Button.Tile {
                    width: 200
                    icon: "☕"
                    title: "stay awake"
                    description: gallery.stay_awake ? "on" : "off"
                    checkable: true
                    checked: gallery.stay_awake
                    onClicked: gallery.stay_awake = !gallery.stay_awake
                }
                Button.Tile {
                    width: 200
                    icon: "⌁"
                    title: "bluetooth"
                    description: "no adapter"
                    checkable: true
                    enabled: false
                }
                Button.Tile {
                    width: 200
                    icon: "▦"
                    title: "dashboard"
                    description: "super + i"
                    meta: "→"
                    onClicked: console.log("dashboard")
                }
            }

            Text.Mono {
                text: "5 · Section"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Basic · the header opens it (click, Enter, Space) · checkable adds a switch that toggles on its own"
                size: "label"
                muted: true
            }
            Section.Basic {
                width: 420
                icon: "♪"
                title: "audio"
                description: gallery.output + " · " + Math.round(gallery.volume) + "%"
                Surface {
                    width: parent.width
                    appearance: "ghost"
                    padding_x: Spacing.inner
                    padding_y: Spacing.tight
                    Column {
                        width: parent.width
                        Range.Slider {
                            width: parent.width
                            title: "output"
                            title_width: 64
                            value: gallery.volume
                            label: Math.round(gallery.volume) + "%"
                            onMoved: value => gallery.volume = value
                        }
                        Range.Slider {
                            width: parent.width
                            title: "firefox"
                            title_width: 64
                            value: gallery.firefox
                            label: Math.round(gallery.firefox) + "%"
                            onMoved: value => gallery.firefox = value
                        }
                        Range.Slider {
                            width: parent.width
                            title: "spotify"
                            title_width: 64
                            value: gallery.spotify
                            label: Math.round(gallery.spotify) + "%"
                            onMoved: value => gallery.spotify = value
                        }
                        Range.Slider {
                            width: parent.width
                            title: "discord"
                            title_width: 64
                            value: gallery.discord
                            label: Math.round(gallery.discord) + "%"
                            onMoved: value => gallery.discord = value
                        }
                    }
                }
                Rectangle {
                    width: parent.width
                    height: Shape.border
                    color: Colors.outline_variant
                }
                Roving {
                    id: audio_group
                    orientation: "column"
                }
                Button.ListItem {
                    title: "speakers"
                    meta: "built-in"
                    roving: audio_group
                    checkable: true
                    checked: gallery.output === "speakers"
                    onClicked: gallery.output = "speakers"
                }
                Button.ListItem {
                    title: "headphones"
                    meta: "bluetooth"
                    roving: audio_group
                    checkable: true
                    checked: gallery.output === "headphones"
                    onClicked: gallery.output = "headphones"
                }
            }
            Section.Basic {
                width: 420
                open: true
                icon: "≋"
                title: "wi-fi"
                description: gallery.wifi ? "home · 92%" : "off"
                meta: gallery.wifi ? "3 networks" : ""
                checkable: true
                checked: gallery.wifi
                onSwitched: gallery.wifi = !gallery.wifi
                Button.ListItem {
                    icon: "≋"
                    title: "home"
                    meta: "92% · connected"
                    enabled: gallery.wifi
                    onClicked: console.log("open: home")
                }
                Button.ListItem {
                    icon: "≋"
                    title: "office-5g"
                    meta: "64%"
                    enabled: gallery.wifi
                    onClicked: console.log("open: office-5g")
                }
            }
            Section.Basic {
                width: 420
                icon: "⌁"
                title: "bluetooth"
                description: gallery.bluetooth ? "on · no devices" : "off"
                checkable: true
                checked: gallery.bluetooth
                onSwitched: gallery.bluetooth = !gallery.bluetooth
                Feedback.Empty {
                    icon: "⌁"
                    title: "no paired devices"
                    description: "put your device in pairing mode, then pair it here"
                    action: "pair a device"
                    link: "open bluetui"
                    onActed: console.log("pair a device")
                    onLinked: console.log("open bluetui")
                }
            }

            Text.Mono {
                text: "6 · Feedback"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "standard · Empty (action + link) · Loading (cancellable) · Error (details, retry)"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner

                Surface {
                    width: 200
                    padding_x: 0
                    padding_y: 0
                    Feedback.Empty {
                        icon: "✉"
                        title: "all caught up"
                        description: "no new notifications"
                    }
                }
                Surface {
                    width: 200
                    padding_x: 0
                    padding_y: 0
                    Feedback.Loading {
                        title: "searching…"
                        description: "this can take a few seconds"
                        cancellable: true
                        onCancelled: console.log("cancelled")
                    }
                }
                Surface {
                    width: 232
                    padding_x: 0
                    padding_y: 0
                    Feedback.Error {
                        icon: "≋"
                        title: "couldn't connect"
                        description: "office-5g refused the password"
                        details: "nmcli: secrets were required, but not provided"
                        onRetried: console.log("retried")
                    }
                }
            }

            Text.Mono {
                text: "compact · one line · the actions at the far right"
                size: "label"
                muted: true
            }
            Surface {
                width: 440
                padding_x: 0
                padding_y: 0
                Column {
                    width: parent.width
                    Feedback.Empty {
                        compact: true
                        icon: "≋"
                        title: "no networks found"
                        action: "scan again"
                        onActed: console.log("scan again")
                    }
                    Feedback.Loading {
                        compact: true
                        title: "scanning…"
                    }
                    Feedback.Error {
                        compact: true
                        icon: "≋"
                        title: "scan failed"
                        link: "open nmtui"
                        onRetried: console.log("retried")
                        onLinked: console.log("open nmtui")
                    }
                }
            }

            Text.Mono {
                text: "7 · Range"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Slider · drag or click the bar · Tab to it, then ← → (step) · Page Up/Down · Home/End"
                size: "label"
                muted: true
            }
            Column {
                width: 420
                spacing: Spacing.gap
                Range.Slider {
                    width: parent.width
                    icon: "♪"
                    value: gallery.volume
                    label: Math.round(gallery.volume) + "%"
                    onMoved: value => gallery.volume = value
                }
                Range.Slider {
                    width: parent.width
                    icon: "☀"
                    value: gallery.brightness
                    step: 5
                    label: Math.round(gallery.brightness) + "%"
                    onMoved: value => gallery.brightness = value
                }
                Range.Slider {
                    width: parent.width
                    icon: "♪"
                    value: 30
                    label: "30%"
                    enabled: false
                }
            }

            Text.Mono {
                text: "Basic · read-only: the same bar, no handle · a title_width lines bars up"
                size: "label"
                muted: true
            }
            Column {
                width: 420
                spacing: Spacing.gap
                Range.Basic {
                    width: parent.width
                    icon: "▮"
                    value: 82
                    label: "82%"
                }
                Range.Basic {
                    width: parent.width
                    title: "cpu 0"
                    title_width: 56
                    value: 37
                    label: "37%"
                }
                Range.Basic {
                    width: parent.width
                    title: "cpu 1"
                    title_width: 56
                    value: 64
                    label: "64%"
                }
                Range.Basic {
                    width: parent.width
                    value: gallery.volume
                    label: "follows the volume"
                }
            }

            Text.Mono {
                text: "Progress · a value, or indeterminate (the stripe moves) · a bare bar works as a countdown"
                size: "label"
                muted: true
            }
            Column {
                width: 420
                spacing: Spacing.gap
                Range.Progress {
                    width: parent.width
                    title: "update"
                    title_width: 64
                    value: 62
                    label: "62%"
                }
                Range.Progress {
                    width: parent.width
                    title: "scanning"
                    title_width: 64
                    indeterminate: true
                    label: "…"
                }
                Range.Progress {
                    width: parent.width
                    value: 45
                }
            }

            Text.Mono {
                text: "Steps · a value as rising bars: 0 · 10 · 50 · 75 · 100 · small enough for the bar"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Range.Steps {
                    value: 0
                }
                Range.Steps {
                    value: 10
                }
                Range.Steps {
                    value: 50
                }
                Range.Steps {
                    icon: "≋"
                    value: 75
                }
                Range.Steps {
                    value: 100
                    label: "full"
                }
            }

            Text.Mono {
                text: "Ring · the bar bent into a circle, for the dashboard · disabled turns gray"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Range.Ring {
                    value: 37
                    label: "37%"
                    title: "cpu"
                }
                Range.Ring {
                    value: gallery.volume
                    label: Math.round(gallery.volume) + "%"
                    title: "volume"
                }
                Range.Ring {
                    value: 70
                    label: "70%"
                    title: "disk"
                    enabled: false
                }
            }

            Text.Mono {
                text: "Seek · a slider in seconds, shown as m:ss · the darker part is already loaded"
                size: "label"
                muted: true
            }
            Range.Seek {
                width: 420
                value: gallery.position
                to: 231
                buffered: 166
                onMoved: value => gallery.position = value
            }

            Text.Mono {
                text: "8 · Tabs"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Basic · click a tab, or Tab into the bar and use ← → · Home · End · Tab again leaves it"
                size: "label"
                muted: true
            }
            Surface {
                width: 420
                padding_x: 0
                padding_y: 0
                Column {
                    width: parent.width
                    Tabs.Basic {
                        width: parent.width
                        tabs: ["overview", "media", "system", "weather"]
                        current: gallery.tab
                        onSelected: index => {
                            gallery.tab = index;
                            fade.restart();
                        }
                    }
                    Item {
                        width: parent.width
                        height: 72
                        Text.Mono {
                            id: tab_view
                            x: Spacing.edge
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - Spacing.edge * 2
                            text: ["09:27 · thursday, november 26 · 3 notifications", "Back in Black · AC/DC · 1:24 / 3:51", "cpu 37% · memory 62% · disk 70%", "24°C · dhaka · haze"][gallery.tab]
                            muted: true
                        }
                        NumberAnimation {
                            id: fade
                            target: tab_view
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: Motion.close
                            easing.type: Motion.ease_out
                        }
                    }
                }
            }

            Text.Mono {
                text: "9 · Field"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Basic · one line · Enter submits · Esc clears, then leaves"
                size: "label"
                muted: true
            }
            Field.Basic {
                width: 420
                text: gallery.network
                placeholder: "name this network"
                onEdited: text => gallery.network = text
                onSubmitted: text => console.log("saved:", text)
            }

            Text.Mono {
                text: "Search · a field with a search icon · × clears · for a list to pick from, see 10 · Picker"
                size: "label"
                muted: true
            }
            Field.Search {
                width: 420
                text: gallery.query
                placeholder: "filter…"
                onEdited: text => gallery.query = text
            }

            Text.Mono {
                text: "Password · hidden · the eye shows it (click, or Tab to it and Space)"
                size: "label"
                muted: true
            }
            Field.Password {
                width: 420
                text: gallery.password
                placeholder: "password for office-5g"
                onEdited: text => gallery.password = text
            }

            Text.Mono {
                text: "error · still editable, so you can fix it"
                size: "label"
                muted: true
            }
            Field.Password {
                width: 420
                text: "hunter2"
                error: "wrong password"
            }

            Text.Mono {
                text: "disabled · can't be focused or edited"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.gap
                Field.Password {
                    width: 204
                    text: "hunter2"
                    enabled: false
                }
                Field.Basic {
                    width: 204
                    text: "home"
                    enabled: false
                }
            }

            Text.Mono {
                text: "10 · Picker"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Palette · fzf-style: try gst · sm · vsc · ↑ ↓ (or ctrl+n/p) move while you type · Enter picks"
                size: "label"
                muted: true
            }
            Picker.Palette {
                width: 420
                options: gallery.apps
                placeholder: "search apps…"
                onPicked: option => gallery.launched = option.title
            }
            Text.Mono {
                visible: gallery.launched !== ""
                text: "launched: " + gallery.launched
                size: "label"
                muted: true
            }

            Text.Mono {
                text: "Select · opens on the current value · Space or click · ↑ ↓ Enter · Esc · the second one has a filter"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.gap
                Picker.Select {
                    width: 180
                    current: gallery.power
                    options: [{ title: "eco" }, { title: "balanced" }, { title: "performance" }]
                    onPicked: option => gallery.power = option.title
                }
                Picker.Select {
                    width: 220
                    searchable: true
                    placeholder: "keyboard layout"
                    current: gallery.layout
                    options: [{ title: "english (us)" }, { title: "english (uk)" }, { title: "bangla" }, { title: "german" }, { title: "french" }, { title: "japanese" }, { title: "spanish" }, { title: "arabic" }]
                    onPicked: option => gallery.layout = option.title
                }
            }

            Text.Mono {
                text: "Menu · a popup list · typing jumps to a match · Home · End · Esc closes"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.gap
                Button.Basic {
                    id: more
                    text: "⋯ actions"
                    variant: "outline"
                    onClicked: actions.show(more)
                }
                Text.Mono {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: gallery.action !== ""
                    text: "picked: " + gallery.action
                    size: "label"
                    muted: true
                }
            }
            Picker.Menu {
                id: actions
                anchor: more
                options: [{ title: "copy", meta: "ctrl c" }, { title: "rename", meta: "f2" }, { title: "move to trash", meta: "del" }, { title: "properties" }]
                onPicked: option => gallery.action = option.title
            }

            Text.Mono {
                text: "11 · Badge"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Count · on an icon's corner · 99+ above the limit · hidden at 0 · click the bell to add one"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Item {
                    width: 24
                    height: 22
                    Text.Mono {
                        id: bell
                        text: "♫"
                        tone: Colors.primary
                        TapHandler {
                            onTapped: gallery.notifications += 1
                        }
                    }
                    Badge.Count {
                        anchors.left: bell.right
                        anchors.leftMargin: -4
                        anchors.top: bell.top
                        anchors.topMargin: -6
                        count: gallery.notifications
                    }
                }
                Badge.Count {
                    count: 12
                }
                Badge.Count {
                    count: 150
                    error: true
                }
                Badge.Count {
                    count: 0
                }
                Badge.Dot {
                    anchors.verticalCenter: parent.verticalCenter
                }
                Badge.Dot {
                    anchors.verticalCenter: parent.verticalCenter
                    error: true
                }
            }

            Text.Mono {
                text: "Tag · outlined · accent · tonal · error · disabled"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner
                Badge.Tag {
                    text: "saved"
                }
                Badge.Tag {
                    text: "connected"
                    look: "accent"
                }
                Badge.Tag {
                    text: "new"
                    look: "tonal"
                }
                Badge.Tag {
                    text: "failed"
                    look: "error"
                }
                Badge.Tag {
                    text: "off"
                    enabled: false
                }
            }

            Text.Mono {
                text: "12 · Chart"
                size: "title"
                tone: Colors.primary
            }

            Text.Mono {
                text: "Spark · a line with a filled area, next to its value (live)"
                size: "label"
                muted: true
            }
            Column {
                width: 420
                Chart.Spark {
                    width: parent.width
                    title: "cpu"
                    title_width: 64
                    values: gallery.cpu
                    label: gallery.cpu[gallery.cpu.length - 1] + "%"
                }
                Chart.Spark {
                    width: parent.width
                    title: "memory"
                    title_width: 64
                    values: gallery.memory
                    label: gallery.memory[gallery.memory.length - 1] + "%"
                }
            }

            Text.Mono {
                text: "Columns · one block per value: cores now, or a minute of history"
                size: "label"
                muted: true
            }
            Column {
                width: 420
                Chart.Columns {
                    width: parent.width
                    title: "cores"
                    title_width: 64
                    values: gallery.cores
                }
                Chart.Columns {
                    width: parent.width
                    title: "60 s"
                    title_width: 64
                    values: gallery.history
                }
            }

            Text.Mono {
                text: "Lines · two series in one plot · to: 0 scales to the highest value"
                size: "label"
                muted: true
            }
            Chart.Lines {
                width: 420
                title: "network"
                title_width: 64
                to: 0
                values: gallery.download
                second: gallery.upload
                label: "↓ " + (gallery.download[gallery.download.length - 1] / 25).toFixed(1) + " MB/s"
            }
        }
    }

    Rectangle {
        visible: scroller.contentHeight > scroller.height
        anchors.right: parent.right
        anchors.rightMargin: 2
        width: 3
        radius: Shape.radius
        color: Colors.outline_variant
        y: scroller.visibleArea.yPosition * scroller.height
        height: scroller.visibleArea.heightRatio * scroller.height
    }

    Connections {
        target: gallery.Window.window
        function onActiveFocusItemChanged() {
            const item = gallery.Window.activeFocusItem;
            if (!item)
                return;
            const top = item.mapToItem(scroller.contentItem, 0, 0).y - Spacing.edge;
            const bottom = top + item.height + Spacing.edge * 2;
            if (top < scroller.contentY)
                scroller.contentY = Math.max(0, top);
            else if (bottom > scroller.contentY + scroller.height)
                scroller.contentY = Math.min(scroller.contentHeight - scroller.height, bottom - scroller.height);
        }
    }
}
