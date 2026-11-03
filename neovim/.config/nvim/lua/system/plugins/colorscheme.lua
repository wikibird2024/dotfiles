-- =============================================================================
-- ACTIVE THEME — picked by the `theme` command (dotfiles `theme` package), so
-- Neovim matches kitty/alacritty/tmux: it writes a key of the table below to
-- ~/.local/state/theme/current/nvim, optionally with a variant for that
-- theme's setup() ("onedark:warm"). `fallback` is used until a profile is
-- picked. `theme <name>` also sends SIGUSR1, and running Neovims switch live.
-- =============================================================================
local fallback     = "onedark"
local profile_file = (vim.env.XDG_STATE_HOME or vim.fn.expand("~/.local/state")) .. "/theme/current/nvim"

-- "key" or "key:variant" -> key, variant (nil when no profile is picked)
local function profile_theme()
    local f = io.open(profile_file)
    if not f then return nil end
    local line = vim.trim(f:read("*l") or "")
    f:close()
    local key, variant = line:match("^([^:]+):?(.*)$")
    if not key then return nil end
    return key, variant ~= "" and variant or nil
end

-- Neovim sits one step lighter than the terminal, so an editor pane never looks
-- like a shell or Claude pane (theme/README.md). Themes with a lighter variant
-- get it from their profile ("onedark:dark"); for the others this moves every
-- highlight group drawn on the theme's own background to `bg` after it loads.
local function raise_background(pattern, bg)
    vim.api.nvim_create_autocmd("ColorScheme", {
        group    = vim.api.nvim_create_augroup("RaiseBackground_" .. pattern, { clear = true }),
        pattern  = pattern,
        callback = function()
            local base = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            if not base then return end
            local raised = tonumber(bg:sub(2), 16)
            for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
                if hl.bg == base and not hl.link then
                    hl.bg = raised
                    vim.api.nvim_set_hl(0, name, hl)
                end
            end
        end,
    })
end

-- =============================================================================
-- THEME REGISTRY
-- Each entry:
--   plugin  : lazy.nvim plugin spec string
--   setup(variant) : called before vim.cmd.colorscheme() — configure the theme
--                    here; variant is the profile's ":variant" part, or nil
--   name    : optional override for vim.cmd.colorscheme()
-- =============================================================================
local themes = {

    onedark = {
        plugin = "navarasu/onedark.nvim",
        setup  = function(variant)
            require("onedark").setup({
                -- dark | darker | cool | deep | warm | warmer (`ubuntu` profile: darker)
                style         = variant or "darker",
                transparent   = false,
                term_colors   = true,
                ending_tildes = false,
                code_style = {
                    comments  = "italic",
                    keywords  = "none",
                    functions = "none",
                    strings   = "none",
                    variables = "none",
                },
            })
        end,
    },

    abyss = {
        plugin = "barrientosvctor/abyss.nvim",
        setup  = function()
            raise_background("abyss*", "#0b1b2f") -- terminal #000c18
            require("abyss").setup({
                italic_comments        = true,
                italic                 = false,
                bold                   = false,
                transparent_background = false,
                treesitter             = true,
                palette                = "abyss-boreal",  -- abyss | abyss-boreal
            })
            -- which-key text uses Identifier, nearly the float background in abyss.
            -- Not via `overrides`: :colorscheme abyss re-runs setup() with defaults.
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern  = "abyss*",
                once     = true,
                callback = function()
                    vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#6688cc" })
                    -- abyss's color4 is near-black #082050: lualine's NORMAL pill was unreadable.
                    -- #2277ff = color4 in the kitty palette.
                    vim.g.terminal_color_4 = "#2277ff"
                end,
            })
        end,
    },

    -- Moonfly: charcoal black, calm hues that stay readable
    moonfly = {
        plugin = "bluz71/vim-moonfly-colors",
        setup  = function()
            raise_background("moonfly", "#262626") -- terminal #080808; unfocused tmux panes #000000
            vim.g.moonflyItalics        = true
            vim.g.moonflyTerminalColors = true
            vim.g.moonflyTransparent    = false
        end,
    },

    -- Dracula with cream text (the xfce4-terminal text). Keeps Dracula's own
    -- grey-purple background on purpose: the xfce terminal is pure black, so
    -- an editor pane never looks like a shell or Claude pane
    dracula = {
        plugin = "Mofiqul/dracula.nvim",
        setup  = function()
            require("dracula").setup({
                colors = { fg = "#ebdbb2" },
            })
        end,
    },

}

-- =============================================================================
-- BOOTSTRAP
-- Every theme is installed, but only the startup one loads at startup; the
-- rest load on demand when a profile switch asks for them.
-- Never breaks startup: a theme whose plugin is not on disk yet (fresh
-- machine, offline, config copied alone) is replaced by `fallback`, or by
-- Neovim's built-in `builtin`, until lazy.nvim has installed it.
-- =============================================================================
local builtin   = "habamax" -- ships with Neovim, needs no plugin
local lazy_root = vim.fn.stdpath("data") .. "/lazy/"

local function installed(key)
    return vim.uv.fs_stat(lazy_root .. key) ~= nil
end

local function warn(msg)
    vim.notify("colorscheme.lua: " .. msg, vim.log.levels.WARN)
end

local active, active_variant = profile_theme()
if active and not themes[active] then
    -- lazy.nvim may evaluate this spec more than once; warn only the first time
    if not vim.g.theme_unknown_warned then
        vim.g.theme_unknown_warned = true
        warn(("unknown theme %q — check the themes table; using %q"):format(active, fallback))
    end
    active = nil
end
if not active then
    active, active_variant = fallback, nil
end

local function setup(key, variant)
    if type(themes[key].setup) == "function" then
        themes[key].setup(variant)
    end
end

-- Switch to a theme after startup. Any failure keeps the current colors.
local function apply(key, variant)
    if not themes[key] then
        return warn(("unknown theme %q — check the themes table"):format(key))
    end
    if not installed(key) then
        return warn(("theme %q is not installed yet — run :Lazy install"):format(key))
    end
    local ok, err = pcall(function()
        require("lazy").load({ plugins = { key } })
        setup(key, variant) -- again, even if already loaded: the variant may differ
        vim.cmd.colorscheme(themes[key].name or key)
    end)
    if not ok then warn(("theme %q failed: %s"):format(key, err)) end
end

-- The theme the startup spec below applies: the profile's if its plugin is on
-- disk, else fallback's, else none (the built-in one, set right here)
local start = (installed(active) and active) or (installed(fallback) and fallback) or nil
if start ~= active then
    if not start then vim.cmd.colorscheme(builtin) end
    -- lazy.nvim installs missing plugins before VeryLazy; switch then if it could
    vim.api.nvim_create_autocmd("User", {
        pattern  = "VeryLazy",
        once     = true,
        callback = function()
            if installed(active) then apply(active, active_variant) end
        end,
    })
end

vim.api.nvim_create_autocmd("Signal", {
    group    = vim.api.nvim_create_augroup("ThemeProfile", { clear = true }),
    pattern  = "SIGUSR1",
    callback = function()
        vim.schedule(function()
            local key, variant = profile_theme()
            apply(key or fallback, variant)
        end)
    end,
})

local specs = {}
for key, config in pairs(themes) do
    table.insert(specs, {
        config.plugin,
        name     = key,
        priority = 1000,
        lazy     = key ~= start,
        config   = function()
            -- only the startup theme; switches configure themselves in apply()
            if key == start then
                local ok, err = pcall(function()
                    setup(key, key == active and active_variant or nil)
                    vim.cmd.colorscheme(config.name or key)
                end)
                if not ok then
                    warn(("theme %q failed: %s; using %q"):format(key, err, builtin))
                    vim.cmd.colorscheme(builtin)
                end
            end
        end,
    })
end
return specs
