# Intro to Zig

An interactive slide-based presentation for learning the Zig programming language. Content is authored as Odin source files, compiled to a static HTML page, and served by [Zoi](server/README.md) -- a lightweight Zig HTTP server built on the standard library.

## Topics Covered

- Hello World
- Interfaces (vtables)
- User Input
- C Interop
- HTTP Clients and Servers
- Metaprogramming and Comptime
- Builtins

## Prerequisites

| Component              | Requirement |
|------------------------|-------------|
| Server (Zoi)           | Zig 0.15   |
| Demonstration programs | Zig 0.16   |
| Content generation     | Odin        |
| Hot-reload (optional)  | fd, stat    |

## Project Structure

```
.
├── server/            # Zoi web server (Zig)
│   ├── src/           #   server source code
│   ├── static/        #   served assets (generated)
│   ├── config.json    #   server configuration
│   └── build.zig      #   zig build file
├── slides/            # HTML slide content
├── zig/               # Zig example programs shown in the presentation
├── static/            # Static assets (copied into server/static at build time)
├── cards.odin         # Card definitions (slide ordering and content)
├── templates.odin     # Odin template rendering helpers
├── main.odin          # Odin entry point -- compiles cards to HTML
├── run.sh             # Build script
└── hotreload.sh       # File-watching dev script
```

## Building and Running

Compile the slides and start the server:

```sh
./run.sh           # compiles cards.odin → server/static/index.html
cd server
zig build run      # starts the server on http://127.0.0.1:8081
```

For development, `hotreload.sh` watches for changes to `.html`, `.odin`, `.js`, `.sh`, and `.zig` files and re-runs `run.sh` automatically:

```sh
./hotreload.sh
```

## Configuration

The server is configured via `server/config.json`:

```json
{
    "address": "127.0.0.1",
    "port": "8081",
    "workers": 3,
    "useArena": true
}
```

## How It Works

1. Slide content lives in `slides/` (HTML fragments) and `zig/` (code examples).
2. `cards.odin` defines an ordered list of cards, each referencing a slide or code file.
3. `run.sh` runs the Odin compiler, which renders every card through a template and writes a complete HTML page to `server/static/index.html`.
4. The Zoi server serves that page along with static assets (CSS, JS, images).

## See Also

- [Zoi server documentation](server/README.md)
- [Thanatos](https://github.com/AndrewGossage/Thanatos) -- an example of using Zoi as an Electron/Tauri alternative
