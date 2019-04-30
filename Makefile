default: git shell tmux vim neovim

neovim: i_ripgrep\ the_silver_searcher\ ptags\ neovim s_neovim
	@nvim +PlugInstall +qall

vim: neovim s_vim

tmux: i_xclip\ tmux s_tmux

shell: i_bash-completion\ fzf s_shell

git: i_diff-so-fancy s_git
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

s_%: base
	@stow -t "${HOME}" -v -R "$*"

i_%: base
	@echo "Installing package(s) $*"
	@yay -S $* --noconfirm --needed &> /dev/null

base:
	@sudo pacman -S git stow curl wget --noconfirm --needed
	@git submodule update --init --recursive
	@cd submodules/yay && makepkg -si --noconfirm --needed
