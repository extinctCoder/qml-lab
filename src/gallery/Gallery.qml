import QtQuick
import theme
import components.ui
import components.ui.text as Text
import components.ui.button as Button

// The storybook: the button family (Basic and Toggle), the text family (Mono and Header),
// and Surface, our look for any box. Everything with a box gets it from Surface.
// It scrolls (wheel, trackpad, or by dragging), and follows the keyboard focus.
Rectangle {
    id: gallery
    width: 680
    height: 440
    color: Colors.surface

    // the gallery owns the values the toggles show
    property bool silent: false
    property string power: "eco"
    property string output: "headphones"

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

            // ---- Button.Toggle: holds a value ----
            Text.Mono {
                text: "Button.Toggle · one of several (Space or click)"
                size: "label"
                muted: true
            }

            Row {
                spacing: Spacing.tight

                Button.Toggle {
                    text: "eco"
                    checked: gallery.power === "eco"
                    onClicked: {
                        gallery.power = "eco";
                        console.log("power →", gallery.power);
                    }
                }
                Button.Toggle {
                    text: "balanced"
                    checked: gallery.power === "balanced"
                    onClicked: {
                        gallery.power = "balanced";
                        console.log("power →", gallery.power);
                    }
                }
                Button.Toggle {
                    text: "performance"
                    checked: gallery.power === "performance"
                    onClicked: {
                        gallery.power = "performance";
                        console.log("power →", gallery.power);
                    }
                }
            }

            Text.Mono {
                text: "Button.Toggle · on/off"
                size: "label"
                muted: true
            }

            Button.Toggle {
                text: gallery.silent ? "silent: on" : "silent: off"
                checked: gallery.silent
                onClicked: {
                    gallery.silent = !gallery.silent;
                    console.log("silent →", gallery.silent);
                }
            }

            // ---- Button.Row: one line in a list ----
            Text.Mono {
                text: "Button.Row · checkable, one of several (● ○): click or Space"
                size: "label"
                muted: true
            }
            Surface {
                width: 380
                Column {
                    width: parent.width
                    Button.Row {
                        title: "speakers"
                        meta: "built-in"
                        checkable: true
                        checked: gallery.output === "speakers"
                        onClicked: {
                            gallery.output = "speakers";
                            console.log("output →", gallery.output);
                        }
                    }
                    Button.Row {
                        title: "headphones"
                        meta: "bluetooth"
                        checkable: true
                        checked: gallery.output === "headphones"
                        onClicked: {
                            gallery.output = "headphones";
                            console.log("output →", gallery.output);
                        }
                    }
                    Button.Row {
                        title: "hdmi"
                        meta: "monitor"
                        checkable: true
                        enabled: false
                    }
                }
            }

            Text.Mono {
                text: "Button.Row · actions (click or Enter) · an icon, meta, a second line"
                size: "label"
                muted: true
            }
            Surface {
                width: 380
                Column {
                    width: parent.width
                    Button.Row {
                        icon: "≋"
                        title: "home"
                        meta: "92% · connected"
                        onClicked: console.log("open: home")
                    }
                    Button.Row {
                        icon: "≋"
                        title: "office-5g"
                        meta: "64%"
                        onClicked: console.log("open: office-5g")
                    }
                    Button.Row {
                        icon: "▣"
                        title: "zen browser"
                        description: "web browser"
                        meta: "↵"
                        onClicked: console.log("launch: zen")
                    }
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
