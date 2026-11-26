import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.button as Button
import components.ui.section as Section

// The storybook: the button family (Basic, ListItem, Tile), the text family (Mono and Header),
// and Surface, our look for any box. Everything with a box gets it from Surface.
// It scrolls (wheel, trackpad, or by dragging), and follows the keyboard focus.
Rectangle {
    id: gallery
    width: 680
    height: 440
    color: Colors.surface

    // the gallery owns the values the checkable buttons, list items and tiles show
    property bool silent: false
    property string power: "eco"
    property string output: "headphones"
    property bool night_light: true
    property bool stay_awake: false
    property bool wifi: true

    // The scrollable area: a window-sized view onto the (taller) column of sections.
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

            // ---- Button.Basic: an action ----
            Text.Mono {
                text: "Button.Basic · five variants · click: see the terminal · Tab moves focus"
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
                text: "Button.Basic · stretched: the width comes from the layout"
                size: "label"
                muted: true
            }

            Button.Basic {
                width: 420
                text: "connect"
                onClicked: console.log("connect")
            }

            // ---- Button.Basic, checkable: holds a value ----
            Text.Mono {
                text: "Button.Basic · checkable: one of several (Space or click)"
                size: "label"
                muted: true
            }

            Row {
                spacing: Spacing.tight

                Button.Basic {
                    variant: "outline"
                    checkable: true
                    text: "eco"
                    checked: gallery.power === "eco"
                    onClicked: {
                        gallery.power = "eco";
                        console.log("power →", gallery.power);
                    }
                }
                Button.Basic {
                    variant: "outline"
                    checkable: true
                    text: "balanced"
                    checked: gallery.power === "balanced"
                    onClicked: {
                        gallery.power = "balanced";
                        console.log("power →", gallery.power);
                    }
                }
                Button.Basic {
                    variant: "outline"
                    checkable: true
                    text: "performance"
                    checked: gallery.power === "performance"
                    onClicked: {
                        gallery.power = "performance";
                        console.log("power →", gallery.power);
                    }
                }
            }

            Text.Mono {
                text: "Button.Basic · checkable: on/off"
                size: "label"
                muted: true
            }

            Button.Basic {
                variant: "outline"
                checkable: true
                text: gallery.silent ? "silent: on" : "silent: off"
                checked: gallery.silent
                onClicked: {
                    gallery.silent = !gallery.silent;
                    console.log("silent →", gallery.silent);
                }
            }

            // ---- Button.ListItem: one line in a list ----
            Text.Mono {
                text: "Button.ListItem · checkable, one of several (● ○): click or Space"
                size: "label"
                muted: true
            }
            Surface {
                width: 380
                Column {
                    width: parent.width
                    Button.ListItem {
                        title: "speakers"
                        meta: "built-in"
                        checkable: true
                        checked: gallery.output === "speakers"
                        onClicked: {
                            gallery.output = "speakers";
                            console.log("output →", gallery.output);
                        }
                    }
                    Button.ListItem {
                        title: "headphones"
                        meta: "bluetooth"
                        checkable: true
                        checked: gallery.output === "headphones"
                        onClicked: {
                            gallery.output = "headphones";
                            console.log("output →", gallery.output);
                        }
                    }
                    Button.ListItem {
                        title: "hdmi"
                        meta: "monitor"
                        checkable: true
                        enabled: false
                    }
                }
            }

            Text.Mono {
                text: "Button.ListItem · actions (click or Enter) · an icon, meta, a second line"
                size: "label"
                muted: true
            }
            Surface {
                width: 380
                Column {
                    width: parent.width
                    Button.ListItem {
                        icon: "≋"
                        title: "home"
                        meta: "92% · connected"
                        onClicked: console.log("open: home")
                    }
                    Button.ListItem {
                        icon: "≋"
                        title: "office-5g"
                        meta: "64%"
                        onClicked: console.log("open: office-5g")
                    }
                    Button.ListItem {
                        icon: "▣"
                        title: "zen browser"
                        description: "web browser"
                        meta: "↵"
                        onClicked: console.log("launch: zen")
                    }
                }
            }

            // ---- Button.Tile: a box in a grid ----
            Text.Mono {
                text: "Button.Tile · on/off (click or Space) or an action (click or Enter)"
                size: "label"
                muted: true
            }
            Grid {
                columns: 3
                spacing: Spacing.inner

                Button.Tile {
                    width: 190
                    icon: "☾"
                    title: "night light"
                    description: gallery.night_light ? "on" : "off"
                    checkable: true
                    checked: gallery.night_light
                    onClicked: gallery.night_light = !gallery.night_light
                }
                Button.Tile {
                    width: 190
                    icon: "☕"
                    title: "stay awake"
                    description: gallery.stay_awake ? "on" : "off"
                    checkable: true
                    checked: gallery.stay_awake
                    onClicked: gallery.stay_awake = !gallery.stay_awake
                }
                Button.Tile {
                    width: 190
                    icon: "⌁"
                    title: "bluetooth"
                    description: "no adapter"
                    checkable: true
                    enabled: false
                }
                Button.Tile {
                    width: 190
                    icon: "▦"
                    title: "dashboard"
                    description: "super + i"
                    meta: "→"
                    onClicked: console.log("dashboard")
                }
            }

            // ---- Section.Basic: the header opens it · checkable adds a switch ----
            Text.Mono {
                text: "Section.Basic · click the header (or Enter/Space) to open · the switch toggles on its own"
                size: "label"
                muted: true
            }
            Section.Basic {
                width: 400
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
                width: 400
                open: true
                icon: "≋"
                title: "wi-fi"
                description: gallery.wifi ? "home · 92%" : "off"
                meta: gallery.wifi ? "3 networks" : ""
                checkable: true
                checked: gallery.wifi
                onSwitched: {
                    gallery.wifi = !gallery.wifi;
                    console.log("wifi →", gallery.wifi);
                }
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

            // ---- Text: Mono and Header ----
            Text.Mono {
                text: "Header · icon spans title + description"
                size: "label"
                muted: true
            }
            Text.Header {
                icon: "≋"
                title: "wi-fi"
                description: "home network · 92%"
            }

            Text.Mono {
                text: "Header · no description: the icon matches the title"
                size: "label"
                muted: true
            }
            Text.Header {
                icon: "≋"
                title: "wi-fi"
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

            Text.Header {
                icon: "♪"
                title: "Back in Black"
                description: "AC/DC · 1980"
                title_size: "display"
                description_size: "body"
                surface: true
                icon_outline: true
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

            // ---- Surface: our look for any box ----
            Text.Mono {
                text: "Surface · holds anything · outlined, filled, ghost"
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
                text: "Surface · level 1 (deepest) to 5 (front) · the default is 3"
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
                text: "Surface · holding a Column: a header and a line"
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
