setxkbmap pl
source ~/.screenlayout
setwallpaper

xcompmgr &
pasystray --no-icon-tooltip --include-monitors &
dunst &

while :; do
    ssh-agent dwm
done
