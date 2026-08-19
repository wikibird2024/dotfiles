local M = {}

-- Merge Neovim's default LSP capabilities with the full set that nvim-cmp
-- advertises (resolveSupport, insertReplaceSupport, etc.).
-- cmp_nvim_lsp must already be installed when this is called.
local function make()
	local base = vim.lsp.protocol.make_client_capabilities()
	local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		return vim.tbl_deep_extend("force", base, cmp_lsp.default_capabilities())
	end
	-- Fallback: manually ensure snippet support if cmp_nvim_lsp isn't loaded yet
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