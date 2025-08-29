
# =============================
# Qutebrowser Config (Single File)
# =============================

# Disable autoconfig.yml to take full control from config.py
config.load_autoconfig(False)

# =============================
# UI Settings
# =============================
# =============================
# Fonts
# =============================
# Auto-fit web content to window width
c.zoom.default = "85%"

# UI & default font
c.fonts.default_family = "Merriweather"    # Thanh lịch, rõ nét trên TN-HD
c.fonts.default_size = "10pt"

# Web content fonts
c.fonts.web.family.standard = "Merriweather"  # Text chuẩn, dễ đọc
c.fonts.web.family.serif    = "Merriweather"  # Paragraph / header serif
c.fonts.web.family.sans_serif = "Open Sans"   # Menu, buttons, navigation
c.fonts.web.family.fixed    = "Fira Code"     # Monospace / code

# Completion menu colors (dark theme)
c.colors.completion.fg = "#ffffff"                       # Text của tất cả items
c.colors.completion.even.bg = "#1c1c1c"                 # Background cho even items
c.colors.completion.odd.bg = "#1c1c1c"                  # Background cho odd items
c.colors.completion.category.fg = "#ffcc00"             # Tên category
c.colors.completion.category.bg = "#1c1c1c"             # Background category
c.colors.completion.category.border.top = "#1c1c1c"     # Border trên category
c.colors.completion.category.border.bottom = "#1c1c1c"  # Border dưới category
c.colors.completion.item.selected.fg = "#ffffff"        # Selected item text
c.colors.completion.item.selected.bg = "#444444"        # Selected item background
c.colors.completion.item.selected.border.top = "#444444"
c.colors.completion.item.selected.border.bottom = "#444444"
c.colors.completion.match.fg = "#ffcc00"                # Highlight match

# =============================
# Default Pages
# =============================
c.url.default_page = "https://duckduckgo.com"
c.url.start_pages = ["https://duckduckgo.com"]

# =============================
# Privacy & Security
# =============================
# Block 3rd party cookies
c.content.cookies.accept = "no-3rdparty"

# Keep JavaScript enabled (needed for modern sites)
c.content.javascript.enabled = True

# Custom user agent (optional, helps with compatibility)
c.content.headers.user_agent = (
    "Mozilla/5.0 (X11; Linux x86_64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/120 Safari/537.36"
)

# =============================
# Keybindings (Vim-style)
# =============================
config.bind("J", "tab-prev")         # Previous tab
config.bind("K", "tab-next")         # Next tab
config.bind("d", "tab-close")        # Close tab
config.bind("u", "undo")             # Reopen closed tab
config.bind("xo", "set-cmd-text -s :open -t")  # Open new tab with URL

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
