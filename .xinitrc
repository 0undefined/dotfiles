# For automatic lock on suspend/hibernation
systemctl --user import-environment DISPLAY
# Notification daemon
dunst &
# Composite manager, for blur and other neat effects
picom --blur-method dual_kawase --blur-strength 2 --experimental-backends --backend glx &

# Disable mouse acceleration
xset m 0 0 &
xset r rate 300 50 &

xmodmap -e "clear lock"
xmodmap -e "keysym Multi_key = Multi_key Caps_Lock"
xmodmap -e "keycode 9 = Multi_key"
xmodmap -e "keycode 108 = Multi_key"
xmodmap -e "keycode 66 = Escape"

autorandr -c

feh --no-fehbg --bg-scale ~/pictures/background.png
dwmblocks &
exec /usr/local/bin/dwm
