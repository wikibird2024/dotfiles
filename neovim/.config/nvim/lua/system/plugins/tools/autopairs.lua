return {
	"windwp/nvim-autopairs",
	event        = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts  = true,
			ts_config = {
				lua        = { "string", "source" },
				javascript = { "string", "template_string" },
				java       = false,
			},
			enable_moveright          = true,
			enable_check_bracket_line = true,
			map_cr = true,
			map_bs = true,
			disable_filetype = { "fzf", "vim", "NvimTree", "neo-tree", "undotree", "toggleterm" },
			fast_wrap = {
				map             = "<M-e>",
				chars           = { "{", "[", "(", '"', "'" },
				pattern         = [=[[%'%"%)%>%]%]%}%,]]=],
				offset          = 0,
				end_key         = "$",
				keys            = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma     = true,
				highlight       = "Search",
				highlight_grey  = "Comment",
			},
		})

		-- Auto-insert () after selecting a function from the completion menu
		local ok, cmp = pcall(require, "cmp")
		if ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
