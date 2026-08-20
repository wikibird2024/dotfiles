-- Minimap sidebar. Chosen over gorbit99/codewindow.nvim, which depends on
-- the legacy nvim-treesitter.ts_utils module removed by the modern
-- nvim-treesitter "main" rewrite this config uses (treesitter.lua).
return {
	"nvim-mini/mini.map",
	version = false,
	event   = "BufReadPost",
	config  = function()
		local map = require("mini.map")
		map.setup({
			integrations = {
				map.gen_integration.diagnostic(),
				map.gen_integration.gitsigns(),
			},
			symbols = {
				encode = map.gen_encode_symbols.dot("4x2"),
			},
			window = {
				width    = 10,
				winblend = 25,
			},
		})
	end,
	keys = {
		{ "<leader>uM", function() require("mini.map").toggle() end, desc = "Toggle Minimap" },
	},
}
