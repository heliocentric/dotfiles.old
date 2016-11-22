reset="\e[0m"
cyan="\e[0;36m"
export PS1="\[$cyan\]\u@\h \W\[$reset\]> "

export EDITOR=vim
export PAGER=less
alias commit='git add -A && git commit'
alias gitlab='git push origin && git push origin --tags'
alias github='git push upstream && git push upstream --tags'


export CLICOLOR=true
export LSCOLORS=Exfxcxdxbxegedabagacad
