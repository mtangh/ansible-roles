#!/bin/bash
THIS="${0##*/}"
CDIR=$([ -n "${0%/*}" ] && cd "${0%/*}" 2>/dev/null; pwd)
# Name
THIS="${THIS:-.travis.yml}"
BASE="${THIS%.*}"
# Errors
errs=0
# Run tests
for test in \
$(find "${CDIR}" -maxdepth 3 -type f -a -name "test.yml" 2>/dev/null)
do
  pushd "${test%/*}" && {
  ansible-playbook -i inventory test.yml --syntax-check ||
  errs=$((errs + 1))
  popd || : }
done
# end
exit $errs
