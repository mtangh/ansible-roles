#!/bin/bash
THIS="${0##*/}"
CDIR=$([ -n "${0%/*}" ] && cd "${0%/*}" 2>/dev/null; pwd)
errs=0
for test in \
$(find . -maxdepth 3 -type f -a -name test.yml 2>/dev/null)
do
  pushd "${teat%/*}" && {
  ansible-playbook -i inventory test.yml --syntax-check ||
  errs=$((errs + 1)); }
  popd
done
exit $errs
