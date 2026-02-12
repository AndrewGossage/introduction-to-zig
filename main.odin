package main
import "core:os"
import "core:fmt"
import "core:strings"


main :: proc() {
    builder := strings.builder_make()
    defer strings.builder_destroy(&builder)
        

    for card in cards {
        card_html, ok := print_card(card)
        if !ok { return }
        strings.write_string(&builder, card_html)
    }

    content := strings.to_string(builder);

    page, ok := print_body(content)
    defer delete(page)
    if !ok { return }


    fmt.println(page)
}
