# ${bashrcdir}/10prompt.sh
# $Id$

set +u

PS1=`[ $UID -gt 0 ] && echo '\u'@`'\h \W\$ '
PS2='> '
PS4='+ '

case $TERM in
xterm*)
  CLR=`[ $UID -eq 0 ] && echo '1;31' || echo '1;34'`
  PS1="\[\e[${CLR}m\]${PS1}\[\e[0;39m\]"
  PS2="\[\e[${CLR}m\]${PS2}\[\e[0;39m\]"
  PS4="\[\e[${CLR}m\]${PS4}\[\e[0;39m\]"
  unset CLR
  ;;
*)
  ;;
esac

if [ -z "$PROMPT_COMMAND" ]
then
  if [ -e "${bashrcdir}/prompt.d/$TERM" ]
  then
    PROMPT_COMMAND="${bashrcdir}/prompt.d/$TERM"
  elif [ -e "${bashrcdir}/prompt.d/default" ]
  then
    PROMPT_COMMAND="${bashrcdir}/prompt.d/default"
  fi
fi
  
if [ -z "$PROMPT_COMMAND" ]
then
  case $TERM in
  xterm*)
    PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen)
    PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  *)
    ;;
  esac
fi

set -u

# *eof*
