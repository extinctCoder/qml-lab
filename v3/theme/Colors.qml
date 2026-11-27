pragma Singleton
import QtQuick

// M3 colour roles, pruned for a flat TUI: the surface tiers are colour-only
// (no elevation shadows). Palette: Catppuccin-Mocha neutrals + a vivid terminal
// green as the single accent. Every active / checked / selected mark in the Tui
// style reads `primary`, so the active colour is uniform across every control.
QtObject {
    // ── surfaces · low → high is darker → lifted (colour, never shadow) ──────
    readonly property color surface_container_lowest: "#0e0e16"
    readonly property color surface_container_low: "#11111b"
    readonly property color surface: "#181825"            // app background
    readonly property color surface_container: "#1e1e2e"  // panes lift above bg
    readonly property color surface_container_high: "#292a3b"
    readonly property color surface_container_highest: "#313244" // menus · grooves
    readonly property color surface_variant: "#313244"

    // ── foreground on surfaces ──────────────────────────────────────────────
    readonly property color on_surface: "#cdd6f4"
    readonly property color on_surface_variant: "#a6adc8"

    // ── accent · the one green, used for EVERY active mark ───────────────────
    readonly property color primary: "#a6e3a1"
    readonly property color on_primary: "#11111b"
    readonly property color primary_container: "#2f4330"
    readonly property color on_primary_container: "#c6e8c0"

    // ── low-emphasis accent container · selected rows / tonal buttons ────────
    readonly property color secondary_container: "#2f4330"
    readonly property color on_secondary_container: "#c6e8c0"

    // ── lines ───────────────────────────────────────────────────────────────
    readonly property color outline: "#6c7086"
    readonly property color outline_variant: "#45475a"

    // ── semantic ────────────────────────────────────────────────────────────
    readonly property color error: "#f38ba8"
    readonly property color on_error: "#11111b"
    readonly property color success: "#a6e3a1"
    readonly property color warning: "#f9e2af"
}
