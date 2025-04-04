#!/bin/sh
reset="\e[0m"
cyan="\e[0;36m"
export PS1="\[$cyan\]\u@\h \W\[$reset\]> "
export PATH="${HOME}/bin:${PATH}"

export EDITOR=vim
export PAGER=less
export CLICOLOR=true
export LSCOLORS=Exfxcxdxbxegedabagacad
SSH_ENV="$HOME/.ssh/environment"

start_agent () {
	echo "Initialising new SSH agent..."
	(umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
	. "${SSH_ENV}" > /dev/null
	ssh-add
}
check_auth_sock () {
	retval="false"
	if [ "${SSH_AUTH_SOCK}" != "" ] ; then
		case "${SSH_AUTH_SOCK}" in
			/*)
				if [ -S "${SSH_AUTH_SOCK}" ] ; then
					ps auxwww | grep "${SSH_AGENT_PID}" | grep ssh-agent$ >/dev/null && retval="true"
				fi
				;;
			*)
				retval="true"
				;;
		esac

	fi
	echo "${retval}"
}
check_auth_file () {
	retval="false"
	if [ -f "${SSH_ENV}" ]; then
		. "${SSH_ENV}" > /dev/null
		ps -auxwww | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null && retval="true"
	fi
	echo "${retval}"
}
runagent="false"
AUTHSOCK="$(check_auth_sock)"
FILE="$(check_auth_file)"
if [ "${FILE}" = "true" -o "${AUTHSOCK}" = "true" ] ; then
	runagent="false"
else
	runagent="true"
fi
if [ "${runagent}" = "true" ] ; then
	# Source SSH settings, if applicable
	start_agent;
fi
for file in $(echo "${HOME}/.ssh/keyring/*")
do
	EXISTS="$(ssh-add -l | grep "${file}")"
	if [ "${EXISTS}" = "" ] ; then
		case "${file}" in
			*.pub)
				;;
			*)
				/usr/bin/ssh-add "${file}"
				;;
		esac
	fi
done

export VAGRANT_DEFAULT_PROVIDER=virtualbox
ysync
HOSTNAME="$(hostname)"
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
