#!/bin/bash

# the name of your primary tmux session
SESSION=home

# if the session is already running, just attach to it.
tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
    echo "Session $SESSION already exists. Attaching."
    sleep 1
    tmux attach -t $SESSION
    exit 0;
fi

# window 1, mutt and irssi
tmux new-session -d -s $SESSION 
tmux send-keys "irssi"
tmux rename-window -t $SESSION:0 mail+irc
tmux split-window -t $SESSION:0 -h -p 40
tmux send-keys "mutt"

# window 2, vi vimrc
tmux new-window -t $SESSION:1 -d -n config 
tmux send-keys -t $SESSION:1 'cd ~/.vim && vi vimrc'

# window 3, conky stuff
tmux new-window -t $SESSION:2 -d -n conky
tmux send-keys -t $SESSION:2 'cd ~/.conky && vi conkyrc'
tmux split-window -t $SESSION:2 -h -p 25 
tmux send-keys 'cd ~/.conky && conky -c conkyrc'
tmux split-window -t $SESSION:2 -v
tmux send-keys 'cd ~/.conky && conky -c calendarrc'

# window 4, street fighter notes
tmux new-window -t $SESSION:3 -d -n ssf4
tmux send-keys -t $SESSION:3 'cd ~/working/game_info/ssf4 && vi +vs cammy.txt'

# attach to mail+irc window
tmux select-window -t $SESSION:0
tmux attach -t $SESSION
