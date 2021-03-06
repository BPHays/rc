# this file is processed on each interactive invocation of bash

# avoid problems with scp -- don't process the rest of the file if non-interactive
[[ $- != *i* ]] && return

PS1="`shorthostname` \! $ "
HISTSIZE=50

alias mail=mailx
export PATH=${PATH}:/p/andriod-sdk/tools
export PATH=${PATH}:/p/andriod-sdk/platform-tools
export PATH=${PATH}:/p/android-sdk/tools
export PATH=${PATH}:/p/android-sdk/platform-tools

alias la="ls -a"
