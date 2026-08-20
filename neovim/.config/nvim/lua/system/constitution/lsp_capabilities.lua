local M = {}

-- Merge Neovim's default LSP capabilities with the full set that blink.cmp
-- advertises (resolveSupport, insertReplaceSupport, etc.).
-- blink.cmp must already be installed when this is called.
local function make()
	local base = vim.lsp.protocol.make_client_capabilities()
	local ok, blink = pcall(require, "blink.cmp")
	if ok then
		return vim.tbl_deep_extend("force", base, blink.get_lsp_capabilities())
	end
	-- Fallback: manually ensure snippet support if blink.cmp isn't loaded yet
	base.textDocument.completion.completionItem.snippetSupport = true
	return base
end

-- Lazy-initialise on first access so the capabilities object is always built
-- after all plugins have been set up, avoiding load-order issues.
local _caps = nil
M.get = function()
	if not _caps then _caps = make() end
	return _caps
end

-- Backwards-compat: keep .capabilities for any callers that haven't been updated
M.capabilities = setmetatable({}, {
	__index = function(_, k) return M.get()[k] end,
})

return M