#!/bin/zsh

echo "Please enter your name: "
read "name"
echo "Please enter your email: "
read "email"
echo "What would you like to call your default venv?"
read "venv"

echo "Install all AppStore Apps first!"
# no solution to automate AppStore installs
# Install 1Password
# Install NextDNS
# Install Scroll
# Install Vimari
read -k1 "?Press any key to continue... "

echo "Installing Homebrew"
# ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/cask-fonts

echo "Installing core apps"
export HOMEBREW_NO_AUTO_UPDATE=1
brew install --cask font-source-code-pro
brew install --cask font-source-code-pro-for-powerline
brew install --cask font-hasklig
brew install --cask kitty
# Uncomment if desired
# brew cask install spotify-notifications
# brew cask install docker
# brew cask install firefox
# brew cask install google-chrome

# Consider installing Little Snitch and/or Micro Snitch
# https://www.obdev.at/products/littlesnitch/order.html

# Normal brew installations
echo "Installing standard brew tools"
brew install bat
brew install ctags
brew install exa
brew install fasd
brew install fd
brew install fzf
brew install git-delta
brew install neovim
brew install node
brew install ripgrep
brew install tmux
brew install tree
brew install wget
brew install zplug

# Dev-specific brew installations
echo "Installing brew developer tools"
brew install python@3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
python3 -m pip install virtualenvwrapper
# brew install go
# brew install protobuf
# brew install postgresql
# brew install rustup
# brew install sqlite

echo "Creating SSH Keys"
ssh-keygen -t ed25519 -C $email -q -N ""
ssh-keygen -t rsa -b 4096 -C $email -q -N ""

echo "Setting up all dotfiles"
# Install Vim-plug for vim and neovim
# Vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi;
# Neovim
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi;

# Setup dotfiles, create symlinks
if [ ! -d .git ] || [ "$PWD" != "/home/$USER/.dotfiles" ]; then
    echo "Dotfiles repo either doesn't exist or is in an unexpected location."
    echo "Cloning into ~/.dotfiles"
    git clone https://github.com/sonicxml/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
fi;

# All the replacements
sed -i "s/name = NAME/name = $name/" shell/git/.gitconfig
sed -i "s/email = EMAIL/email = $email/" shell/git/.gitconfig
sed -i "s/VENV/$venv/g" editor/.config/nvim/coc-settings.json
sed -i "s/VENV/$venv/g" editor/.config/nvim/init.vim
sed -i "s/USERNAME/$USER/g" editor/.vimrc
sed -i "s/USERNAME/$USER/g" editor/.config/nvim/coc-settings.json

mkdir ~/.config
for dir in */.config/*/
do
    dir=${dir%*/}  # Remove trailing /
    ln -s "/home/$USER/.dotfiles/$dir" ~/.config/
done
ln -s /home/$USER/.dotfiles/editor/.vimrc ~/.vimrc
ln -s /home/$USER/.dotfiles/gui/intellij/.ideavimrc ~/.ideavimrc
ln -s /home/$USER/.dotfiles/shell/.fzf.bash.linux ~/.fzf.bash
ln -s /home/$USER/.dotfiles/shell/.fzf.zsh.linux ~/.fzf.zsh
ln -s /home/$USER/.dotfiles/shell/git/.gitconfig ~/.gitconfig
ln -s /home/$USER/.dotfiles/shell/tmux/.tmux.conf ~/.tmux.conf
ln -s /home/$USER/.dotfiles/shell/zsh/.zshrc ~/.zshrc
ln -s /home/$USER/.dotfiles/shell/zsh/.p10k.zsh ~/.p10k.zsh

# Create python venv
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/dev
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.8/bin/python3.8
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
. /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv $venv
pip install black

