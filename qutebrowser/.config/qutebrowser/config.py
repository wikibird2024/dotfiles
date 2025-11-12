
# =============================
# Qutebrowser Config (System Font Safe)
# =============================

# Disable autoconfig to fully control from config.py
config.load_autoconfig(False)

# =============================
# UI & Fonts (System Defaults)
# =============================
c.zoom.default = "85%"  # Auto-fit web content

# Dùng font hệ thống — Qt sẽ tự nhận các font mặc định như Noto, DejaVu, hoặc Ubuntu tùy distro
c.fonts.default_family = "default"
c.fonts.default_size = "10pt"

# Web content fonts (fallback an toàn)
c.fonts.web.family.standard = "sans-serif"
c.fonts.web.family.serif = "serif"
c.fonts.web.family.sans_serif = "sans-serif"
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.cursive = "sans-serif"
c.fonts.web.family.fantasy = "sans-serif"

# =============================
# Completion menu (dark theme)
# =============================
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

# =============================
# Dark mode for webpages
# =============================
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

# User agent for desktop compatibility
c.content.headers.user_agent = (
    "Mozilla/5.0 (X11; Linux x86_64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/120 Safari/537.36"
)

# Enable WebGL & media capture
c.content.webgl = True
c.content.media.audio_capture = True
c.content.media.video_capture = True

# Enable adblock (both hosts + lists)
c.content.blocking.method = "both"

# =============================
# Downloads
# =============================
c.downloads.location.directory = "~/Downloads"
c.downloads.remove_finished = 5000  # Remove after 5s
c.downloads.position = "bottom"
# =============================
# Keybindings (Vim-style)
# =============================

# ----- Tab navigation -----
config.bind("J", "tab-prev")           # Move to previous tab
config.bind("K", "tab-next")           # Move to next tab
config.bind("g0", "tab-focus 0")       # Focus first tab
config.bind("g$", "tab-focus -1")      # Focus last tab
config.bind("d", "tab-close")          # Close current tab
config.bind("u", "undo")               # Reopen last closed tab
config.bind("tn", "open -t about:blank")  # Open new blank tab
config.bind("xo", "set-cmd-text -s :open -t")  # Open new tab with URL
config.bind("p", "open -t")            # Prompt to open new tab

# ----- Page navigation -----
config.bind("H", "back")               # Go back in history
config.bind("L", "forward")            # Go forward in history
config.bind("r", "reload")             # Reload current page

# ----- Links & clipboard -----
config.bind("f", "hint links")         # Follow link
config.bind("F", "hint links tab")     # Open link in new tab
config.bind("yy", "yank url")          # Copy current URL
config.bind("gp", "open -t {clipboard}")  # Open URL from clipboard

# ----- Zoom -----
config.bind("zi", "zoom-in")           # Zoom in
config.bind("zo", "zoom-out")          # Zoom out
config.bind("zr", "zoom-reset")        # Reset zoom

# ----- Bookmarks -----
config.bind("b", "bookmark-add")       # Add bookmark
config.bind("B", "bookmark-load")      # Load bookmark

# ----- Editing -----
config.bind("ge", "edit-text")         # Edit textarea externally

# ----- Config & commands -----
config.bind("X", "config-source")      # Reload configuration

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
    "ppx": "https://www.perplexity.ai/search?q={}",
    "ph": "https://www.phind.com/search?q={}",
    "cop": "https://www.bing.com/search?q={}",
    "gpt": "https://chat.openai.com/?q={}",  # mở ChatGPT thẳng
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
