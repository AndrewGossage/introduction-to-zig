package main
import "core:os"
import "core:fmt"
import "core:strings"

  
print_body :: proc(content: string) -> (string, bool) {

    body_bytes, err := os.read_entire_file("./static/body.html", context.allocator)
    if err != nil {
        fmt.eprintln("Failed to read body")
        return "", false
    }
    defer delete(body_bytes)

    template := string(body_bytes)

    page, _ := strings.replace_all(template, "{{CONTENT}}", content)

    return page, true
}

print_card :: proc(card: Card) -> (string, bool) {
    template_path: string
    switch (card.ctype) {
        case .CODE: template_path = "./static/code_card.html"
        case .TEXT: template_path = "./static/text_card.html"
        case .HTML: template_path = "./static/html_card.html"
    }
    card_bytes, err := os.read_entire_file(template_path, context.allocator)
    if err != nil {
        fmt.eprintln("Failed to read card")
        return "", false
    }
    defer delete(card_bytes)
    result := string(card_bytes)

    result, _ = strings.replace_all(result, "{{ID}}", card.id)
    result, _ = strings.replace_all(result, "{{TITLE}}", card.title)
    result, _ = strings.replace_all(result, "{{BODY}}", card.body)


    if (card.code_path != nil){
        content_bytes, read_err := os.read_entire_file(card.code_path.?, context.allocator)
        defer delete(content_bytes)

        if read_err != nil {
            fmt.eprintln("Failed to read file")
            fmt.eprintln(card.code_path.?)

            return "", false
        }
        result, _ = strings.replace_all(result, "{{CONTENT}}", string(content_bytes))

        result, _ = strings.replace_all(result, "{{CODE_PATH}}", card.code_path.?)
    }

    return result, true
}
