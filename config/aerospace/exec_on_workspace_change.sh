#!/bin/zsh

# 空 window 布局清理 fix issue 1615
function close_empty_window() {
	for id in $(aerospace list-windows --all | grep -e ".*|.*| $" | awk '{print $1}'); do
		aerospace close --window-id "$id"
	done
}

# 粘性窗口 fix issue 2
function skicky_float_window() {
	# Get current workspace
	current_workspace=$(aerospace list-workspaces --focused)

	need_move_app="(uTools)"

	# Move app window to current workspace
	aerospace list-windows --all | grep -E "${need_move_app}" | awk '{print $1}' | while read window_id; do
		if [ -n "${window_id}" ]; then
			aerospace move-node-to-workspace --window-id "${window_id}" "${current_workspace}"
		fi
	done
}

close_empty_window
skicky_float_window
