return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		},
		config = function()
			local cmp     = require("cmp")
			local luasnip = require("luasnip")
			local border  = "rounded"

			local ok, custom_sources = pcall(require, "system.constitution.cmp_sources")
			local sources = (ok and type(custom_sources) == "table") and custom_sources or {
				{ name = "nvim_lsp" },
				{ name = "luasnip"  },
				{ name = "buffer"   },
				{ name = "path"     },
			}

			local bordered = cmp.config.window.bordered({
				border       = border,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			})

			cmp.setup({
				snippet = {
					expand = function(args) luasnip.lsp_expand(args.body) end,
				},
				window = {
					completion    = bordered,
					documentation = bordered,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"]     = cmp.mapping.select_next_item(),
					["<C-k>"]     = cmp.mapping.select_prev_item(),
					-- Unified Tab: luasnip jump takes priority, else cmp confirm, else raw Tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ select = false })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"]     = cmp.mapping.abort(),
					["<C-d>"]     = cmp.mapping.scroll_docs(4),
					["<C-u>"]     = cmp.mapping.scroll_docs(-4),
				}),
				sources = cmp.config.sources(sources),
			})

			-- Enhanced completion for / search — searches current buffer
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Enhanced completion for : commands — file paths + vim commands
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources(
					{ { name = "path" } },
					{ { name = "cmdline" } }
				),
			})
		end,
	},
}