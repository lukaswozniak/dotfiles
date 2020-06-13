
PWD = $(shell pwd)

default: arch

arch: install_arch configure

debian: install_debian configure

configure:
	@mkdir -p ~/.config
	@mkdir -p ~/.vim-tmp
	@mkdir -p ~/.vim-undo
	@mkdir -p ~/.tmp
	@make git stow_neovim stow_vim stow_tmux stow_scripts stow_shell
	@nvim +PlugInstall +qall
	@make make_extensions_configure

install_arch: install_common
	@sudo pacman -S stow git diff-so-fancy bash-completion fzf tmux vim neovim the_silver_searcher xclip openssh --noconfirm --needed
	@make make_extensions_install_arch

install_debian: install_common
	@sudo apt install stow git bash-completion tmux vim neovim silversearcher-ag xclip wget curl -y
	@git submodule update --init --remote submodules/diff-so-fancy submodules/fzf
	@sudo ln -sf $(PWD)/submodules/diff-so-fancy/diff-so-fancy /usr/local/bin/
	@./submodules/fzf/install --all
	@make make_extensions_install_debian

install_common:
	@git submodule update --init --remote submodules/tmux-sensible

git: stow_git
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
	@git config --global rerere.enabled "true"

i3wm_arch: install_i3wm_arch stow_i3wm st

install_i3wm_arch: xorg_arch fonts_arch yay
	@sudo pacman -S i3-gaps xss-lock i3lock xcompmgr dmenu network-manager-applet pulseaudio pulseaudio-alsa pavucontrol playerctl dbus python-dbus xwallpaper flameshot --noconfirm --needed
	@sudo pacman -S ttf-inconsolata ttf-linux-libertine noto-fonts-emoji --noconfirm --needed
	@yay -S nerd-fonts-inconsolata --noconfirm --needed
	@yay -S polybar --noconfirm --needed

dwm_arch: xorg_arch st stow_dwm sxhkd_arch
	@sudo pacman -S ttf-liberation dmenu freetype2 libx11 libxft libxinerama xorg-setxkbmap --noconfirm --needed
	@git submodule update --init --remote submodules/dwm
	@cd submodules/dwm && make install

sxhkd_arch: stow_sxhkd
	@sudo pacman -S sxhkd playerctl pulseaudio pulseaudio-alsa --noconfirm --needed

xorg_arch:
	@sudo pacman -S xorg-server xorg-xwininfo xorg-xinit xorg-xrandr xdotool --noconfirm --needed

st:
	@git submodule update --init --remote submodules/st
	@cd submodules/st && sudo make install

yay:
	@git submodule update --init --remote submodules/yay
	@cd submodules/yay && makepkg -si --noconfirm --needed
stow_%:
	@stow -t "${HOME}" -v -R "$*"

make_extensions_%: stow_extensions
	@for d in $${HOME}/.dotfiles_ext/*; \
	do \
		make "$*" --directory=$$d; \
	done
