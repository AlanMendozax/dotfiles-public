# Clear fish shell welcome message
set fish_greeting ""

# Aliases
alias g git
command -qv nvim && alias vim nvim

# Neovim as default editor
set -gx EDITOR nvim
