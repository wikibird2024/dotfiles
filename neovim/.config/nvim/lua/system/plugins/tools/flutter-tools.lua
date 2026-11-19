-- Flutter / Dart: starts dartls (the Dart LSP from the Flutter SDK), runs the
-- app with hot reload, shows the device log, and sets up nvim-dap for Dart.
-- dartls is owned here, so it is NOT in lsp/init.lua's server list.
-- The flutter binary comes from PATH (bash/.bashrc adds $FLUTTER_SDK_ROOT).
return {
	"nvim-flutter/flutter-tools.nvim",
	ft           = "dart",
	dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
	keys = {
		{ "<leader>Fr", "<cmd>FlutterRun<CR>",           desc = "Flutter: Run" },
		{ "<leader>Fd", "<cmd>FlutterDevices<CR>",       desc = "Flutter: Devices" },
		{ "<leader>Fe", "<cmd>FlutterEmulators<CR>",     desc = "Flutter: Emulators" },
		{ "<leader>Fh", "<cmd>FlutterReload<CR>",        desc = "Flutter: Hot Reload" },
		{ "<leader>FR", "<cmd>FlutterRestart<CR>",       desc = "Flutter: Hot Restart" },
		{ "<leader>Fq", "<cmd>FlutterQuit<CR>",          desc = "Flutter: Quit" },
		{ "<leader>Fl", "<cmd>FlutterLogToggle<CR>",     desc = "Flutter: Toggle Log" },
		{ "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", desc = "Flutter: Widget Outline" },
		{ "<leader>Fp", "<cmd>FlutterPubGet<CR>",        desc = "Flutter: Pub Get" },
		{ "<leader>Fc", "<cmd>FlutterCommands<CR>",      desc = "Flutter: All Commands" },
	},
	config = function()
		require("flutter-tools").setup({
			ui = { border = "rounded" },
			debugger = { enabled = true }, -- :FlutterRun starts under nvim-dap (breakpoints work)
			widget_guides = { enabled = true },
			dev_log = {
				open_cmd      = "botright 15split",
				focus_on_open = false,
			},
			lsp = {
				-- on_attach comes from the global LspAttach autocmd in lsp/init.lua
				capabilities = require("system.constitution.lsp_capabilities").get(),
				settings = {
					showTodos              = true,
					completeFunctionCalls  = true,
					renameFilesWithClasses = "prompt",
					updateImportsOnRename  = true,
				},
			},
		})
	end,
}
