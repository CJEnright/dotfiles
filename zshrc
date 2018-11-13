# Aliases
alias ll="ls ${lsflags} -l"
alias la="ls ${lsflags} -la"
alias ,="cd .."
alias ..="cd .."
alias m="less"
alias v="vim"
alias sshp="ssh cenrigh@moore01.cs.purdue.edu"
alias gogit="cd ~/Documents/git"
alias gogo="cd ~/Documents/git/go/src/github.com/cjenright"

export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'

# Function to mkdir and cd
mc () {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

function cd {
	builtin cd "$@" && ls -F
}

# Add thing to PATH
export PATH=//usr/local/bin:$PATH

# Tab completion
autoload -Uz compinit && compinit
setopt complete_in_word         # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt auto_menu                # show completion menu on succesive tab presses
setopt autocd                   # cd to a folder just by typing its name
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word

# History settings
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt append_history           # allow multiple sessions to append to one history
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, dont repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip its recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Dont execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions

# MISC
EDITOR=vim
export BLOCK_SIZE="'1"          # Add commas to file siz

# Prompt and theme
setopt prompt_subst
autoload -Uz vcs_info
ZSH_THEME="good"

# Left prompt
PROMPT=" %~ ❯ "

# Should really clean this up ¯\_(ツ)_/¯
export GOPATH=$HOME/Documents/git/go
export GOBIN=$GOPATH/bin
PATH="$GOPATH/bin:$PATH"
export PATH=~/bin:$PATH
export PATH="/usr/local/bin:$PATH"

applefuckingsucks() {
	pkill "Touch Bar agent";
	killall "ControlStrip";
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cj/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cj/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cj/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cj/Documents/google-cloud-sdk/completion.zsh.inc'; fi
