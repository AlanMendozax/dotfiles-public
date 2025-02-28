set fish_greeting ""

# theme
set -g theme_color_scheme terminal-dark

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

# XDG locations
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Java
set -g JAVA_HOME ../usr/lib/jvm/java-17-openjdk

# Go
set -g GOPATH $HOME/go

# This code checks if TMUX is not active, and if so,
# It adds directories to the PATH, ensuring they are available in the terminal
# Avoiding duplicates in PATH.
if not set -q TMUX
    set -x PATH $PATH $GOPATH/bin $JAVA_HOME/bin node_modules/.bin
end

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

