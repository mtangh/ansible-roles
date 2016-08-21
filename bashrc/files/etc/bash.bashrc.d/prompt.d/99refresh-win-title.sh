# ${bashrcdir}/prompt.d/99refresh-window-title.sh

_pc_refreshwintitle() {
  case $TERM in
  xterm*)
    printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
    ;;
  screen)
    printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
    ;;
  *)
    ;;
  esac
  return 0
}

PROMPT_COMMAND_99_RFREAH_WINTITLE='_pc_refreshwintitle'
