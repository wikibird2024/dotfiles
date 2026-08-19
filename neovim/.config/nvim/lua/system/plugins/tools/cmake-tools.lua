return {
	"Civitasv/cmake-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft   = { "cmake", "c", "cpp" },
	opts = {
		cmake_build_directory      = "build/${variant:buildType}",
		cmake_generate_options     = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
		cmake_build_options        = {},
		cmake_console_size         = 10,
		cmake_console_position     = "bottom",
		cmake_show_console         = "always",
		cmake_notify_enabled       = true,
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
				map("<leader>cg", "<cmd>CMakeGenerate<CR>",          "CMake: Generate"      )
				map("<leader>cb", "<cmd>CMakeBuild<CR>",             "CMake: Build"         )
				map("<leader>cr", "<cmd>CMakeRun<CR>",               "CMake: Run"           )
				map("<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", "CMake: Select Target" )
				map("<leader>cv", "<cmd>CMakeSelectBuildType<CR>",   "CMake: Select Type"   )
				map("<leader>cc", "<cmd>CMakeClean<CR>",             "CMake: Clean"         )
				map("<leader>cx", "<cmd>CMakeStop<CR>",              "CMake: Stop"          )
			end,
		})
	end,
}
