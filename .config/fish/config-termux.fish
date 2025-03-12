set -gx TERM xterm-256color

set -gx DISPLAY ":1"

if test -n "$TMUX"
    set -gx TERM screen-256color
end
