# Profiling: Run `zprof` at end
#zmodload zsh/zprof

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Configured by me

## Stolen from https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
## Even more History configuration
setopt appendhistory          #Append history to the history file (no overwriting)
setopt incappendhistory       #Immediately append to the history file, not just when a term is killed

# By default zsh will ignore comments in scripts only, on the command line they'll cause an error
setopt interactivecomments

# emacs keymap
bindkey -e

# Make HOME, END, DELETE keys work properly
bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color'
alias vi=vim
alias python=python3
alias clip.exe=/mnt/c/Windows/System32/clip.exe
alias clip=/mnt/c/Windows/System32/clip.exe
#alias pbcopy=/mnt/c/Windows/System32/clip.exe
alias open=/mnt/c/Windows/explorer.exe

# Java
export JAVA_HOME=/usr/lib/jvm/default-jvm
export JDK_HOME="${JAVA_HOME}"


export EDITOR=vim


# Enable Ctrl-x-e to edit command line
# Ctrl-x e is Emacs style
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line


setopt prompt_subst
. ~/.git-prompt.sh

# `ssh` depending on config can get an error, it this is not a full path
# `Shell "zsh" is not executable: No such file or directory`
export SHELL=/bin/zsh
export PS1='%F{154}%n@%m%f %F{123}%D{%Y-%m-%d} %*%f %F{blue}%1~%f $(__git_ps1 "(%s)")%(?..[%B%F{red}%?%f%b] )%# '
#export PATH="$PATH:$HOME/bin:$HOME/go/bin:$HOME/.cargo/bin"
# kubectl krew -- export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# Python pip normally puts things here
export PATH="$PATH:$HOME/.local/bin"

# for github CLI etc
export MANPATH="/usr/share/man:/usr/local/share/man"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null

# inherit `local` and `any` causes it to spawn a new agent
#eval $(keychain --eval --inherit local)
#eval $(keychain --eval --inherit any)
#eval $(keychain --agents ssh,gpg --eval)
eval $(keychain --agents gpg --eval)

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
#if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# `complete` is defined in `google-cloud-sdk/completion.zsh.inc`

autoload -U +X bashcompinit
bashcompinit
# `complete` comes from autoloading and running `bashcompinit`
# Auto-complete `aws`
complete -C aws_completer aws

# https://zsh.sourceforge.io/FAQ/zshfaq04.html
zstyle ':completion:*' completer _complete _ignored _files

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# Profiling: Run `zmodload zsh/zprof` at start
#zprof

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C "$HOME/bin/terraform" terraform

# Source all files in ~/.zshrc.d/ if the directory exists
if [ -d "$HOME/.zshrc.d" ]; then
    for file in "$HOME/.zshrc.d"/*.zsh; do
        [ -r "$file" ] && . "$file"
    done
    unset file
fi
