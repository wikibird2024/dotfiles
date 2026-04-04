vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- init.lua
-- Load Core Engine
require("system.kernel.init")       -- options, autocommands, keynames

-- Load Plugins
require("system.plugins.init")      -- tất cả plugin setup

-- Load Runtime logic
require("system.runtime.lsp_on_attach")  -- LSP on_attach

