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

# neovim as default editor
set -gx EDITOR nvim

# Java
set -gx JAVA_HOME ../usr/lib/jvm/java-17-openjdk
set -gx PATH $JAVA_HOME/bin $PATH

# Rust
set -gx PATH .cargo/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH
