import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theme
import services

// The dashboard — the 2/3 column of the control center. Tabbed, overview first.
// Media / system / weather tabs fill in as their sim services land.
ColumnLayout {
    id: dash
    spacing: Spacing.gap

    component Card: Rectangle {
        id: card
        property string title
        default property alias cardContent: inner.data
        Layout.fillWidth: true
        implicitHeight: wrap.implicitHeight + Spacing.gap * 2
        radius: Shape.radius
        color: Colors.surface_container
        border.width: Shape.border
        border.color: Colors.outline_variant

        ColumnLayout {
            id: wrap
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: Spacing.gap
            spacing: Spacing.inner
            Label {
                text: card.title
                color: Colors.on_surface_variant
                font.family: Type.family
                font.pixelSize: Type.label
            }
            ColumnLayout { id: inner; Layout.fillWidth: true; spacing: Spacing.tight }
        }
    }

    TabBar {
        id: tabs
        Layout.fillWidth: true
        TabButton { text: "overview" }
        TabButton { text: "media" }
        TabButton { text: "system" }
        TabButton { text: "weather" }
    }

    StackLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        currentIndex: tabs.currentIndex

        // ── overview ────────────────────────────────────────────────────
        ColumnLayout {
            spacing: Spacing.gap

            ColumnLayout {
                spacing: 0
                Label { text: Time.clock; color: Colors.on_surface; font.family: Type.family; font.pixelSize: Type.display }
                Label { text: Time.day; color: Colors.on_surface_variant; font.family: Type.family; font.pixelSize: Type.title }
            }

            GridLayout {
                columns: 2
                rowSpacing: Spacing.gap
                columnSpacing: Spacing.gap
                Layout.fillWidth: true

                Card {
                    title: "now playing"
                    Label { text: "nothing playing"; color: Colors.on_surface; font.family: Type.family }
                }
                Card {
                    title: "weather"
                    Label { text: Weather.temp + "° · " + Weather.condition; color: Colors.on_surface; font.family: Type.family }
                    Label { text: Weather.location + " · H" + Weather.high + " L" + Weather.low; color: Colors.on_surface_variant; font.family: Type.family; font.pixelSize: Type.label }
                }
                Card {
                    title: "system"
                    Label { text: "cpu — · mem —"; color: Colors.on_surface; font.family: Type.family }
                }
                Card {
                    title: "notifications"
                    Label { text: "all caught up"; color: Colors.on_surface_variant; font.family: Type.family }
                }
            }

            Item { Layout.fillHeight: true }
        }

        // ── media ───────────────────────────────────────────────────────
        ColumnLayout {
            Label { text: "media — coming soon"; color: Colors.on_surface_variant; font.family: Type.family }
            Item { Layout.fillHeight: true }
        }
        // ── system ──────────────────────────────────────────────────────
        ColumnLayout {
            Label { text: "system — coming soon"; color: Colors.on_surface_variant; font.family: Type.family }
            Item { Layout.fillHeight: true }
        }
        // ── weather ─────────────────────────────────────────────────────
        ColumnLayout {
            spacing: Spacing.inner
            Label { text: Weather.temp + "°"; color: Colors.on_surface; font.family: Type.family; font.pixelSize: Type.display }
            Label { text: Weather.condition; color: Colors.on_surface_variant; font.family: Type.family; font.pixelSize: Type.title }
            Label { text: Weather.location + " · high " + Weather.high + "° · low " + Weather.low + "°"; color: Colors.on_surface_variant; font.family: Type.family }
            Item { Layout.fillHeight: true }
        }
    }
}
