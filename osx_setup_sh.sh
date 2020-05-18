#!/bin/zsh

echo "Please enter your name: "
read $name
echo "Please enter your email: "
read $email
echo "What would you like to call your default venv?"
read $venv

echo Install all AppStore Apps first!
# no solution to automate AppStore installs
# Install 1Password
# Install Amphetamine
# Install NextDNS
# Install Scroll
# Install Vimari
read -p "Press any key to continue... " -n1 -s
echo  '\n'

echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew tap homebrew/cask-fonts

echo "Installing core apps"
brew cask install font-source-code-pro
brew cask install font-hasklig
brew cask install karabiner-elements
brew cask install kitty
brew cask install spectacle
brew cask install spotify
brew cask install spotify-notifications
# Uncomment if desired
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
brew install gitdelta
brew install neovim
brew install node
brew install ripgrep
brew install tmux
brew install wget
brew install zplug

# Dev-specific brew installations
echo "Installing brew developer tools"
brew install python@3.8 && python3.8 -m pip install virtualenvwrapper
brew install go
brew install protobuf
brew install postgresql
brew install rustup
brew install sqlite

echo "Creating SSH Keys"
ssh-keygen -t ed25519 -C $email
ssh-keygen -t rsa -b 4096 -C $email

# Disable key repeat for Hyper & PyCharm
echo "Disabling key repeat for certain applications"
defaults write co.zeit.hyper ApplePressAndHoldEnabled -bool false
defaults write com.jetbrains.pycharm.ce ApplePressAndHoldEnabled -bool false
defaults write com.jetbrains.pycharm ApplePressAndHoldEnabled -bool false

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
if [ ! -d .git ]; then
    git clone https://github.com/sonicxml/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
fi;
mkdir ~/.config
for dir in ./*/
do
    find $dir/.config -maxdepth 1 -mindepth 1 -type d -exec ln -s '{}' ~/.config/ \;
done
ln -s editor/.vimrc ~/.vimrc
ln -s gui/intellij/.ideavimrc ~/.ideavimrc
ln -s shell/fzf.bash ~/.fzf.bash
ln -s shell/fzf.zsh ~/.fzf.zsh
ln -s shell/git/.gitconfig ~/.gitconfig
ln -s shell/tmux/.tmux.conf ~/.tmux.conf
ln -s shell/zsh/.zshrc ~/.zshrc
ln -s shell/zsh/.p10k.zsh ~/.p10k.zsh

# All the replacements
sed -i '' "s/name = John Doe/name = $name/" shell/git/.gitconfig
sed -i '' "s/email = example@email.com/email = $email/" shell/git/.gitconfig
sed -i '' "s/venv/$venv/g" editor/.config/nvim/coc-settings.json
sed -i '' "s/venv/$venv/g" editor/.config/nvim/init.vim
sed -i '' "s/username/$USER/g" editor/.vimrc
sed -i '' "s/username/$USER/g" editor/.config/nvim/coc-settings.json

# Create python venv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.8/bin/python3.8
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

workon $venv
pip install black isort jedi pylint
