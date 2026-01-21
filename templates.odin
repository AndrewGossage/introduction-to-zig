package main
import "core:os"
import "core:fmt"
import "core:strings"



Card :: struct {
    id: string,
    title: string,
    body: string,
    code_path: string,
}
  
print_body :: proc(snippet: string) -> (string, bool) {
    bodySnippet, ok := os.read_entire_file("./body.html")
    if !ok {
        fmt.eprintln("Failed to read body")
        return "", false
    }
    defer delete(bodySnippet)
    
    template := string(bodySnippet)
    
    builder := strings.builder_make()
    defer strings.builder_destroy(&builder)
    
    fmt.sbprintf(&builder, template, snippet)
    
    return strings.clone(strings.to_string(builder)), true
}

print_card :: proc(card: Card) -> (string, bool) {
    cardSnippet, ok1 := os.read_entire_file("./card.html")
    if !ok1 {
        fmt.eprintln("Failed to read card")
        return "", false
    }
    defer delete(cardSnippet)
    
    snippet, ok := os.read_entire_file(card.code_path)
    if !ok {
        fmt.eprintln("Failed to read file")
        return "", false
    }
    defer delete(snippet)
    
    result := string(cardSnippet)
    result,ok = strings.replace_all(result, "{{ID}}", card.id)
    result,ok = strings.replace_all(result, "{{TITLE}}", card.title)
    result,ok = strings.replace_all(result, "{{BODY}}", card.body)
    result,ok = strings.replace_all(result, "{{CONTENT}}", string(snippet))
    result,ok = strings.replace_all(result, "{{CODE_PATH}}", card.code_path)
    
    return result, true
}
