default: i3gaps

i3gaps: cli_only xorg audio wallpaper i_xorg-xinit\ i3-gaps\ i3lock\ dmenu\ xcompmgr\ ttf-dejavu\ network-manager-applet s_i3gaps i3blocks extensions

dwm: cli_only xorg notifications audio wallpaper i_xorg-xinit\ network-manager-applet\ dmenu\ freetype2\ libx11\ libxft\ libxinerama\ xcompmgr\ ttf-dejavu s_dwm extensions
	@cd submodules/dwm && sudo make clean install

notifications: i_libnotify\ dunst s_notifications

cli_only: base git shell tmux vim neovim st extensions

i3blocks: base i_i3blocks\ acpi s_i3blocks

wallpaper: base xorg i_xwallpaper s_wallpaper

xorg: base i_xorg-server s_xorg

audio: base i_pulseaudio\ pulseaudio-alsa\ pasystray

st: base i_libxext\ libxft\ libxrender\ xorg-fonts-misc\ ncurses\ ttf-liberation
	@cd submodules/st && sudo make clean install && make clean

neovim: base i_ripgrep\ the_silver_searcher\ ptags\ neovim s_neovim
	@nvim +PlugInstall +qall

vim: neovim i_vim s_vim

tmux: base i_xclip\ tmux s_tmux

shell: base i_bash-completion\ fzf s_scripts s_shell

git: base i_diff-so-fancy s_git
	@git config --global user.name "Łukasz Woźniak"
	@git config --global user.email "lukas.wozniak@outlook.com"
	@git config --global pager.diff "diff-so-fancy | less --tabs=4 -RFX"
	@git config --global pager.show "diff-so-fancy | less --tabs=4 -RFX"
	@git config --global credential.helper store
	@git config --global color.diff auto
	@git config --global color.status auto
	@git config --global color.branch auto
	@git config --global color.interactive auto
	@git config --global color.ui auto
	@git config --global color.branch.current "green bold"
	@git config --global color.branch.local "green"
	@git config --global color.branch.remote "red bold"
	@git config --global color.diff.meta "yellow bold"
	@git config --global color.diff.frag "magenta bold"
	@git config --global color.diff.old "red bold"
	@git config --global color.diff.new "green bold"
	@git config --global color.status.added "green bold"
	@git config --global color.status.changed "yellow bold"
	@git config --global color.status.untracked "red"
	@git config --global color.sh.branch "yellow"
	@git config --global push.default "current"
	@git config --global branch.autosetuprebase "always"
	@git config --global diff.renames "copies"
	@git config --global diff.mnemonicprefix "true"
	@git config --global diff.compactionHeuristic "true"
	@git config --global difftool.prompt "false"
	@git config --global apply.whitespace "nowarn"
	@git config --global core.excludesfile "~/.gitignore_global"
	@git config --global core.editor "vim"

extensions: base s_extensions
	@for d in $${HOME}/.dotfiles_ext/*; \
	do								    \
		make --directory=$$d;           \
	done

base:
	@sudo pacman -S base-devel git stow curl wget --noconfirm --needed
	@git submodule update --init --recursive --remote
	@cd submodules/yay && makepkg -si --noconfirm --needed

include common.mk
