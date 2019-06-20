# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lucas/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins to load
plugins=(docker
	 extract
	 jira
	 git
	 gitfast
	 ng
	 python
	 yarn
	 zsh-autosuggestions
	 zsh-completions
	 zsh-syntax-highlighting)

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Aliases
source ~/.aliases
[ -f ~/Workspace/.aliases-work ] && source ~/Workspace/.aliases-work

# Powerlevel10k Config
## Mode
POWERLEVEL9K_MODE="nerdfont_complete"

## Prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

## Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=$''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=$'%K{black}%F{white} \ufb8a %f%F{black}%k\ue0c8%f '	# fb8a - skull

## Host
POWERLEVEL9K_HOST_ICON='\uf109'
POWERLEVEL9K_SSH_ICON='\uf489'
POWERLEVEL9K_HOST_REMOTE_BACKGROUND='black'
POWERLEVEL9K_HOST_REMOTE_FOREGROUND='yellow'
POWERLEVEL9K_HOST_LOCAL_BACKGROUND='black'
POWERLEVEL9K_HOST_LOCAL_FOREGROUND='white'

## Dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=""
POWERLEVEL9K_HOME_ICON='\uf015'
POWERLEVEL9K_HOME_SUB_ICON='\ufc6e'
POWERLEVEL9K_FOLDER_ICON='\uf755'
POWERLEVEL9K_ETC_ICON='\ue615'

## VCS
POWERLEVEL9K_VCS_BRANCH_ICON='\uf418 '
POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON='\uf127 '
POWERLEVEL9K_VCS_UNTRACKED_ICON='\uf059'
POWERLEVEL9K_VCS_STAGED_ICON='\uf055'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\uf06a'
POWERLEVEL9K_VCS_STASH_ICON='\uf01c '
POWERLEVEL9K_VCS_COMMIT_ICON='\uf292 '
POWERLEVEL9K_VCS_BOOKMARK='\uf461 '
POWERLEVEL9K_VCS_TAG_ICON='\uf02b '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\uf0aa '
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\uf0ab '
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'	# orange1
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'

## Status
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_ERROR_ICON='\uf00d'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='088'	# darkreda

## CET
POWERLEVEL9K_EXECUTION_TIME_ICON='\uf252'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='238'	# grey27
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='166'	# darkorange3a

## Time
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"

## Programming languages

# NVM
## Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_comp>

## Calling 'nvm use' automatically in a directory with a '.nvmrc' file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
