package main
import "core:os"
import "core:fmt"
import "core:strings"

CardType :: enum {
    CODE, 
    TEXT,
    HTML,
}


Card :: struct {
    ctype: CardType,
    id: string,
    title: string,
    body: string,
    code_path: Maybe(string),
}

cards :[]Card: {
    {.HTML, "intro", "Introduction to Zig", "", "./slides/intro.html"},
    //{.HTML, "site", "What is Zig", "", "./slides/site.html"},
    {.CODE, "hello", "Hello World", "Part 1", "./zig/hello-01.zig"},
    {.CODE, "hello2", "Hello World", "Part 2", "./zig/hello-02.zig"},
    {.CODE, "hello3", "Hello World", "Part 3", "./zig/input.zig"},

    {.CODE, "linking-c", "Interfacing With C", "part 1", "./zig/c.zig"},
    {.CODE, "linking-c2", "Interfacing With C", "part 2", "./zig/c-02.zig"},
    {.CODE, "web-client", "Web Client", "", "./zig/client.zig"},
    {.CODE, "web-server", "Web server", "", "./zig/server.zig"},



    {.CODE, "meta", "Meta Programming", "Comptime Magic", "./zig/meta-01.zig" }
}


