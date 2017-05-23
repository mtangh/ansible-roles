#!/bin/bash
THIS="${0##*/}"
CDIR=$([ -n "${0%/*}" ] && cd "${0%/*}" 2>/dev/null; pwd)

# Name
THIS="${THIS:-.travis.yml}"
BASE="${THIS%.*}"

# Ansible playbook
play=$(type -P ansible-playbook)

# Errors
errs=0

# Run tests
for test in \
$(find "${CDIR}" -maxdepth 3 -type f -a -name "test.yml" 2>/dev/null)
do

  [ -d "${test%/*}" ] &&
  pushd "${test%/*}" ||
  continue

  [ -n "${test##*/}" ] && {

    host=""

    for file in inventory hosts
    do 
      [ ! -e "$file" ] || {
        host="$file"; break
      }
    done || :

    $play -i "${host}" "${test##*/}" --syntax-check &&
    $play -i "${host}" "${test##*/}" -C

  } ||
  errs=$((errs + 1))

  popd || :

done

# End
exit $errs
