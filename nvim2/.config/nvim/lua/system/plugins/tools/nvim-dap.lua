return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Cấu hình DAP UI
		dapui.setup()

		-- Virtual text
		require("nvim-dap-virtual-text").setup()

		-- Adapter C/C++ (GDB) + Rust (LLDB)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb", -- hoặc arm-none-eabi-gdb cho Embedded
			args = { "-i", "mi" },
		}

		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-vscode", -- hoặc "rust-lldb" cho Rust
			name = "lldb",
		}

		-- Configurations
		dap.configurations.c = {
			{
				name = "Launch (Embedded GDB)",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}

		dap.configurations.cpp = dap.configurations.c -- C++ dùng chung với C

		dap.configurations.rust = {
			{
				name = "Debug Rust",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {}, -- Thêm argument nếu cần
			},
		}

		-- Auto open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Plugin-local keymap cho toggle UI
		vim.keymap.set("n", "<leader>du", function()
			dapui.toggle()
		end, { desc = "Debug: Toggle UI" })
	end,
}
