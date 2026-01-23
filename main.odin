package main
import "core:os"
import "core:fmt"
import "core:strings"


main :: proc() {
    builder := strings.builder_make()
    defer strings.builder_destroy(&builder)
        

    for card in cards {
        result1, ok := print_card(card)
        if !ok { return }
        strings.write_string(&builder, result1)
    }
    
    result := strings.to_string(builder);
   
    body, ok := print_body(result)
    defer delete(body)
    if !ok { return }

    
    fmt.println(body)
}
