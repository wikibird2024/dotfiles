return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- Enable Treesitter integration
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			enable_moveright = true, -- Jump over closing brackets automatically
			enable_check_bracket_line = true, -- Check brackets on the same line
			map_cr = true, -- Auto-indent on Enter
			map_bs = true, -- Smart backspace
			disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
			fast_wrap = {
				map = "<M-e>", -- Alt + e to wrap current word
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%]%}%,]]=],
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- Custom Mappings
		-- Use Alt + l to escape brackets without conflicts
		vim.keymap.set("i", "<A-l>", "<Right>", { noremap = true, silent = true })

		-- Integration with nvim-cmp
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
