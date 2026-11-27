# qml-lab

A TUI-style design system for a Quickshell desktop shell. Pure QML: a Qt Quick
Controls style (**Tui**) painted from Material 3 tokens, plus the shell's
simulated services. See [`ARCHITECTURE.md`](ARCHITECTURE.md) (how the library is
built), [`DESIGN.md`](DESIGN.md) (the look) and [`SHELL.md`](SHELL.md) (the shell
plan).

## Setup

Needs the native Qt 6.12+ QML runtime:

```bash
brew install qt
```

## Run

```bash
make run                     # the component gallery
make lab                     # the shell lab (device scenarios), with hot reload
make watch FILE=path/to.qml  # any file, with hot reload
make run FILE=path/to.qml    # any file, no reload
```

Under the hood that's the native `qml` / `qmlpreview` runtime with the Tui style
and the `lib/` + `shell/sim` import paths — no Python.

## Layout

| Path | What |
| --- | --- |
| `lib/theme/` | M3 tokens: Colors, States, Shape, Spacing, Motion, Type |
| `lib/Tui/` | the Qt Quick Controls style (40 controls) |
| `lib/primitives/` | Divider, Keycap, Avatar, Combo, Image |
| `gallery/` | component showcase + state / popup harnesses |
| `shell/sim/` | simulated services + `lab.qml` (the device simulator) |

## Editor

VS Code: install the Qt extension and register the Homebrew Qt
(`/opt/homebrew/opt/qt`). `.qmlls.ini` and `.vscode/settings.json` wire the QML
language server (completion + lint) to it with the project's import paths; the
`run gallery` / `lab (hot reload)` tasks run it without leaving the editor.
