# ${bashrcdir}/prompt.d/00synchist.sh

_pc_sync_hist() {
  history -a
  history -c
  history -r
  return 0
}

PROMPT_COMMAND_00_SYNCHIST='_pc_sync_hist'
