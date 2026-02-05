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
    
    {.HTML, "hello0", "Hello World", "And Goodbye Sanity", "./slides/hello.html"},
    {.CODE, "hello", "Hello World", "Minimal Example", "./zig/hello-01.zig"},
    {.CODE, "hello00", "Hello World", "Correct Example", "./zig/hello-00.zig"},

    {.HTML, "hello0", "User Input", "AKA: For if your program has users", "./slides/kermit.html"},
    {.CODE, "hello1", "User Input", "Part 1", "./zig/input.zig"},
    {.CODE, "hello2", "User Input", "Part 2", "./zig/input-02.zig"},
    {.CODE, "hello3", "User Input", "Part 3", "./zig/hello-02.zig"},

   
    {.HTML, "internet", "Interfacing With C", "AKA: The Segment At Fault", "./slides/c.html"},
    {.CODE, "linking-c", "Interfacing With C", "part 1", "./zig/c.zig"},
    {.CODE, "linking-c2", "Interfacing With C", "part 2", "./zig/c-02.zig"},
    
    {.HTML, "internet", "Welcome to The Internet", "Clients and Servers", "./slides/internet.html"},
    {.CODE, "web-server", "Welcome to The Internet", "Server", "./zig/server.zig"},
    {.CODE, "web-client", "Welcome to The Internet", "Client", "./zig/client.zig"},
    
    {.HTML, "Advanced", "Advanced Topics", "AKA: How to make consts and influence vars", "./slides/pro.html"},
    {.CODE, "meta", "Meta Programming", "Comptime Magic", "./zig/meta-01.zig" },
    {.CODE, "builtin", "Meta Programming", "Comptime Magic", "./zig/builtin-01.zig" }

}


