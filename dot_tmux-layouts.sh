#!/bin/bash

# Create a Tmux Dev Layout with editor, terminal and opencode
# Usage: nto
nto() {
  [[ -z $TMUX ]] && {
    echo "You must start tmux to use nto."
    return 1
  }

  local current_dir="${PWD}"
  local editor_pane

  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window horizontally - left 75%, right 25% (new pane becomes active)
  tmux split-window -h -p 25 -t "$editor_pane" -c "$current_dir"

  # Run claude in the new right pane (currently active)
  tmux send-keys "opencode" C-m

  # Focus editor pane
  tmux select-pane -t "$editor_pane"

  tmux split-window -v -p 15 -c "$current_dir"

  # Run nvim in top pane and focus it
  # tmux send-keys -t "$editor_pane" "$EDITOR" C-m
  tmux select-pane -t "$editor_pane"
}

# Create a Tmux Dev Layout with editor, terminal and claude
# Usage: ntc
ntc() {
  [[ -z $TMUX ]] && {
    echo "You must start tmux to use nto."
    return 1
  }

  local current_dir="${PWD}"
  local editor_pane

  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window horizontally - left 75%, right 25% (new pane becomes active)
  tmux split-window -h -p 25 -t "$editor_pane" -c "$current_dir"

  # Run claude in the new right pane (currently active)
  tmux send-keys "claude" C-m

  # Focus editor pane
  tmux select-pane -t "$editor_pane"

  tmux split-window -v -p 15 -c "$current_dir"

  # Run nvim in top pane and focus it
  tmux send-keys -t "$editor_pane" "$EDITOR" C-m
  tmux select-pane -t "$editor_pane"
}
