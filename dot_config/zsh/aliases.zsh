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

# ----- git, kurz (gp bleibt git push) -----
alias gits="git status"
alias gitd="git diff"
alias gitl="git lg"
alias gita="git add ."
alias gitc="cz commit"
alias gitb="git branch --sort=-committerdate"
alias gitconfig="code ~/.gitconfig"

# ----- shell & ssh -----
alias zshconfig="code ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias sshhome="cd ~/.ssh"
alias sshconfig="code ~/.ssh/config"

# ----- sonstiges -----
alias c="clear"
alias cc="claude"
alias ip="ipconfig getifaddr en0"
alias cd..="cd .."
alias bu="brew update && brew upgrade && brew cleanup"
