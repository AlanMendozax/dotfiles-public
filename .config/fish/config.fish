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
alias lg lazygit
command -qv nvim && alias vim nvim

# eza
if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

starship init fish | source
enable_transience
