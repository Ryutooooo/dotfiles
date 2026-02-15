#!/bin/bash
# Usage: apply-session-color.sh <session_name>

SESSION_NAME="$1"
COLOR_SCRIPT="$HOME/.tmux/define-session-color.sh"

BASE=$("$COLOR_SCRIPT" "$SESSION_NAME" base)
LIGHT1=$("$COLOR_SCRIPT" "$SESSION_NAME" light1)
LIGHT2=$("$COLOR_SCRIPT" "$SESSION_NAME" light2)
LIGHT3=$("$COLOR_SCRIPT" "$SESSION_NAME" light3)
LIGHT4=$("$COLOR_SCRIPT" "$SESSION_NAME" light4)
FG=$("$COLOR_SCRIPT" "$SESSION_NAME" fg)
FG_LIGHT=$("$COLOR_SCRIPT" "$SESSION_NAME" fg_light)

tmux set-option -t "$SESSION_NAME" status-style "bg=$BASE"

# status-left (with half-circle symbols)
tmux set-option -t "$SESSION_NAME" status-left "#[fg=$LIGHT4]#[bg=colour232]#[bg=$LIGHT4]#[fg=$FG_LIGHT] #S #[fg=$LIGHT4]#[bg=colour232]"

# window-status-format (inactive window)
tmux set-window-option -t "$SESSION_NAME" window-status-format "#[fg=$LIGHT3]#I#[fg=$LIGHT1]:#[fg=$LIGHT4]#W#[fg=$LIGHT3]#F"

# window-status-current-format (active window)
tmux set-window-option -t "$SESSION_NAME" window-status-current-format "#[fg=$LIGHT2]#[bg=colour232]#[fg=colour190]#[bg=$LIGHT2]#I#[fg=colour249]:#[fg=colour255]#W#[fg=$LIGHT2]#[bg=colour232]"

# status-right (with half-circle symbols, 幅120未満で省略)
tmux set-option -t "$SESSION_NAME" status-right "#{?#{>=:#{client_width},120},#[bg=colour232]#[fg=$LIGHT1]#[bg=$LIGHT1]#[fg=$FG] CPU:#($HOME/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh) #[bg=$LIGHT1]#[fg=$LIGHT2]#[bg=$LIGHT2]#[fg=$FG] Mem:#($HOME/.tmux/memory_info.sh 'usage')/#($HOME/.tmux/memory_info.sh) #[bg=$LIGHT2]#[fg=$LIGHT3]#[bg=$LIGHT3]#[fg=$FG_LIGHT] Batt:#($HOME/.tmux/battery_info.sh) #[bg=$LIGHT3]#[fg=$LIGHT4]#[bg=$LIGHT4]#[fg=$FG_LIGHT] %Y/%m/%d %H:%M #[fg=$LIGHT4]#[bg=colour232],}"
