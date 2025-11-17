#!/usr/bin/env bash
set -u

FILE_PATH="$1"
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_BASENAME="$(basename "$FILE_PATH")"
TMP_PREVIEW="/tmp/ranger_preview_$$"

# Clean tmp preview
cleanup() { rm -f "$TMP_PREVIEW.jpg"; }
trap cleanup EXIT

case "$FILE_EXTENSION" in
    # -------------------------
    # Code/Text preview
    # -------------------------
    c|cpp|h|py|sh|lua|json|toml|yaml|yml|txt|md)
        bat --style=plain --color=always --paging=never --terminal-width $(tput cols) "$FILE_PATH"
        exit 0
        ;;

    # -------------------------
    # PDF preview
    # -------------------------
    pdf)
        pdftoppm -f 1 -singlefile -jpeg "$FILE_PATH" "$TMP_PREVIEW" >/dev/null 2>&1
        if [ -f "$TMP_PREVIEW.jpg" ]; then
            ueberzug layer --parser simple --silent < <(printf 'add [identifier]="preview" [path]="%s"\n' "$TMP_PREVIEW.jpg")
        fi
        exit 0
        ;;

    # -------------------------
    # Images
    # -------------------------
    jpg|jpeg|png|gif|bmp|svg|tiff)
        ueberzug layer --parser simple --silent < <(printf 'add [identifier]="preview" [path]="%s"\n' "$FILE_PATH")
        exit 0
        ;;

    # -------------------------
    # Video / Audio
    # -------------------------
    mp4|mkv|avi|webm|mp3|wav|flac)
        mediainfo "$FILE_PATH"
        exit 0
        ;;

    # -------------------------
    # Archive
    # -------------------------
    zip|tar|gz|bz2|xz|rar|7z)
        atool -l "$FILE_PATH" || bsdtar -tf "$FILE_PATH"
        exit 0
        ;;

    # -------------------------
    # Fallback: show MIME type
    # -------------------------
    *)
        file --mime-type -b "$FILE_PATH"
        exit 0
        ;;
esac

