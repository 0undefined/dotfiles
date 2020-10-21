systemctl --user import-environment DISPLAY
feh --no-fehbg --bg-scale ~/pictures/background.png
dunst &
xcompmgr &
setxkbmap -option compose:caps &
# Disable mouse acceleration
xset m 0 0 &
xset r rate 300 50 &

exec i3
