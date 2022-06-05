# Uncomment this and the last line of file for profiling
#zmodload zsh/zprof

# Aliases
alias l="ls -F"
alias m="less"
alias v="nvim"
alias t="tmux"
alias g="git"

alias la="ls -la"
alias sshp="ssh cenrigh@moore08.cs.purdue.edu"
alias vim="nvim"

# Python 2 is dead to me
alias python="python3"
alias pip="pip3"

# "It just works"
alias brew86="arch -x86_64 /usr/local/bin/brew"
alias pyenv86="arch -x86_64 pyenv"

# ls whenever you cd
function cd() {
	builtin cd "$@" && ls -F
}

# mkdir and cd in one command
function mc() {
	mkdir -p -- "$1" &&
	cd -P -- "$1"
}

# Restart touchbar because technology is awful
function killtb() {
	pkill "Touch Bar agent";
	killall "ControlStrip";
}

# Wrap ssh to show short hostname in tmux window name
#function ssh {
#	if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
#		tmux rename-window "$(echo $* | cut -d . -f 1)"
#		command ssh "$@"
#		tmux set-window-option automatic-rename "on"
#	else
#		command ssh "$@"
#	fi
#}

# Misc options
setopt AUTO_CD            # Move into a directory if input is not a command
setopt AUTO_PUSHD         # Automatically push directory onto stack on cd
setopt PUSHD_IGNORE_DUPS  # Don't push directory onto stack multiple times
setopt PUSHD_SILENT       # Don't print on directory stack push/pop

# Tab completion
autoload -Uz compinit && compinit
setopt ALWAYS_TO_END    # When completing from the middle of a word, move the cursor to the end of the word
setopt MENU_COMPLETE    # Automatically fill in first match on tab
# Case insensitive completion (APFS is case insensitive anyway)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History settings
HISTFILE=~/.zhistory
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY          # allow multiple sessions to append to one history
setopt BANG_HIST               # Treat ! special during command expansion
setopt HIST_VERIFY             # Don't execute immediately on history expansion (! commands)
setopt EXTENDED_HISTORY        # Write history in :start:elasped;command format
setopt HIST_FIND_NO_DUPS       # When searching history, don't repeat
setopt HIST_IGNORE_DUPS        # Ignore duplicate entries of previous events
setopt HIST_IGNORE_SPACE       # Prefix command with a space to skip its recording
setopt HIST_REDUCE_BLANKS      # Remove blank lines from each command added to history
setopt INC_APPEND_HISTORY      # Write to history file immediately, not when shell quits

EDITOR=nvim
bindkey -v
bindkey 'jk' vi-cmd-mode  # Enter vi mode on 'jk'

# Prompt
setopt PROMPT_SUBST

# Flip prompt arrow to show insert or normal mode
function zle-line-init zle-keymap-select {
	if [ $KEYMAP = vicmd ]; then
		PROMPT=" %~ ❮ "
	else
		PROMPT=" %~ ❯ "
	fi

	zle reset-prompt
}

zle -N zle-line-init      # Run on line init
zle -N zle-keymap-select  # Run on keymap change

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH="$GOBIN:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cj/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cj/Documents/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/cj/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cj/Documents/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/sbin:$PATH"

export GPG_TTY=$(tty)
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/Users/cj/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Add keys to ssh agent
ssh-add > /dev/null 2>&1

set -o allexport
source ~/.env
set +o allexport

eval "$(pyenv init -)"

# Uncomment this and first line for profiling
#zprof
