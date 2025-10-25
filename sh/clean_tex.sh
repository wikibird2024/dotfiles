#!/bin/bash

# Define the name of your main LaTeX file (without extension)
MAIN_FILE="main"

# --- Clean up phase ---
echo "--- Cleaning auxiliary files... ---"

# Remove common auxiliary files
rm -f "$MAIN_FILE.aux" "$MAIN_FILE.bbl" "$MAIN_FILE.bcf" "$MAIN_FILE.blg" "$MAIN_FILE.lof" "$MAIN_FILE.log" "$MAIN_FILE.lot" "$MAIN_FILE.out" "$MAIN_FILE.toc" "$MAIN_FILE.run.xml"

# Remove other common LaTeX-generated files
rm -f *.spl *.synctex.gz *.fls *.fdb_latexmk

# Remove minted's temporary files and directories
# (minted creates a temporary directory and .pygtex files)
rm -rf "_minted-$MAIN_FILE"
rm -f *.pygtex

echo "--- Cleanup complete! ---"
