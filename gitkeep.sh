#!/bin/sh
THIS="${0##*/}"
CDIR=$([ -n "${0%/*}" ] && cd "${0%/*}" 2>/dev/null; pwd)

base_dir="${base_dir:-.}"
_rebuild=0
_dry_run=0

usage() {
  cat <<_USAGE_
Usage: $THIS [--rebuild] [-d|--dry-run] [dir...]

_USAGE_
  exit 1
}

while [ $# -gt 0 ]
do
  case "$1" in
  --rebuild)
    _rebuild=1
    ;;
  --dry-run|-d)
    _dry_run=1
    ;;
  --help)
    usage
    ;;
  -*)
    ;;
  *)
    base_dir="${base_dir} $1"
    ;;
  esac
  shift
done

[ -n "$base_dir" ] ||
  usage

[ $_rebuild -ne 0 ] && {
  if [ $_dry_run -eq 0 ]
  then
    findcmd="rm -f"
  else
    findcmd="echo"
  fi
  # Remove gitkeep
  find ${base_dir} \
       -name ".gitkeep" -a type f \
       -exec $findcmd {} \; 2>/dev/null
  echo
}

for dir in $(find $base_dir -type d 2>/dev/null)
do
  echo "${dir}" |
  grep -E '^(/.+|\./|(\./|)\.git(/.*|))$' 1>/dev/null 2>&1 &&
    continue
  [ -n "$(ls -1A ${dir})" ] &&
    continue
  [ -e "$dir/.gitkeep" ] &&
    continue
  [ $_dry_run -eq 0 ] &&
    touch $dir/.gitkeep
  echo "gitkeep: $dir"
done

exit 0