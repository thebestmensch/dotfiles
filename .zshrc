# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# virtual envs
source /usr/local/bin/virtualenvwrapper.sh
workon default
source $HOME/.node_envs/default/bin/activate

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	virtualenvwrapper
	ruby
	rails
	rbenv
	git
#	npm
	brew
	extract
	docker
	osx
	zsh-autosuggestions
	zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

source $HOME/.oh-my-zsh/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# rbenv
if hash rbenv 2>/dev/null; then eval "$(rbenv init -)"; fi

# nodeenv
if hash nodeenv 2>/dev/null; then source $HOME/.node_envs/default/bin/activate; fi

# yarn
export PATH="$HOME/.yarn/bin:$PATH"

# prompt (powerlevel 9k)
function zsh_package_json () {
  local pkgjson=$(pwd)/package.json
  if [[ -f $pkgjson ]]; then
    local nodever npmver pkgver

    if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NODEVER != 'false' ]]; then
      nodever=$POWERLEVEL9K_NODE_ICON' '$(node --version)
    fi

    if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_PKGVER != 'false' ]]; then
      local actualpkgver=$(node -p "require('$pkgjson').version || ''")
      [[ -z $actualpkgver ]] || pkgver=$POWERLEVEL9K_PACKAGE_ICON' '$actualpkgver
    fi

    env echo -n $nodever $pkgver
  fi
}

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_CUSTOM_NODE_VERSION="if hash nodeenv 2>/dev/null; then echo \$(nodeenv local); fi"
POWERLEVEL9K_CUSTOM_NODE_VERSION_BACKGROUND='green'
POWERLEVEL9K_CUSTOM_PACKAGE_JSON=zsh_package_json
POWERLEVEL9K_CUSTOM_PACKAGE_JSON_BACKGROUND='green'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%I:%M  \UF133  %m.%d.%y}"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_CUSTOM_BATTERY_STATUS="prompt_zsh_battery_level"
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=true
NODE_VIRTUAL_ENV_DISABLE_PROMPT=1
VIRTUAL_ENV_DISABLE_PROMPT=1

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_node_version rbenv virtualenv)
HIST_STAMPS="mm/dd/yyyy"
DISABLE_UPDATE_PROMPT=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jm/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jm/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jm/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jm/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# vscode settings

if hash code 2>/dev/null; then ln -fs ~/.vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json; fi

if hash code 2>/dev/null; then cat ~/.vscode/extensions.list | xargs -L1 code --install-extension; fi

