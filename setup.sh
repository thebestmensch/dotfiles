#!/bin/bash

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# copy fonts
cp $HOME/Fonts/* $HOME/Library/Fonts/

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# nodeenv
sudo easy_install nodeenv
mkdir -p $HOME/.node_envs
nodeenv $HOME/.node_envs/default
source $HOME/.node_envs/default/bin/activate

# python virtualenvwrapper
brew install python3
pip3 install virtualenvwrapper
export WORKON_HOME=$HOME/.python_envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv default

brew install yarn

# oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

# change default shell
exec zsh
source $HOME/.zshrc
