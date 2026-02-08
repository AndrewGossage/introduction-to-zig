package main
import "core:os"
import "core:fmt"
import "core:strings"

  
print_body :: proc(snippet: string) -> (string, bool) {

    bodySnippet, ok := os.read_entire_file("./static/body.html")
    if !ok {
        fmt.eprintln("Failed to read body")
        return "", false
    }
    defer delete(bodySnippet)
    
    template := string(bodySnippet)
    
    result, ok1 := strings.replace_all(template, "{{CONTENT}}", snippet)
    
    return result, true
}

print_card :: proc(card: Card) -> (string, bool) {
    path: string
    switch (card.ctype) {
        case .CODE: path = "./static/code_card.html"
        case .TEXT: path = "./static/text_card.html"
        case .HTML: path = "./static/html_card.html"
    }
    cardSnippet, ok1 := os.read_entire_file(path)
    if !ok1 {
        fmt.eprintln("Failed to read card")
        return "", false
    }
    defer delete(cardSnippet)
    result := string(cardSnippet)
    
    ok := true
    result, ok = strings.replace_all(result, "{{ID}}", card.id)
    result, ok = strings.replace_all(result, "{{TITLE}}", card.title)
    result, ok = strings.replace_all(result, "{{BODY}}", card.body)


    if (card.code_path != nil){
        snippet, ok := os.read_entire_file(card.code_path.?)
        defer delete(snippet)

        if !ok {
            fmt.eprintln("Failed to read file")
            fmt.eprintln(card.code_path.?)

            return "", false
        }
        result, ok = strings.replace_all(result, "{{CONTENT}}", string(snippet))

        result, ok = strings.replace_all(result, "{{CODE_PATH}}", card.code_path.?)
    }
    
    return result, true
}
