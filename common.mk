default: 
	# put your commands here

s_%:
	@stow -t "${HOME}" -v -R "$*"

i_%:
	@echo "Installing package(s) $*"
	@sudo pacman -S $* --noconfirm --needed &> /dev/null
