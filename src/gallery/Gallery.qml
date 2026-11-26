import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.mark as Mark
import components.ui.button as Button
import components.ui.section as Section
import components.ui.feedback as Feedback

// The storybook: every component, in the order the library is built, bottom-up:
// Surface → Text → Mark → Button → Section → Feedback. Each part shows its variants and states.
// It scrolls (wheel, trackpad, or by dragging), and follows the keyboard focus.
Rectangle {
    id: gallery
    width: 680
    height: 800
    color: Colors.surface

    // the gallery owns the values its components show, like an OS control will later
    property string power: "eco"
    property bool silent: false
    property string output: "headphones"
    property bool wifi: true
    property bool bluetooth: false
    property bool night_light: true
    property bool stay_awake: false

    // The scrollable area: a window-sized view onto the (taller) column of parts.
    Flickable {
        id: scroller
        anchors.fill: parent
        contentWidth: width
        contentHeight: sections.implicitHeight + Spacing.edge * 2
        boundsBehavior: Flickable.StopAtBounds      // no rubber-band bounce: calm by default
        clip: true

        Column {
            id: sections
            x: Spacing.edge
            y: Spacing.edge
            width: scroller.width - Spacing.edge * 2
            spacing: Spacing.gap

            // =====================================================================
            // 1 · Surface: our look for any box
            // =====================================================================
            Text.Mono {
                text: "1 · Surface"
                size: "title"
                color: Colors.primary
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

            // =====================================================================
            // 2 · Text: Mono and Header
            // =====================================================================
            Text.Mono {
                text: "2 · Text"
                size: "title"
                color: Colors.primary
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
                    color: Colors.primary
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

            // =====================================================================
            // 3 · Mark: the drawn markers, on their own (click to flip them)
            // =====================================================================
            Text.Mono {
                text: "3 · Mark"
                size: "title"
                color: Colors.primary
            }

            Text.Mono {
                text: "Switch · Choice radio · Choice check · Chevron · Spinner · click to flip them"
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

            // =====================================================================
            // 4 · Button: Basic · ListItem · Tile
            // =====================================================================
            Text.Mono {
                text: "4 · Button"
                size: "title"
                color: Colors.primary
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
                text: "Basic · checkable: one of several, and an on/off (Space or click)"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.edge
                Row {
                    spacing: Spacing.tight
                    Button.Basic {
                        variant: "outline"
                        checkable: true
                        text: "eco"
                        checked: gallery.power === "eco"
                        onClicked: gallery.power = "eco"
                    }
                    Button.Basic {
                        variant: "outline"
                        checkable: true
                        text: "balanced"
                        checked: gallery.power === "balanced"
                        onClicked: gallery.power = "balanced"
                    }
                    Button.Basic {
                        variant: "outline"
                        checkable: true
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
                text: "ListItem · radio (one of several) · check (on/off) · actions with meta and a second line"
                size: "label"
                muted: true
            }
            Row {
                spacing: Spacing.inner
                Surface {
                    width: 200
                    Column {
                        width: parent.width
                        Button.ListItem {
                            title: "speakers"
                            checkable: true
                            checked: gallery.output === "speakers"
                            onClicked: gallery.output = "speakers"
                        }
                        Button.ListItem {
                            title: "headphones"
                            checkable: true
                            checked: gallery.output === "headphones"
                            onClicked: gallery.output = "headphones"
                        }
                        Button.ListItem {
                            title: "hdmi"
                            checkable: true
                            enabled: false
                        }
                    }
                }
                Surface {
                    width: 200
                    Column {
                        width: parent.width
                        Button.ListItem {
                            title: "wi-fi"
                            mark: "check"
                            checkable: true
                            checked: gallery.wifi
                            onClicked: gallery.wifi = !gallery.wifi
                        }
                        Button.ListItem {
                            title: "bluetooth"
                            mark: "check"
                            checkable: true
                            checked: gallery.bluetooth
                            onClicked: gallery.bluetooth = !gallery.bluetooth
                        }
                        Button.ListItem {
                            title: "airplane"
                            mark: "check"
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

            // =====================================================================
            // 5 · Section: built from all of the above
            // =====================================================================
            Text.Mono {
                text: "5 · Section"
                size: "title"
                color: Colors.primary
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
                description: gallery.output + " · 51%"
                Button.ListItem {
                    title: "speakers"
                    meta: "built-in"
                    checkable: true
                    checked: gallery.output === "speakers"
                    onClicked: gallery.output = "speakers"
                }
                Button.ListItem {
                    title: "headphones"
                    meta: "bluetooth"
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

            // =====================================================================
            // 6 · Feedback: what's there when there's nothing to show (yet)
            // =====================================================================
            Text.Mono {
                text: "6 · Feedback"
                size: "title"
                color: Colors.primary
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
        }   // end of the sections Column
    }       // end of the Flickable

    // a thin scroll position marker on the right edge, only when there is more to scroll
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

    // keyboard first: when Tab moves focus outside the visible part, scroll it into view
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
