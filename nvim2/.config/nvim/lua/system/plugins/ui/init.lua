-- lua/system/plugins/ui/init.lua
local specs = {}
local scan = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/system/plugins/ui", "*.lua", false, true)

for _, file in ipairs(scan) do
    local name = file:match(".*/([^/]+)%.lua$")
    if name ~= "init" then
        -- SỬA Ở ĐÂY: Không dùng pcall nữa, để nó báo lỗi đỏ nếu không load được
        local mod = require("system.plugins.ui." .. name)
        table.insert(specs, mod)
    end
end

return specs
