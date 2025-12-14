# ----- modern ls -----
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias lt="eza -T --icons --group-directories-first --level=2"

# ----- quality tools -----
alias cat="bat"
alias find="fd"
alias grep="rg"

# ----- git shortcuts -----
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gl="git pull --rebase"
alias gd="git diff"
alias gds="git diff --staged"
alias glog="git log --oneline --decorate --graph -n 20"
