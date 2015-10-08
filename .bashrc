#===========================================================================
# .bashrc File to be used in your $HOME/.bashrc
#
# By Lee-Jon Ball, but heavily borrowing from everywhere
#
#
# http://tldp.org/LDP/abs/html/index.html
# http://www.caliban.org/bash/
# http://www.shelldorado.com/scripts/categories.html
# http://www.dotfiles.org/
#===========================================================================


#--------------------------------------------------------
# Aliases
#--------------------------------------------------------

alias o='open'             # For fast term to GUI switch
alias cls='clear'          # DOS is ingrained in me
alias h='history'            # easy access to history


#--------------------------------------------------------
# Aliases for development
#--------------------------------------------------------

alias v='vim'                 # quick access to Vim
alias ga='git add .'          # add files to repo
alias gm='git commit'         # enter editor
alias gco='git checkout'      # checkout branch
alias gs='git status'
alias gl='git log --no-merge' # Jamie's tip

alias be='bundle exec'        # bundler with options:
alias ber='bundle exec rspec'              # rspec
alias bec='bundle exec cucumber'           # cukes

# Git specific:
. ~/.git-completion.bash
. ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[36m\]\u \[\033[0;33m\]\w\[\033[0;35m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '


#--------------------------------------------------------
# Aliases around 'ls' family of commands
#--------------------------------------------------------

alias ls='ls -hFG'           # add colors for filetype recognition
alias ll='ls -l'             # --group-directories-first'
alias la='ls -Al'            # show hidden files
alias lx='ls -lXB'           # sort by extension
alias lk='ls -lSr'           # sort by size, biggest last
alias lc='ls -ltcr'          # sort by and show change time, most recent last
alias lu='ls -ltur'          # sort by and show access time, most recent last
alias lt='ls -ltr'           # sort by date, most recent last
alias lm='ls -al |more'      # pipe through 'more'
alias lr='ls -lR'            # recursive ls
alias tree='tree -Csu'       # nice alternative to 'recursive ls'


#--------------------------------------------------------
# Options
#--------------------------------------------------------

HISTFILESIZE=1000000000 # Increase size of history
HISTSIZE=1000000


#--------------------------------------------------------
# PATHs & Environment Variables
#--------------------------------------------------------
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:$PATH"

export EDITOR="/usr/bin/vim"

### Node.js
export NODE_PATH="/usr/local/lib/node"
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Go Lang
export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin

### Ruby RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### Specify defaults for homebrew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### EC2 CLI
export JAVA_HOME=$(/usr/libexec/java_home)
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.1
export PATH=$PATH:$EC2_HOME/bin


#--------------------------------------------------------
# Prompt definition
#--------------------------------------------------------

# PROMPT_HOST_COLOR='1;31m'
# PROMPT_DIR_COLOR='1;34m'
# PROMPT_DEF_COLOR='0;39m'
# ROOT_AT=''
# # If I am root, set the prompt to bright red
# if [ ${UID} -eq 0 ]; then
# PROMPT_HOST_COLOR='41m'
# PROMPT_DIR_COLOR='41m'
# ROOT_AT='root@'
# fi
# case ${TERM} in
#         vt100)
# PS1='[\u@${PROMPT_HOSTNAME}\w]\n \#\$'
#         ;;
#         *)
# PS1='[\e[${PROMPT_HOST_COLOR}\[${ROOT_AT}\h:\[\e[${PROMPT_DIR_COLOR}\]\W\[\$\e[m]\n$ '
#         ;;
# esac

