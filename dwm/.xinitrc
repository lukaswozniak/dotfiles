setxkbmap pl
source ~/.screenlayout
setwallpaper

xcompmgr &
pasystray --no-icon-tooltip --include-monitors &
nm-applet &
dunst &

exec dwm
