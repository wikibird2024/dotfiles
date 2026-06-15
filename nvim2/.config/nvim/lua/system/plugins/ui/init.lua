local specs = {}
local scan  = vim.fn.globpath(
	vim.fn.stdpath("config") .. "/lua/system/plugins/ui",
	"*.lua", false, true
)

for _, file in ipairs(scan) do
	local name = file:match(".*/([^/]+)%.lua$")
	if name ~= "init" then
		local mod = require("system.plugins.ui." .. name)
		table.insert(specs, mod)
	end
end

return specs
