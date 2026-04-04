
-- File: autocommands.lua
-- ======================================================================
-- 🧠 Ginko AutoCommands – Professional Embedded Developer Setup
-- ======================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ╭────────────────────────────────────────────╮
-- │ GENERAL SETTINGS / UI                       │
-- ╰────────────────────────────────────────────╯
local general_grp = augroup("GeneralSettings", { clear = true })

-- Highlight yanked text briefly
autocmd("TextYankPost", {
    group = general_grp,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
    desc = "Highlight text when yanked",
})

-- Trim trailing whitespaces before save
autocmd("BufWritePre", {
    group = general_grp,
    pattern = "*",
    command = [[%s/\s\+$//e]],
    desc = "Trim trailing whitespace on save",
})

-- Enable spellcheck for markdown / text files
autocmd("FileType", {
    group = general_grp,
    pattern = { "markdown", "text" },
    command = "setlocal spell",
    desc = "Enable spellcheck for markdown and text",
})

-- ╭────────────────────────────────────────────╮
-- │ FILETYPE / SYNTAX                           │
-- ╰────────────────────────────────────────────╯
local ft_grp = augroup("FiletypeSettings", { clear = true })

-- Set header files to C by default (can switch to cpp if needed)
autocmd({ "BufRead", "BufNewFile" }, {
    group = ft_grp,
    pattern = "*.h",
    command = "setlocal filetype=c",
    desc = "Set .h files to C filetype",
})

-- ╭────────────────────────────────────────────╮
-- │ TERMINAL / TOGGLETERM                        │
-- ╰────────────────────────────────────────────╯
local term_grp = augroup("TerminalSettings", { clear = true })

-- Start in insert mode for terminals
autocmd("TermOpen", {
    group = term_grp,
    pattern = "*",
    command = "startinsert",
    desc = "Start insert mode in terminal",
})

-- Stop insert mode when leaving terminal buffer
autocmd("BufLeave", {
    group = term_grp,
    pattern = "term://*",
    command = "stopinsert",
    desc = "Stop insert mode when leaving terminal",
})

-- ╭────────────────────────────────────────────╮
-- │ AUTO-RELOAD CONFIG                           │
-- ╰────────────────────────────────────────────╯
local reload_grp = augroup("ReloadConfig", { clear = true })

-- Automatically source Lua config files on save
autocmd("BufWritePost", {
    group = reload_grp,
    pattern = { "**/lua/user/*.lua", "~/.config/nvim/init.lua" },
    callback = function()
        vim.notify("Reloading Neovim config...", vim.log.levels.INFO)
        vim.cmd("source " .. vim.fn.expand("<afile>"))
    end,
    desc = "Auto-source Neovim Lua config on save",
})
