#!/bin/bash

installHomebrew() {
	if hash brew 2>/dev/null; then
		echo "homebrew is already installed"
	else

		NONINTERACTIVE=1 /bin/bash -c "$(ddcurl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

installCargo() {
	if hash cargo 2>/dev/null; then
		echo "cargo is already installed"
	else
		curl https://sh.rustup.rs -sSf | sh -s -- -y && 
		source "$HOME/.cargo/env"
	fi
}

install() {
	if hash $1 2>/dev/null; then
		echo "$1 is already installed"
	else
		brew install $1
	fi
}

# Install dependancies
installHomebrew
install git
install make
install python3
install node
installCargo

# LunarVim

if hash lvim 2>/dev/null; then
	echo "lvim is already installed"
else
	LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh) -y -y -y
fi

echo -e "\nexport PATH=$HOME/.local/bin:\$PATH" >> $HOME/.zshenv
source $HOME/.zshenv

cp ./config.lua $HOME/.config/lvim/

echo "Install Nerd Font"
echo "brew tap homebrew/cask-fonts"
echo "brew install --cask font-jetbrains-mono-nerd-font"
