default: 
	# put your commands here

s_%:
	@stow -t "${HOME}" -v -R "$*"

i_%:
	@echo "Installing package(s) $*"
	@yay -S $* --noconfirm --needed &> /dev/null
