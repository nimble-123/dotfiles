alias reload!='. ~/.zshrc'
alias ni='npm install'
alias nig='npm install --global'
alias nid='npm install --save-dev'
alias nis='npm install --save'

alias such='git'
alias very='git'
alias wow='git status -sb'

alias cd..='cd ..'
alias ls='colorls --sd --gs --report -1 -A'
alias lsa='colorls --sd --gs -lA'
alias lst='colorls --sd --gs --tree'

alias chrome_dis='open -a Google\ Chrome --args --disable-web-security --user-data-dir'
alias dot='code ~/.dotfiles'
alias bupgrade='brew update && brew upgrade && brew cask upgrade && brew cleanup'
alias dev-versions='echo "nvm:\t" $(nvm --version) && echo "node:\t" $(node --version) && echo "npm:\t" $(npm --version) && echo "ui5:\t" $(ui5 --version)'
