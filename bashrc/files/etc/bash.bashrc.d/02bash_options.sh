# ${bashrcdir}/02bash_options.sh
# $Id$

## Shell options

# The user file-creation mask is set to MODE.
if [ $UID -gt 99 ] &&
   [ "$(id -un)" = "$(id -gn)" ]
then 
  umask 0002
else
  umask 0022
fi

# Do not produce core dumps
ulimit -c 0

# Make bash check its window size after a process completes
shopt -s checkwinsize

# The source (.) builtin uses the value of PATH to find the
# directory containing the file supplied as an argument.
shopt -u sourcepath

# The history list is appended to the file named by the value
# of the HISTFILE variable when the shell exits, rather than
# overwriting the file.
shopt -s histappend

# The results of history substitution are not immediately
# passed to the shell parser.
shopt -s histverify

# Bash will not attempt to search the PATH for possible
# completions when completion is attempted on an empty line.
shopt -s no_empty_cmd_completion

# Bash attempts to save all lines of a multiple-line command
# in the same history entry.
shopt -s cmdhist

# Multi-line commands are saved to the history with embedded
# newlines rather than using semicolon separators where possible.
shopt -s lithist


# *eof*
