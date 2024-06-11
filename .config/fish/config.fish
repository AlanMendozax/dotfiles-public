if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
set -x TERM xterm-256color

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

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Enviroment variables for python packages
#set -x LDFLAGS "-lm -lcompiler_rt"
#set -x LDFLAGS "-lpython3.11"
#set -x CFLAGS "-Wno-deprecated-declarations -Wno-unreachable-code -Wno-int-conversion"
#set -x CFLAGS "$CFLAGS -U__ANDROID_API__ -D__ANDROID_API__=31"
#set -x CFLAGS "$CFLAGS -U__ANDROID_API__ -D__ANDROID_API__=34"
set -x MATHLIB m
#set -x LD_PRELOAD "$LD_PRELOAD:/data/data/com.termux/files/usr/lib/libpython3.11.so.1.0"
set -x KERAS_BACKEND tensorflow

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

starship init fish | source
enable_transience
