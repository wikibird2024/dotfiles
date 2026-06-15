return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "gd",          "<cmd>FzfLua lsp_definitions<CR>",    desc = "Definition" },
		{ "gr",          "<cmd>FzfLua lsp_references<CR>",     desc = "References" },
		{ "gi",          "<cmd>FzfLua lsp_implementations<CR>",desc = "Implementation" },
		{ "K",           function() vim.lsp.buf.hover() end,   desc = "Hover" },
		{ "[d",          function() vim.diagnostic.goto_prev() end, desc = "Prev Diagnostic" },
		{ "]d",          function() vim.diagnostic.goto_next() end, desc = "Next Diagnostic" },
		{ "<leader>la",  "<cmd>FzfLua lsp_code_actions<CR>",  desc = "Code Action" },
		{ "<leader>ld",  "<cmd>FzfLua lsp_definitions<CR>",   desc = "Definition" },
		{ "<leader>lr",  function() vim.lsp.buf.rename() end,  desc = "Rename" },
		{ "<leader>lf",  function() require("conform").format({ async = true }) end, desc = "Format" },
		{ "<leader>li",  "<cmd>LspInfo<CR>",                   desc = "LSP Info" },
		{
			"<leader>lh",
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			desc = "Toggle Inlay Hints",
		},
	},
	config = function()
		require("system.constitution.lsp_ui").setup()

		local on_attach    = require("system.runtime.lsp_on_attach").on_attach
		local capabilities = require("system.constitution.lsp_capabilities")

		local servers = { "texlab", "pyright", "clangd" }
		for _, name in ipairs(servers) do
			local ok, server_mod = pcall(require, "system.plugins.lsp.servers." .. name)
			if ok and type(server_mod.setup) == "function" then
				server_mod.setup(on_attach, capabilities)
			else
				vim.lsp.config(name, {
					on_attach    = on_attach,
					capabilities = capabilities,
					root_markers = { ".git", "pyproject.toml", "package.json", "Cargo.toml" },
				})
			end
			vim.lsp.enable(name)
		end
	end,
}
