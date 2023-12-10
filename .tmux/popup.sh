#!/bin/bash

tmuxpopup() {
	# toggle tmux popup window
	width='80%'
	height='80%'
	session=$(tmux display-message -p -F "#{session_name}")

	if [[ $session == *"popup"* ]]; then
		tmux detach-client
	else
		tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t popup || tmux new -s popup"
	fi
}

tmuxpopup
