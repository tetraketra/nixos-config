autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b'
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

PROMPT="%n@%m:%~:$vcs_info_msg_0_$ "