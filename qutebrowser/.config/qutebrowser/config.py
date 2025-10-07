
# =============================
# Qutebrowser Config (Full-Feature)
# =============================

# Disable autoconfig to fully control from config.py
config.load_autoconfig(False)

# =============================
# UI & Fonts
# =============================
c.zoom.default = "85%"  # Auto-fit web content
c.fonts.default_family = "Merriweather"
c.fonts.default_size = "10pt"

# Web content fonts
c.fonts.web.family.standard = "Merriweather"
c.fonts.web.family.serif = "Merriweather"
c.fonts.web.family.sans_serif = "Open Sans"
c.fonts.web.family.fixed = "Fira Code"

# Completion menu (dark theme)
c.colors.completion.fg = "#ffffff"
c.colors.completion.even.bg = "#1c1c1c"
c.colors.completion.odd.bg = "#1c1c1c"
c.colors.completion.category.fg = "#ffcc00"
c.colors.completion.category.bg = "#1c1c1c"
c.colors.completion.category.border.top = "#1c1c1c"
c.colors.completion.category.border.bottom = "#1c1c1c"
c.colors.completion.item.selected.fg = "#ffffff"
c.colors.completion.item.selected.bg = "#444444"
c.colors.completion.item.selected.border.top = "#444444"
c.colors.completion.item.selected.border.bottom = "#444444"
c.colors.completion.match.fg = "#ffcc00"

# Dark mode for webpages
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.bg = "#1e1e1e"

# =============================
# Default Pages & Session
# =============================
c.url.default_page = "https://duckduckgo.com"
c.url.start_pages = ["https://duckduckgo.com"]
c.auto_save.session = True

# =============================
# Privacy & Security
# =============================
c.content.cookies.accept = "no-3rdparty"
c.content.javascript.enabled = True
c.content.javascript.can_open_tabs_automatically = True

# Desktop user agent for compatibility
c.content.headers.user_agent = (
    "Mozilla/5.0 (X11; Linux x86_64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/120 Safari/537.36"
)

# Enable WebGL & media capture
c.content.webgl = True
c.content.media.audio_capture = True
c.content.media.video_capture = True

# Enable adblock (basic)
c.content.blocking.method = "both"  # uses hosts + adblock lists

# =============================
# Downloads
# =============================
c.downloads.location.directory = "~/Downloads"
c.downloads.remove_finished = 5000  # Remove after 5s
c.downloads.position = "bottom"

# =============================
# Keybindings (Vim-style)
# =============================
config.bind("J", "tab-prev")         # Previous tab
config.bind("K", "tab-next")         # Next tab
config.bind("d", "tab-close")        # Close tab
config.bind("u", "undo")             # Reopen closed tab
config.bind("xo", "set-cmd-text -s :open -t")  # Open new tab with URL
config.bind("X", "config-source")    # Reload config quickly
config.bind("f", "hint links")       # Follow link
config.bind("F", "hint links tab")   # Open link in new tab
config.bind("yy", "yank url")        # Copy current URL
config.bind("p", "open -t")          # Open prompt for new tab
config.bind("ge", "edit-text")       # Edit textarea with external editor

# =============================
# External Editor
# =============================
c.editor.command = ["nvim", "{}"]

# =============================
# Search Engines
# =============================
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gg": "https://www.google.com/search?q={}",
    "gh": "https://github.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "rd": "https://www.reddit.com/search/?q={}",
    "so": "https://stackoverflow.com/search?q={}",
    "gem": "https://gemini.google.com/app?q={}",
}

# =============================
# Tabs
# =============================
c.tabs.position = "top"
c.tabs.show = "multiple"
c.tabs.last_close = "default-page"

# =============================
# Hints
# =============================
c.hints.border = "1px solid #ffcc00"
c.hints.chars = "asdfghjkl"

# =============================
# Misc / Performance
# =============================
c.content.geolocation = False
c.content.autoplay = False
c.scrolling.smooth = True
c.auto_save.interval = 1500  # autosave every 1.5s
