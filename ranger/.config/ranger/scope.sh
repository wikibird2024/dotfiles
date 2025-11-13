
#!/usr/bin/env bash
set -u

FILE_PATH="$1"
FILE_EXTENSION="${FILE_PATH##*.}"

case "$FILE_EXTENSION" in
    # Code preview
    c|cpp|h|py|sh|lua|json|toml|yaml|yml|txt|md)
        bat --style=plain --color=always "$FILE_PATH"
        exit 0;;
    # PDF
    pdf)
        pdftoppm -f 1 -singlefile -jpeg "$FILE_PATH" /tmp/pdf_preview > /dev/null 2>&1
        ueberzug layer --parser simple --silent < <(printf 'add [identifier]="preview" [path]="/tmp/pdf_preview.jpg"\n')
        exit 0;;
    # Images
    jpg|jpeg|png|gif|bmp|svg)
        ueberzug layer --parser simple --silent < <(printf 'add [identifier]="preview" [path]="'$FILE_PATH'"\n')
        exit 0;;
    # Archive
    zip|tar|gz|bz2|xz|rar)
        atool -l "$FILE_PATH"
        exit 0;;
    *)
        file --mime-type -b "$FILE_PATH"
        exit 0;;
esac
