# Clear fish shell welcome message
set fish_greeting ""

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1

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
    set -x PATH $PATH $GOPATH/bin $JAVA_HOME/bin node_modules/.bin ~/.local/bin/
end

# Tmux
function tmux_status_update
    # Gets the number of windows in the current session
    set -l window_count (tmux list-windows | wc -l)

    # If there is only one window, use the simplified configuration
    if test $window_count -eq 1
        tmux set -g status-left ""
        tmux set -g status-right "#[fg=#586e75,bg=#000000] #(whoami)@#h:#S"
        tmux setw -g window-status-format " "
        tmux setw -g window-status-current-format " "
    else
        # Configuration for multiple windows
        tmux set -g status-style "fg=#586e75,bg=#000000"
        tmux setw -g window-status-activity-style "underscore,fg=#839496,bg=#000000"
        tmux setw -g window-status-separator ""
        tmux setw -g window-status-style "NONE,fg=#839496,bg=#000000"
        tmux setw -g window-status-format '#[fg=#333333,bg=#000000]#{pane_current_command}: #{b:pane_current_path} | #[fg=#000000,bg=#000000,nobold,nounderscore,noitalics]'
        tmux setw -g window-status-current-format '#[fg=#93a1a1, bg=#000000,bold]#{pane_current_command}: #{b:pane_current_path}#[fg=#b58900, bg=#000000,bold] | '
    end

    # Check if there is any panel running Neovim in the current session
    if tmux list-panes -F "#{pane_current_command}" | grep -q nvim
        tmux set-option -g status-position top
    else
        tmux set-option -g status-position bottom
    end
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
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
