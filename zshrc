# .zshrc

# Source global definitions
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

# Completion

## menu-style
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
zstyle ':completion:*' special-dirs true

## case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Tab completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## add new installed packages into completions
zstyle ':completion:*' rehash true

## Use better completion for the kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;34'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

## use completion cache
zstyle ':completion::complete:*' use-cache true

bindkey "\e[3~" delete-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey " "  magic-space

setopt PROMPT_PERCENT
setopt PROMPT_SUBST

# Tab completion
autoload -Uz compinit && compinit
setopt complete_in_word         # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # These "eat" the auto prior space after a tab complete

# misc
setopt BSD_ECHO
setopt autocd                   # cd to a folder just by typing it's name
setopt interactive_comments     # allow # comments in shell; good for copy/paste
unsetopt correct_all            # I don't care for 'suggestions' from ZSH
export BLOCK_SIZE="'1"          # Add commas to file sizes

# history config
HISTSIZE=1000
SAVEHIST=1000
export HISTFILE="${HOME}/.zsh_history"

# share history across multiple zsh sessions
setopt SHARE_HISTORY

# append to history
setopt APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST

# do not store duplications
setopt HIST_IGNORE_DUPS

# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# Correction when you misstype
#setopt CORRECT
#setopt CORRECT_ALL

# use emacs bindings
set -o emacs

add_to_path() {
    # User specific environment
    if ! [[ "$PATH" =~ "${1}" ]]; then
        PATH="${1}:${PATH}"
    fi
}

add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export PATH

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

function swapfiles() {
    tmp="$(mktemp)"
    mv "$1" "$tmp"
    mv "$2" "$1"
    mv "$tmp" "$2"
}

function head() {
    printf "%s" "${1:0:1}"
}

function mk_git_log_sed() {
    str="$1"
    printf " -e 's/ %ss\\? ago)/%.1s)/' -e 's/ %ss\\?, /%.1s, /'" "$str" "$str" "$str" "$str"
}

git_log_sed_exprs="$(mk_git_log_sed second) $(mk_git_log_sed minute) $(mk_git_log_sed hour) $(mk_git_log_sed day) $(mk_git_log_sed week) $(mk_git_log_sed month) $(mk_git_log_sed year)"

function mkgraph() {
    printf "%s" "git lg --color=always ${1} | gitlogprettify | less"
}

mkcd() {
  mkdir -p $1
  cd $1
}

teehist() {
  print -s $1
  eval $1
}

function ef() {
    file="$(fuzzy)"
    if [ ! -z "$file" ]; then
        echo "$file"
        teehist "e '$file'"
    fi
}

export EDITOR=hx

for i in $(seq 12); do
    alias gr${i}="git rebase -i HEAD~${i}"
done

alias cat="bat"
alias c="clear"
alias cf="cd \"\$(fd -t d | fuzzy)\""
alias cs="clear;ls"
alias debug="set -o nounset; set -o xtrace"
alias e=hx
alias ff="fuzzy"
alias f=find
alias fuzzy=fzf
alias gaaa="git add --all"
alias gaa="git add ."
alias ga="git add"
alias gau="git add --update"
alias gbd="git branch --delete"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gcf="git commit --fixup"
alias gcl="git clone"
alias gcm="git commit --message"
alias gcne="git commit --no-edit"
alias gcmnv="git commit --message --no-verify"
alias gcnenv="git commit --no-edit --no-verify"
alias gcob="git checkout -b"
alias gcod="git checkout develop"
alias gco="git checkout"
alias gcom="git checkout master"
alias gcos="git checkout staging"
alias gda="git diff HEAD"
alias gdc="git diff --cached"
alias gd="git diff"
alias grep=rg
alias gerp=grep
alias gg="$(mkgraph "")"
alias gga="$(mkgraph "--all")"
alias ggp="$(mkgraph "-p --simplify-by-decoration")"
alias ggpa="ggp --all"
alias gitlogprettify="sed ${git_log_sed_exprs}"
alias gld="git log --pretty = format:\"%h %ad %s\" --date = short --all"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gm="git merge --no-ff"
alias gp="git pull"
alias gpr="git pull --rebase"
alias gpu="git push"
alias gpuu="git push -u \$(git remote)"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gs="git status"
alias gss="git status --short"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gst="git stash"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsts="git stash save"
alias h="history"
alias json="jq -Rr 'try fromjson // .'"
alias k="kill"
alias kubs="kubectl -n backend-staging"
alias kubp="kubectl -n backend-production"
alias ls=eza
alias ll="ls -alF"
alias l="ls -lah"
alias lsl="ls -lah"
alias mkdir="mkdir -p"
alias nul="/dev/null"
alias o="xdg-open"
alias p=cat
alias pd="pwd"
alias r="ranger"
alias reload="source $DOTFILE"
alias sl=ls
alias sudo="sudo "
alias tree="eza --tree"
alias t="time"
alias ytdl720="yt-dlp -f '(mkv,mp4)[height<=720]'"
alias ytdl1080="yt-dlp -f '(mkv,mp4)[height<=1080]'"

export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/home/owen/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if command -v jj &> /dev/null; then
    source <(jj util completion zsh)
fi
