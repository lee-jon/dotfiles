[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Loading the .bashrc file on OS X
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Increase the size of the HISTORY
HISTFILESIZE=1000000000
HISTSIZE=1000000

# Load RVM function
