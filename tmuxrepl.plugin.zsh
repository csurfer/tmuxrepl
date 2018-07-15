# This plugin creates a tmux session in REPL form so that the space for executing a command
# and where it gets executed are kept separate in the form as shown below.
#
#       ###############################################################################
#       #                                                                             #
#       #                                                                             #
#       #                                                                             #
#       #                            Execution Panel                                  #
#       #                                                                             #
#       #                                                                             #
#       #                                                                             #
#       ###############################################################################
#       #                                                                             #
#       #                            Command Panel                                    #
#       #                                                                             #
#       ###############################################################################

# Initializes a new window with the tmuxrepl setup.
function tmuxrepl () {
    tmux new-window && tmux split-window -v -p 10 && tmux send-keys -t bottom "_tmuxrepl_init" C-m
}

# Tmux REPL loop which takes full advantage of your zsh settings.
function _tmuxrepl_init () {
    while true; do
        local cmd
        vared -p ">> " cmd
        ([[ "$cmd" =~ ^cd ]] || [[ "$cmd" =~ \\.$ ]]) && eval "$cmd"
        tmux send-keys -t top "$cmd" C-m
        unset cmd
    done
}
