-- Load core settings before plugins
require("system.kernel.options")
require("system.kernel.keymap")
require("system.kernel.autocommands")

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec     = { { import = "system.plugins" } },
	defaults = { lazy = true },
	ui       = { border = "rounded" },
})
