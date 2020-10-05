# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lucas/.oh-my-zsh"

# Variables
export DOTFILES="/home/lucas/Private/repo/dotfiles"

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
  zsh-syntax-highlighting
  virtualenvwrapper)

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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time virtualenv node_version time)

## Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=$''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=$'%K{black}%F{white} \ufb8a %f%F{black}%k\ue0c8%f ' # fb8a - skull

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
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214' # orange1
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'

## Status
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_ERROR_ICON='\uf00d'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='088' # darkreda

## CET
POWERLEVEL9K_EXECUTION_TIME_ICON='\uf252'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='238' # grey27
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='208' # darkorange

## Time
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S}"

## Programming languages
### Node
POWERLEVEL9K_NODE_VERSION_BACKGROUND='022' # darkgreen
### virtualenv
POWERLEVEL9K_VIRTUALENV_BACKGROUND='032' # darkgreen
POWERLEVEL9K_VIRTUALENV_FOREGROUND='220' # gold1
POWERLEVEL9K_PYTHON_ICON='\uf81f'

# NVM
## Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_comp>

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

# GCloud
## The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/lucas/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/home/lucas/Applications/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/home/lucas/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/lucas/Applications/google-cloud-sdk/completion.zsh.inc'; fi

# FZF
[[ -f $DOTFILES/vendor/fzf/key-bindings.zsh ]] && source $DOTFILES/vendor/fzf/key-bindings.zsh
[[ -f $DOTFILES/vendor/fzf/completions.zsh ]] && source $DOTFILES/vendor/fzf/completions.zsh
export FZF_DEFAULT_OPTS='--multi --no-reverse --exact --layout=reverse --height 40%'
export FZF_CTRL_R_OPTS=''
export FZF_CTRL_T_OPTS='--select-1 --exit-0'
export FZF_ALT_C_OPTS='--select-1 --exit-0'

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
export PATH=/home/lucas/.dronedeploy/kutil:/home/lucas/.virtualenvs/drone_pipeline/bin:/home/lucas/Applications/google-cloud-sdk/bin:/home/lucas/.nvm/versions/node/v10.16.0/bin:/home/lucas/bin:/usr/local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/lucas/bin:/opt/java/jdk/bin:/var/lib/snapd/snap/bin:/opt/java/jdk/bin

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/lucas/Workspace/dronedeploy/repo/apps/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/lucas/Workspace/dronedeploy/repo/apps/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/lucas/Workspace/dronedeploy/repo/apps/node_modules/tabtab/.completions/sls.zsh ]] && . /home/lucas/Workspace/dronedeploy/repo/apps/node_modules/tabtab/.completions/sls.zsh
