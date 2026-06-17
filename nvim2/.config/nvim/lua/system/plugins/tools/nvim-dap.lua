return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{ "<leader>dc",  function() require("dap").continue() end,                                                desc = "Debug: Continue" },
			{ "<leader>dt",  function() require("dap").terminate() end,                                               desc = "Debug: Terminate" },
			{ "<leader>dr",  function()
				local dap = require("dap")
				if not pcall(dap.restart) then dap.terminate(); vim.defer_fn(dap.continue, 150) end
			end,                                                                                                      desc = "Debug: Restart" },
			{ "<leader>ds",  function() require("dap").step_over() end,                                               desc = "Step Over" },
			{ "<leader>di",  function() require("dap").step_into() end,                                               desc = "Step Into" },
			{ "<leader>do",  function() require("dap").step_out() end,                                                desc = "Step Out" },
			{ "<leader>drt", function() require("dap").run_to_cursor() end,                                           desc = "Run to Cursor" },
			{ "<leader>db",  function() require("dap").toggle_breakpoint() end,                                       desc = "Breakpoint: Toggle" },
			{ "<leader>dB",  function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,               desc = "Breakpoint: Condition" },
			{ "<leader>dl",  function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log: ")) end,           desc = "Log Point" },
			{ "<leader>dh",  function() require("dap.ui.widgets").hover() end,                                        desc = "Debugger Hover" },
			{ "<leader>de",  function() require("dapui").eval() end,                mode = { "n", "v" },              desc = "Evaluate Expression" },
			{ "<leader>du",  function() require("dapui").toggle() end,                                                desc = "Toggle Debug UI" },
			{ "<F5>",        function() require("dap").continue() end,                                                desc = "Debug: Continue" },
			{ "<F10>",       function() require("dap").step_over() end,                                               desc = "Debug: Step Over" },
			{ "<F11>",       function() require("dap").step_into() end,                                               desc = "Debug: Step Into" },
			{ "<F12>",       function() require("dap").step_out() end,                                                desc = "Debug: Step Out" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("nvim-dap-virtual-text").setup({ commented = true })

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.35 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			-- Automation hooks
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- =====================================================================
			-- EMBEDDED C/C++ CONFIGURATION (Native DAP Engine)
			-- =====================================================================
			dap.adapters.gdb = {
				type = "executable",
				command = "arm-none-eabi-gdb",
				args = { "-i", "dap" }, -- Native modern DAP protocol engine
			}

			local function smart_firmware_picker()
				local fn = vim.fn
				local files = fn.glob(fn.getcwd() .. "/**/*.axf", true, true)
				local elfs = fn.glob(fn.getcwd() .. "/**/*.elf", true, true)
				for _, v in ipairs(elfs) do
					table.insert(files, v)
				end

				if #files == 0 then
					return fn.input("Path to binary file: ", fn.getcwd() .. "/", "file")
				elseif #files == 1 then
					return files[1]
				else
					local choices = { "Select target binary to flash/debug:" }
					for i, f in ipairs(files) do
						table.insert(choices, string.format("%d: %s", i, fn.fnamemodify(f, ":.")))
					end
					local choice = fn.inputlist(choices)
					if choice > 0 and choice <= #files then
						return files[choice]
					end
				end
			end

			dap.configurations.c = {
				{
					name = "Embedded Firmware (OpenOCD Target)",
					type = "gdb",
					request = "launch",
					program = smart_firmware_picker,
					cwd = "${workspaceFolder}",
					target = "localhost:3333",
					remote = true,
					setupCommands = {
						{ text = "file", description = "Load symbols", ignoreFailures = false },
						{
							text = "target remote localhost:3333",
							description = "Connect OpenOCD",
							ignoreFailures = false,
						},
						{
							text = "monitor reset halt",
							description = "Halt core at entry reset vectors",
							ignoreFailures = true,
						},
					},
					stopAtBeginningOfMainSubprogram = true,
				},
			}
			dap.configurations.cpp = dap.configurations.c

			-- =====================================================================
			-- NATIVE HOST RUST CONFIGURATION (codelldb Engine)
			-- =====================================================================
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Native Rust Debug (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						local bin = vim.fn.fnamemodify(cwd, ":t")
						local path = cwd .. "/target/debug/" .. bin
						if vim.fn.filereadable(path) == 1 then
							return path
						end

						local matches = vim.fn.glob(cwd .. "/target/debug/*", 0, 1)
						for _, file in ipairs(matches) do
							if vim.fn.executable(file) == 1 then
								return file
							end
						end
						return vim.fn.input("Binary path: ", cwd .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- =====================================================================
			-- PYTHON CONFIGURATION (debugpy)
			-- =====================================================================
			require("dap-python").setup(vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or vim.fn.exepath("python"))
			-- pytest support
			require("dap-python").test_runner = "pytest"

			-- =====================================================================
			-- SIGN LUMINESCENCE DEFINITIONS
			-- =====================================================================
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🛑", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "🔍", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "➔", texthl = "DiagnosticSignHint", linehl = "Visual", numhl = "DiagnosticSignHint" }
			)
			vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "Comment", linehl = "", numhl = "" })
		end,
	},
}
