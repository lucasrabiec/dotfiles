#!/bin/bash

# Create a Tmux Dev Layout with editor, terminal and an AI tool
# Usage: _nt_layout <tool> [run-editor: yes|no]
_nt_layout() {
  local tool="$1"
  local run_editor="${2:-no}"

  [[ -z $TMUX ]] && {
    echo "You must start tmux to use this layout."
    return 1
  }

  local current_dir="${PWD}"
  local editor_pane

  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window horizontally - left 75%, right 25% (new pane becomes active)
  tmux split-window -h -p 25 -t "$editor_pane" -c "$current_dir"

  # Run the AI tool in the new right pane (currently active)
  tmux send-keys "$tool" C-m

  # Focus editor pane
  tmux select-pane -t "$editor_pane"

  tmux split-window -v -p 15 -c "$current_dir"

  # Run nvim in top pane and focus it
  [[ $run_editor == yes ]] && tmux send-keys -t "$editor_pane" "$EDITOR" C-m
  tmux select-pane -t "$editor_pane"
}

# Editor, terminal and opencode
# Usage: nto
nto() { _nt_layout opencode no; }

# Editor, terminal and claude
# Usage: ntc
ntc() { _nt_layout claude yes; }
