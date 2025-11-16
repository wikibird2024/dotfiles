
#!/usr/bin/env bash
# ==============================================================
# smart_launch.sh – Simple i3 launcher
# Focus if running, otherwise launch.
# ==============================================================

APP="$1"

# --- Class name map (đảm bảo chính xác với xprop | grep CLASS) ---
case "$APP" in
  firefox)
    CLASS="firefox"
    CMD="firefox"
    ;;
  google-chrome|chrome)
    CLASS="google-chrome"
    CMD="google-chrome"
    ;;
  qutebrowser|qute)
    CLASS="qutebrowser"
    CMD="qutebrowser"
    ;;
  alacritty|terminal)
    CLASS="Alacritty"
    CMD="alacritty"
    ;;
  telegram-desktop|tg)
    CLASS="TelegramDesktop"
    CMD="telegram-desktop"
    ;;
  *)
    notify-send "smart_launch" "Unknown app: $APP"
    exit 1
    ;;
esac

# --- Nếu cửa sổ đang chạy, focus vào ---
if i3-msg -t get_tree | grep -q "\"class\":\"$CLASS\""; then
  i3-msg "[class=\"$CLASS\"] focus" >/dev/null
else
  # --- Nếu chưa có, mở app ---
  nohup $CMD >/dev/null 2>&1 &
fi
