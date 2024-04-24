if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

# eza
if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

# Go
set -g GOROOT ../usr/bin/go
set -gx PATH $GOROOT/bin $PATH
set -g GOPATH $HOME/go

starship init fish | source
enable_transience
