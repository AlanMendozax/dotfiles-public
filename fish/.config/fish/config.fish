# Clear fish shell welcome message
set fish_greeting ""

set -gx TERM xterm-256color

# Aliases
alias g git
command -qv nvim && alias vim nvim

# Neovim as default editor
set -gx EDITOR nvim
