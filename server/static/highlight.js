function highlight() {
    const snips = document.querySelectorAll('.snippet');
    for (let snip of snips) {
        if (!snip) return;
        let text = snip.textContent;

        text = text.replace(/(\"[^\"]*\")/g, '<span class="string">$1</span>');
        text = text.replace(/(\'[^\']\')/g, '<span class="string">$1</span>');

        text = text.replace(/(@\w+)/g, '<span class="builtin">$1</span>');

        text = text.replaceAll(/(\/\/.*)/g, '<span class="comment">$1</span>');
        text = text.replaceAll(/(\/\/.*)/g, '<span class="comment">$1</span>');

        text = text.replace(/(\w+)([\(])/g, '<span class="fun">$1</span>$2');
        text = text.replace(/(\.)(\w+)/g, '$1<span class="field">$2</span>');
        text = text.replace(
            /(?<!\w+)(\d+)(?!\w+)/g,
            '<span class="number">$1</span>'
        );
        text = text.replace(
            /\b(pub|fn|const|void|try|return|inline|comptime|var|switch|struct|T|for|while)\b/g,
            '<span class="keyword">$1</span>'
        );
        snip.innerHTML = text.trim();
    }
}
highlight();
