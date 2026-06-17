return {
	"kylechui/nvim-surround",
	version = "*",
	event   = "BufReadPost",
	config = function()
		require("nvim-surround").setup({
			surrounds = {
				["("] = {
					add    = { "( ", " )" },
					find   = "%b()",
					delete = "^(.?)().-(.)()$",
				},
				["{"] = {
					add    = { "{ ", " }" },
					find   = "%b{}",
					delete = "^(.?)().-(.)()$",
				},
				["<"] = {
					add    = { "<", ">" },
					find   = "%b<>",
					delete = "^(.?)().-(.)()$",
				},
				-- ESP32/C logging helper: wrap word as ESP_LOGI(TAG, "...");
				["l"] = {
					add = function()
						return { 'ESP_LOGI(TAG, "', '");' }
					end,
				},
			},
		})
	end,
}