#!/bin/bash

FORCE_ALL=false
SHOULD_CONFIGURE_VSCODE=false # turn off to save load time
ZSHRC_DIR=$(pwd)'/.zshrc'
LOG_COLOR='\e[32m'

echo log_progress_inline $LOG_COLOR
echo log_progress_inline 'Running .zshrc at '$ZSHRC_DIR

# https://stackoverflow.com/questions/6569478/detect-iflog_progress_inlinexecutable-file-is-on-users-path
function is_bin_in_path {
  builtin type -P "$1" &> /dev/null
}

do_if_cmd_not_exists () {
  CMD=$1
  FUNC=$2

  if is_bin_in_path $CMD
  then
    $FUNC
  fi
}

log_progress () {
  echo -ne $LOG_COLOR
  echo $1
  echo -ne '\e[39m'
}

log_progress_inline () {
  echo -ne $LOG_COLOR
  echo -n $1
  echo -ne '\e[39m'
}

##
## MISC PATH CHANGES
##
update_paths () {
  log_progress_inline 'Updating path variables...'
  export PATH=$HOME/bin:/usr/local/bin:$PATH # might need if coming from bash
  export SSH_KEY_PATH="~/.ssh/rsa_id"
  export PATH="$HOME/.yarn/bin:$PATH"
  export ANTIGEN_PATH="~/.dotfiles"
  export ZSH=$HOME/.oh-my-zsh
  log_progress 'ok'
}

##
## TERMINAL ALIASES
##
set_terminal_aliases () {
  log_progress_inline 'Adding terminal aliases...'
  alias dkc="docker-compose"
  alias dk="docker"
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  log_progress 'ok'
}

##
## TERMINAL DEFAULT OVERRIDES
##
set_terminal_default_programs () {
  export EDITOR='vim'
}

configure_ssh () {
  log_progress_inline 'Starting ssh-agent...'
  eval $(ssh-agent -s) &>/dev/null
  log_progress 'ok'
}

##
## INSTALL BREW
##
install_homebrew () {
  log_progress_inline 'Installing homebrew...'
  eval "CI=1 /usr/bin/ruby log_progress_inline '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'"
  log_progress 'ok'

  log_progress 'Updating brew...'
  brew update
  log_progress 'ok'

  log_progress 'Installing from Brewfile'
  brew bundle
  log_progress 'ok'
}

##
## VIRTUAL ENVIRONMENT SETUP: Virtualenvwrapper (python), NVM (npm), rbenv (ruby)
##

configure_virtualenvwrapper () {
  log_progress_inline '    Installing virtualenvwrapper...'
  export WORKON_HOME=$HOME/.python_envs
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  source /usr/local/bin/virtualenvwrapper.sh
  log_progress 'ok'
}

configure_rbenv () {
  log_progress_inline '    Configuring rbenv...'
  eval "$(rbenv init -)" &>/dev/null
  log_progress 'ok'
}

configure_nvm () {
  log_progress_inline '    Configuring nvm...'
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  log_progress 'ok'
}

configure_virtual_envs () {
  log_progress 'Configuring virtual environments...'
  configure_virtualenvwrapper
  configure_rbenv
  configure_nvm
  log_progress 'ok'
}

##
## VSCODE EXTENSIONS & SETTINGS
##
do_configure_vscode () {
  log_progress 'Configuring VSCode...'
  ln -fs $HOME/.vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
  cat $HOME/.vscode/extensions.list | xargs -L1 code --installlog_progress_inlinextension
  log_progress 'ok'
}

configure_vscode () {
  if $SHOULD_CONFIGURE_VSCODE
  then
    VSCODE_PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    CMD = $VSCODE_PATH
    do_if_cmd_not_exists CMD configure_vscode
  fi
}

##
## ZSH CONFIG
##
configure_ohmyzsh () {
  log_progress_inline 'Setting up oh-my-zsh...'
  export ZSH=$HOME/.oh-my-zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
  ZSH_THEME="powerlevel9k/powerlevel9k"
  source $HOME/.oh-my-zsh/oh-my-zsh.sh
  log_progress 'ok'
}

##
## ZSH THEME
##
## Antigen is required for zsh theme (and its nice on its own)
## https://github.com/zsh-users/antigen
##
configure_antigen () {
  log_progress 'Configuring antigen...'

  source /usr/local/share/antigen/antigen.zsh
  source ~/.zsh-theme
  antigen use oh-my-zsh
  antigen bundle StackExchange/blackbox
  antigen bundle brew
  antigen bundle command-not-found
  antigen bundle common-aliases
  antigen bundle docker
  antigen bundle docker-compose
  antigen bundle git
  antigen bundle golang
  antigen bundle npm
  antigen bundle nvm
  antigen bundle python
  antigen bundle tmux
  antigen theme bhilburn/powerlevel9k powerlevel9k
  antigen apply
  log_progress 'ok'
}

run () {
  update_paths
  set_terminal_aliases
  set_terminal_default_programs
  configure_ssh

  do_if_cmd_not_exists "brew" install_homebrew
  configure_virtual_envs

  configure_vscode
  configure_ohmyzsh
  configure_antigen

  source $HOME/.oh-my-zsh/oh-my-zsh.sh
}
run