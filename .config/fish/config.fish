# Clear fish shell welcome message
set fish_greeting ""

# Fish colors
set -g fish_color_param 2AA198
set -g fish_color_redirection 2AA198
set -g fish_color_quote B58900
set -g fish_color_comment DC322F
set -g fish_color_autosuggestion 808080
set -g fish_color_end 859900
set -g fish_color_cwd 859900
set -g __fish_git_prompt_color_cleanstate 859900
set -g __fish_git_prompt_color_dirtystate 268BD2
set -g __fish_git_prompt_color_stagedstate B58900
set -g __fish_git_prompt_color_branch 6C71C4 --bold

# Aliases
alias g git
command -qv nvim && alias vim nvim

# Neovim as default editor
set -gx EDITOR nvim
