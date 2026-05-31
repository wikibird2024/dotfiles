
#!/bin/bash

MAIN_FILE="main.tex"
PDF_FILE="${MAIN_FILE%.*}.pdf"

# ===============================
# Xóa file tạm
# ===============================
echo "🧹 Xóa các file tạm..."
rm -f *.aux *.log *.out *.toc *.bbl *.bcf *.blg *.run.xml *.nav *.snm *.synctex.gz

# ===============================
# Build XeLaTeX lần đầu
# ===============================
echo "🚀 Build lần đầu bằng XeLaTeX..."
xelatex -shell-escape -interaction=nonstopmode "$MAIN_FILE"

# ===============================
# Chạy Biber
# ===============================
if [ -f "${MAIN_FILE%.*}.bcf" ]; then
    echo "📚 Chạy Biber..."
    biber "${MAIN_FILE%.*}"
else
    echo "⚠️ Không tìm thấy .bcf, bỏ qua Biber."
fi

# ===============================
# Build lại để cập nhật cross-reference và citation
# ===============================
echo "🔄 Build lần 2 và 3 để hoàn tất..."
xelatex -shell-escape -interaction=nonstopmode "$MAIN_FILE"
xelatex -shell-escape -interaction=nonstopmode "$MAIN_FILE"

# ===============================
# Kiểm tra PDF
# ===============================
if [ -f "$PDF_FILE" ]; then
    echo "✅ Biên dịch thành công: $PDF_FILE"
else
    echo "❌ Biên dịch thất bại! Kiểm tra main.log"
    exit 1
fi

# ===============================
# Mở PDF
# ===============================
if command -v zathura >/dev/null 2>&1; then
    zathura "$PDF_FILE" &>/dev/null &
    echo "📖 Mở PDF bằng Zathura..."
else
    echo "⚠️ Zathura không có trong PATH. Mở $PDF_FILE thủ công."
fi
