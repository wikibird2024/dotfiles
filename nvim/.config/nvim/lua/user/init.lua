
-- ~/.config/nvim/lua/user/init.lua
require("user.core")


-- Dùng Lazy.nvim để setup plugins
require("lazy").setup(require("user.plugins"))
