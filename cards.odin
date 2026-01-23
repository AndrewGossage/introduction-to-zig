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
    {.HTML, "site", "What is Zig", "", "./slides/site.html"},
    {.CODE, "hello", "Hello World", "this is the body", "./zig/hello-01.zig"},
    {.CODE, "hello2", "Hello World 2", "", "./zig/hello-02.zig"},
    {.CODE, "linking-c", "Using C Code", "part 1", "./zig/c.zig"},
    {.CODE, "linking-c2", "Using C Code", "part 2", "./zig/c-02.zig"},


    {.CODE, "meta", "Meta Programming", "Comptime Magic", "./zig/meta-01.zig" }
}


