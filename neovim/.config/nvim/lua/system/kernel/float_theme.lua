-- NormalFloat/FloatBorder are the shared highlight groups every floating
-- window in this config uses (hover, signature, blink.cmp menu, glance,
-- noice, dap-ui, snacks input, which-key, mason, ...). Some themes leave
-- these too close to Normal to read comfortably, so strengthen them once,
-- here, globally -- individual plugins should NOT override these
-- themselves; keeping one source of truth is what keeps popups looking
-- consistent and this easy to maintain.
--
-- This must run eagerly, right after the colorscheme is applied, NOT from
-- inside any lazy-loaded plugin's config function -- popups can appear
-- before any file is opened (dashboard, which-key, :Mason), and a fix tied
-- to e.g. nvim-lspconfig's BufReadPre trigger simply hasn't run yet at that
-- point. Called directly from kernel/init.lua after require("lazy").setup().
local M = {}

function M.setup()
	local utils = require("system.utils")

	local function strengthen_floats()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
		if not normal.bg then return end
		local normal_bg = string.format("#%06x", normal.bg)

		local is_light  = utils.hex_luminance(normal_bg) > 0.18
		local direction = is_light and -1 or 1
		local float_bg  = utils.blend_hex(normal_bg, 0.30 * direction)
		local border_fg = utils.blend_hex(normal_bg, 0.45 * direction)

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg, fg = border_fg })
	end

	strengthen_floats()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group    = vim.api.nvim_create_augroup("StrengthenFloatContrast", { clear = true }),
		callback = strengthen_floats,
	})
end

return M
