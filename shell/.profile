export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
for ext in $HOME/.dotfiles_ext/*/.scripts
do
    [ -d "$ext" ] || continue
    export PATH="$PATH:$(du "$ext" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
done

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="google-chrome-stable"
export XDG_CONFIG_HOME="$HOME/.config"
export PKG_CONFIG_PATH=/usr/share/pkgconfig:$PKG_CONFIG_PATH

# set colors
dark0_hard="#1D2021"
dark0="#282828"
dark0_soft="#32302F"
dark1="#3c3836"
dark2="#504945"
dark3="#665c54"
dark4="#7C6F64"

gray_245="#928374"
gray_244="#928374"

light0_hard="#FB4934"
light0="#FBF1C7"
light0_soft="#F2E5BC"
light1="#EBDBB2"
light2="#D5C4A1"
light3="#BDAE93"
light4="#A89984"

bright_red="#FB4934"
bright_green="#B8BB26"
bright_yellow="#FABD2F"
bright_blue="#83A598"
bright_purple="#D3869B"
bright_aqua="#8EC07C"
bright_orange="#FE8019"

neutral_red="#CC241D"
neutral_green="#98971A"
neutral_yellow="#D79921"
neutral_blue="#458588"
neutral_purple="#B16286"
neutral_aqua="#689D6A"
neutral_orange="#D65D0E"

faded_red="#9D0006"
faded_green="#79740E"
faded_yellow="#B57614"
faded_blue="#076678"
faded_purple="#8F3F71"
faded_aqua="#427B58"
faded_orange="#AF3A03"

source source_extensions .profile

# Start graphical server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && command -v i3 && ! pgrep -x i3 >/dev/null && exec startx
