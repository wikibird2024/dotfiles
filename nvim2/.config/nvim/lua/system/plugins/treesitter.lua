return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build  = ":TSUpdate",
		lazy   = false, -- the main-branch rewrite explicitly does not support lazy-loading

		config = function()
			local ensure_installed = {
				"c",
				"cpp",
				"rust",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"cmake",
				"markdown",
				"markdown_inline",
				"bash",
				"json",
				"bibtex",
			}
			require("nvim-treesitter").install(ensure_installed)

			local max_filesize = 500 * 1024

			-- The rewrite dropped the old `highlight`/`indent`/`incremental_selection` setup()
			-- keys entirely; highlighting and indent now have to be started per-buffer by hand.
			-- (incremental_selection has no replacement upstream, so it's just gone.)
			vim.api.nvim_create_autocmd("FileType", {
				group    = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
				callback = function(ev)
					local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
					if ok and stat and stat.size > max_filesize then return end

					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
					if not lang then return end

					if not pcall(vim.treesitter.start, ev.buf, lang) then
						-- Parser not installed yet (auto_install replacement): fetch it, then retry.
						-- Only for languages nvim-treesitter actually knows about — plugin UI
						-- filetypes like "lazy"/"lazy_backdrop" aren't real parsers and would
						-- otherwise fail install() loudly enough to trigger a hit-enter prompt.
						if not require("nvim-treesitter.parsers")[lang] then return end

						local install_ok = pcall(function()
							require("nvim-treesitter").install({ lang }):wait(60000)
						end)
						if not install_ok or not pcall(vim.treesitter.start, ev.buf, lang) then
							return
						end
					end

					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch       = "main",
		lazy         = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move   = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move   = require("nvim-treesitter-textobjects.move")
			local swap   = require("nvim-treesitter-textobjects.swap")

			local function map_select(lhs, query)
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end)
			end

			map_select("af", "@function.outer")
			map_select("if", "@function.inner")
			map_select("ac", "@class.outer")
			map_select("ic", "@class.inner")
			map_select("ai", "@conditional.outer")
			map_select("ii", "@conditional.inner")
			map_select("al", "@loop.outer")
			map_select("il", "@loop.inner")

			local function map_move(lhs, fn, query)
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					fn(query, "textobjects")
				end)
			end

			map_move("]f", move.goto_next_start,     "@function.outer")
			map_move("]c", move.goto_next_start,     "@class.outer")
			map_move("[f", move.goto_previous_start, "@function.outer")
			map_move("[c", move.goto_previous_start, "@class.outer")

			vim.keymap.set("n", "<leader>na", function() swap.swap_next("@parameter.inner") end)
			vim.keymap.set("n", "<leader>pa", function() swap.swap_previous("@parameter.inner") end)
		end,
	},
}
