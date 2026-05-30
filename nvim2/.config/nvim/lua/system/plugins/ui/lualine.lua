return {
	"nvim-lualine/lualine.nvim",

	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local function lsp()
			local clients = vim.lsp.get_clients({
				bufnr = vim.api.nvim_get_current_buf(),
			})

			if #clients == 0 then
				return "󰅚 No LSP"
			end

			local names = {}

			for _, client in ipairs(clients) do
				if client.name ~= "null-ls" then
					table.insert(names, client.name)
				end
			end

			return "󰒋 " .. table.concat(names, ", ")
		end

		require("lualine").setup({
			options = {
				theme = "auto",

				globalstatus = true,

				component_separators = {
					left = "│",
					right = "│",
				},

				section_separators = {
					left = "",
					right = "",
				},

				disabled_filetypes = {
					statusline = {
						"dashboard",
						"alpha",
						"lazy",
					},
				},
			},

			sections = {
				lualine_a = {
					{
						"mode",
						icon = "",
					},
				},

				lualine_b = {
					{
						"branch",
						icon = "",
					},

					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
					},
				},

				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " ●",
							readonly = " ",
						},
					},
				},

				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
					},

					lsp,

					"filetype",
				},

				lualine_y = {
					"progress",
				},

				lualine_z = {
					{
						"location",
						icon = "󰍍",
					},
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					"location",
				},
				lualine_y = {},
				lualine_z = {},
			},

			extensions = {
				"lazy",
				"mason",
				"quickfix",
				"nvim-tree",
				"toggleterm",
				"fugitive",
			},
		})
	end,
}
