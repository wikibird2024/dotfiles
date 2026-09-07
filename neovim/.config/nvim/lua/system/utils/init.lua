local M = {}

M.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then options = vim.tbl_extend("force", options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Relative luminance (WCAG formula) of a "#rrggbb" hex color, 0 (black) to 1 (white).
-- Used to decide whether a background is light or dark.
M.hex_luminance = function(hex)
	if not hex then return 0 end
	local function channel(c)
		c = c / 255
		return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
	end
	local r = tonumber(hex:sub(2, 3), 16)
	local g = tonumber(hex:sub(4, 5), 16)
	local b = tonumber(hex:sub(6, 7), 16)
	if not (r and g and b) then return 0 end
	return 0.2126 * channel(r) + 0.7152 * channel(g) + 0.0722 * channel(b)
end

-- Shift a "#rrggbb" hex color toward white (amount > 0) or black (amount < 0).
-- amount is a fraction of the remaining distance to white/black, e.g. 0.2 = 20% closer.
M.blend_hex = function(hex, amount)
	local r = tonumber(hex:sub(2, 3), 16)
	local g = tonumber(hex:sub(4, 5), 16)
	local b = tonumber(hex:sub(6, 7), 16)
	if not (r and g and b) then return hex end
	local target = amount > 0 and 255 or 0
	local t = math.abs(amount)
	local function shift(c) return math.floor(c + (target - c) * t + 0.5) end
	return string.format("#%02x%02x%02x", shift(r), shift(g), shift(b))
end

return M
