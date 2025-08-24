
#!/usr/bin/env bash
# scope.sh – ranger file preview

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

FILE_PATH="$1"
PV_WIDTH="$2"
PV_HEIGHT="$3"
IMAGE_CACHE_PATH="$4"
PV_IMAGE_ENABLED="$5"

mimetype=$(file --mime-type -Lb "$FILE_PATH")

case "$mimetype" in
    # Images
    image/*)
        exit 7 ;;  # handled by ueberzug
    # PDFs
    application/pdf)
        pdftoppm -png -f 1 -singlefile "$FILE_PATH" "$IMAGE_CACHE_PATH" && exit 6
        ;;
    # Video thumbnails
    video/*)
        ffmpegthumbnailer -i "$FILE_PATH" -o "$IMAGE_CACHE_PATH.png" -s 0 && exit 6
        ;;
    # Text/code
    text/* | */xml | application/json)
        bat --color=always --style=plain --pager=never "$FILE_PATH"
        exit 5 ;;
    # Fallback
    *)
        file -Lb "$FILE_PATH"
        exit 5 ;;
esac
