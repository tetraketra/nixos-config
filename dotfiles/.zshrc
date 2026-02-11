HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
setopt autocd extendedglob notify
bindkey -e
zstyle :compinstall filename '/home/tetraketra/.zshrc'
autoload -Uz compinit
compinit
