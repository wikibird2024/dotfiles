-- File: system/constitution/cmp_sources.lua
-- Thứ tự trong danh sách này quyết định thứ tự xuất hiện trong menu gợi ý
return {
    { name = "nvim_lsp", priority = 1000 }, -- Từ LSP (quan trọng nhất)
    { name = "luasnip",  priority = 750 },  -- Từ các đoạn code mẫu (snippets)
    { name = "buffer",   priority = 500 },  -- Từ nội dung trong file hiện tại
    { name = "path",     priority = 250 },  -- Từ đường dẫn thư mục/file
    { name = "nvim_lua", priority = 200 },  -- Gợi ý riêng cho cấu hình Neovim
}
