set fish_greeting ""

# theme
#set -g theme_color_scheme terminal-dark
#set -g fish_prompt_pwd_dir_length 1
#set -g theme_display_user yes
#set -g theme_hide_hostname no
#set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

#set -gx PATH bin $PATH
#set -gx PATH ~/bin $PATH
#set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Eza
if type -q eza
  alias ll "eza -l -G --icons"
  alias lla "ll -a"
end

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        if test -d /data/data/com.termux
            source (dirname (status --current-filename))/config-termux.fish
        else
            source (dirname (status --current-filename))/config-linux.fish
        end
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
