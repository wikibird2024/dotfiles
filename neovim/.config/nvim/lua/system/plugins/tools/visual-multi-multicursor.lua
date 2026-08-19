return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		-- <C-Up>/<C-Down> are already bound to window resize in kernel/keymap.lua
		vim.g.VM_maps = {
			["Add Cursor Down"] = "<M-j>",
			["Add Cursor Up"]   = "<M-k>",
		}
	end,

}
