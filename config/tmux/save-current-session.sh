#!/usr/bin/env bash
# 保存当前 session 到独立快照目录
# 用法：在 tmux 内 prefix + 自定义快捷键触发
# 遵循 tmux-resurrect 的恢复目录优先级

# 1) 优先使用 tmux-resurrect 的配置值
SAVE_DIR="$(tmux show -gqv @resurrect-dir 2>/dev/null)"

# 2) 回退到 tmux-resurrect 常见默认目录
if [[ -z "$SAVE_DIR" ]]; then
	SAVE_DIR="${TMUX_TMPDIR:-$HOME/.tmux}/resurrect"
fi

mkdir -p "$SAVE_DIR"

CURRENT_SESSION="$(tmux display-message -p '#S')"
TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
SAVE_FILE="${SAVE_DIR}/${CURRENT_SESSION}.txt"

# 构造与 resurrect 兼容的保存格式
# 格式：类型\t会话名\t窗口序号\t...（与原版 save.sh 一致）
{
	# state 行：记录当前活跃 session
	echo -e "state\t${CURRENT_SESSION}\t${CURRENT_SESSION}"

	# window 行：记录每个窗口的布局
	tmux list-windows -t "$CURRENT_SESSION" \
		-F "window\t#{session_name}\t#{window_index}\t:#{window_name}\t#{window_active}\t:#{window_flags}\t#{window_layout}"

	# pane 行：记录每个 pane 的详细信息
	tmux list-panes -t "$CURRENT_SESSION" \
		-F "pane\t#{session_name}\t#{window_index}\t#{window_active}\t:#{window_flags}\t#{pane_index}\t#{pane_title}\t:#{pane_current_path}\t#{pane_active}\t#{pane_current_command}\t#{pane_pid}\t#{history_size}"
} >"$SAVE_FILE"

tmux display-message "Session '${CURRENT_SESSION}' saved!"
