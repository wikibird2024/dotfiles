
#!/bin/bash

OUTPUT_FILE="function_list_by_component.txt"
> "$OUTPUT_FILE"

echo "🔍 Extracting function declarations from headers..." >> "$OUTPUT_FILE"
echo "=====================================================" >> "$OUTPUT_FILE"

# List of folders to search (modify if needed)
FOLDERS=("main" "components")

for folder in "${FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        find "$folder" -type f -name '*.h' | while read -r header; do
            echo -e "\n📁 File: $header" >> "$OUTPUT_FILE"
            echo "--------------------------------------------" >> "$OUTPUT_FILE"

            rg '^[a-zA-Z_][a-zA-Z0-9_ \*\t]*\([^\)]*\)\s*;' "$header" >> "$OUTPUT_FILE"
        done
    fi
done

echo -e "\n✅ Done. Output written to: $OUTPUT_FILE"
