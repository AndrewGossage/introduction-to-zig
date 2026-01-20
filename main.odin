package main
import "core:os"
import "core:fmt"
import "core:strings"


main :: proc() {
    builder := strings.builder_make()
    cards: []Card = {
        {"hello", "Hello World", "this is the body", "./zig/hello-01.zig"},
        {"hello2", "Hello World 2", "", "./zig/hello-02.zig"}
    }
    for card in cards {
        result1 := print_card(card)
        strings.write_string(&builder, result1)

    }
    defer strings.builder_destroy(&builder)
    result := strings.to_string(builder);

    //defer delete(result)
    
    body := print_body(result)
    defer delete(body)
    
    fmt.println(body)
}
