package main
import "core:os"
import "core:fmt"
import "core:strings"



Card :: struct {
    id: string,
    code_path: string,
}
  
print_body :: proc(snippet: string) -> string {
    bodySnippet, ok := os.read_entire_file("./body.html")
    if !ok {
        fmt.eprintln("Failed to read body")
        return ""
    }
    defer delete(bodySnippet)
    
    template := string(bodySnippet)
    
    builder := strings.builder_make()
    defer strings.builder_destroy(&builder)
    
    fmt.sbprintf(&builder, template, snippet)
    
    return strings.clone(strings.to_string(builder))
}

print_card :: proc(card: Card) -> string {
    cardSnippet, ok1 := os.read_entire_file("./card.html")
    if !ok1 {
        fmt.eprintln("Failed to read card")
        return ""
    }
    defer delete(cardSnippet)
    
    snippet, ok := os.read_entire_file(card.code_path)
    if !ok {
        fmt.eprintln("Failed to read file")
        return ""
    }
    defer delete(snippet)
    
    content := string(snippet)
    template := string(cardSnippet)
    
    builder := strings.builder_make()
    defer strings.builder_destroy(&builder)
    
    fmt.sbprintf(&builder, template, card.id, content)
    
    return strings.clone(strings.to_string(builder))
}

