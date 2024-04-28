set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# set -gx PATH bin $PATH
# set -gx PATH ~/bin $PATH
# set -gx PATH ~/.local/bin $PATH

# eza
if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end
