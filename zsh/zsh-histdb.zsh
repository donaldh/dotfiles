HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
source $HOME/git/zsh-histdb/sqlite-history.zsh
source $HOME/git/zsh-histdb/histdb-interactive.zsh
autoload -Uz add-zsh-hook
bindkey '^r' _histdb-isearch
