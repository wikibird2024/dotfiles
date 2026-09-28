-- Keep Neovim's background solid while the terminal around it is see-through.
--
-- kitty (background_opacity < 1) draws a cell see-through when its color
-- EQUALS the terminal background -- it compares the color, not who set it.
-- Most themes paint Normal with exactly the color of their terminal palette
-- (theme profiles), so the whole code area turned see-through and was hard
-- to read, while the shell prompt should stay see-through.
--
-- Fix, in one place for every theme: after any colorscheme loads, move the
-- background of Normal, and of every group with that same background, by one
-- shade (#1f2329 -> #1f232a). Nobody can see the difference; kitty then draws
-- it solid. Groups linked to Normal follow it on their own.
--
-- Called from kernel/init.lua right after the colorscheme is applied and
-- before float_theme, so the float colors are derived from the moved color.
-- To turn it off (see-through Neovim), remove that call.
local M = {}

-- one shade away in the blue channel; down when blue is already at max
local function next_shade(color)
	if color % 0x100 == 0xff then
		return color - 1
	end
	return color + 1
end

local function move_background()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	-- transparent theme: nothing to do
	if not normal.bg then
		return
	end

	local old_bg = normal.bg
	local new_bg = next_shade(old_bg)
	for name, group in pairs(vim.api.nvim_get_hl(0, {})) do
		if not group.link and group.bg == old_bg then
			group.bg = new_bg
			vim.api.nvim_set_hl(0, name, group)
		end
	end
end

function M.setup()
	move_background()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("SolidBackground", { clear = true }),
		callback = move_background,
	})
end

return M
