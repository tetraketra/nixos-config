autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b'
zstyle ':vcs_info:*' enable git

alias du="du-dust"
alias dust="du-dust"
alias neofetch="fastfetch"
alias vim="neovide"

precmd() {
    vcs_info
    PS1="%{%F{156}%}%n%{%F{156}%}%{%f%}:%{%F{39}%}%1:%~%{%f%} %{%F{212}%}${vcs_info_msg_0_}%{%f%}"$'\n'"$ "
}