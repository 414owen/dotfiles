# .bashrc


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"

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
  history -s $1
  eval $1
}

export EDITOR=hx

alias cat="bat"
alias c="clear"
alias cf="cd \"\$(fd -t d | fuzzy)\""
alias cs="clear;ls"
alias debug="set -o nounset; set -o xtrace"
alias e=hx
alias ef="file=\"\$(fuzzy)\"; [ ! -z \"\$file\" ] && echo \"\$file\" && teehist \"e '\$file'\""
alias ff="fuzzy"
alias find=fd
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
. "$HOME/.cargo/env"
