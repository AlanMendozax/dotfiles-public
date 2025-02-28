# Clear fish shell welcome message 
set fish_greeting ""

# Aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

# Neovim as default editor
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

# Avoid duplicates in PATH.
if not set -q TMUX
    set -x PATH $PATH $GOPATH/bin $JAVA_HOME/bin node_modules/.bin
end

# Eza
if type -q eza
  alias ll "eza -l -G --icons"
  alias lla "ll -a"
end

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0

# Selects the correct Fish shell configuration for your env
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
