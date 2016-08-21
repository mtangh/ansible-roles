# ${bashrcdir}/11promptxommand.sh
# $Id$

# Not an error undefined variable
set +u

# Initialize PROMPT_COMMAND
PROMPT_COMMAND=""

# PROMPT_COMMAND
for prompt_command_sh in \
${bashrcdir}/prompt.d/[0-9][0-9]*.sh \
$HOME/.bash_prompt.d/{$machine.$TERM,$TERM,default}.sh ;
do
  if [ -x "$prompt_command_sh" ]
  then
    . "$prompt_command_sh" 1>/dev/null 2>&1
  fi
done

for prompt_command in ${!PROMPT_COMMAND_*}
do
  if [ -z "${!prompt_command}" ]
  then
    PROMPT_COMMAND="${PROMPT_COMMAND};${!prompt_command}"
  fi
done

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

# unset
unset prompt_command_sh prompt_command

# To an undefined variable in error
set -u

# *eof*
