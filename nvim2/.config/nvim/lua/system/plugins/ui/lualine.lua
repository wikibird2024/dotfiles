return {
	"nvim-lualine/lualine.nvim",

	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		---------------------------------------------------------------------------
		-- LSP
		---------------------------------------------------------------------------
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

			if #names == 0 then
				return "󰅚 No LSP"
			end

			-- Avoid statusline overflow
			return "󰒋 " .. names[1]
		end

		require("lualine").setup({
			options = {
				theme = "auto",

				globalstatus = true,

				icons_enabled = true,

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
						"alpha",
						"dashboard",
						"lazy",
					},
				},

				ignore_focus = {
					"NvimTree",
					"toggleterm",
				},

				always_divide_middle = true,
			},

			sections = {
				-----------------------------------------------------------------------
				-- MODE
				-----------------------------------------------------------------------
				lualine_a = {
					{
						"mode",
						icon = "",
					},
				},

				-----------------------------------------------------------------------
				-- GIT
				-----------------------------------------------------------------------
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

				-----------------------------------------------------------------------
				-- FILE
				-----------------------------------------------------------------------
				lualine_c = {
					{
						"filename",
						path = 1,

						file_status = true,
						newfile_status = true,

						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
							newfile = "[New]",
						},

						shorting_target = 40,
					},
				},

				-----------------------------------------------------------------------
				-- DIAGNOSTICS + LSP
				-----------------------------------------------------------------------
				lualine_x = {
					{
						"diagnostics",

						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},

					lsp,

					{
						"filetype",
						icon_only = false,
					},
				},

				-----------------------------------------------------------------------
				-- PROGRESS
				-----------------------------------------------------------------------
				lualine_y = {
					{
						"progress",
					},
				},

				-----------------------------------------------------------------------
				-- CURSOR
				-----------------------------------------------------------------------
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

			tabline = {},

			winbar = {},

			inactive_winbar = {},

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
