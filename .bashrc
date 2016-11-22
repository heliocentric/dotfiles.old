reset="\e[0m"
cyan="\e[0;36m"
export PS1="\[$cyan\]\u@\h \W\[$reset\]> "

export EDITOR=vim
export PAGER=less
alias commit='git add -A && git commit'
alias push='git push origin && git push origin --tags'
alias ycommit='yadm add $(yadm list) && yadm commit'
alias ypush='yadm push origin && yadm push origin --tags'
alias ysync='yadm pull origin && yadm submodule init && yadm submodule update'
export CLICOLOR=true
export LSCOLORS=Exfxcxdxbxegedabagacad
