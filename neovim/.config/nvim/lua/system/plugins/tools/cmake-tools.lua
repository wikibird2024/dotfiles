return {
	"Civitasv/cmake-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft   = { "cmake", "c", "cpp" },
	opts = {
		cmake_build_directory      = "build/${variant:buildType}",
		cmake_generate_options     = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
		cmake_build_options        = {},
		-- Build log streams into quickfix (errors jumpable with ]q / [q); keep it open on success.
		cmake_executor = {
			name = "quickfix",
			opts = { show = "always", position = "belowright", size = 12, auto_close_when_success = false },
		},
		cmake_notifications        = { executor = { enabled = true }, runner = { enabled = true } },
		cmake_virtual_text_support = true,
	},
	config = function(_, opts)
		require("cmake-tools").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern  = { "c", "cpp", "cmake" },
			callback = function(ev)
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
				end
				map("<leader>cg", "<cmd>CMakeGenerate<CR>",               "CMake: Generate"      )
				map("<leader>cb", "<cmd>CMakeBuild<CR>",                  "CMake: Build"         )
				map("<leader>cr", "<cmd>CMakeRun<CR>",                    "CMake: Run"           )
				map("<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>",      "CMake: Select Target" )
				map("<leader>cv", "<cmd>CMakeSelectBuildType<CR>",        "CMake: Select Type"   )
				map("<leader>cp", "<cmd>CMakeSelectConfigurePreset<CR>",  "CMake: Select Preset" )
				map("<leader>cc", "<cmd>CMakeClean<CR>",                  "CMake: Clean"         )
				map("<leader>cx", "<cmd>CMakeStop<CR>",                   "CMake: Stop"          )
				-- Runs the project's .vscode/tasks.json task of this name (same task VS Code uses).
				map("<leader>cf", function() require("overseer").run_task({ name = "Flash (OpenOCD)" }) end, "Flash firmware")
			end,
		})
	end,
}
