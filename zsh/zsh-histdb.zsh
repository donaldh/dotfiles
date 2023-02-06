HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
source $HOME/git/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook
