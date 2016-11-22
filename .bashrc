reset="\e[0m"
cyan="\e[0;36m"
export PS1="\[$cyan\]\u@\h \W\[$reset\]> "
export PATH="${HOME}/bin:${PATH}"

export EDITOR=vim
export PAGER=less
export CLICOLOR=true
export LSCOLORS=Exfxcxdxbxegedabagacad
ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
  test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    (umask 066; ssh-agent -c > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi
ysync
