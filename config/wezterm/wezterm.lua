local wezterm = require("wezterm")

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
	"₁₀",
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

local launch_menu = {}

local ssh_cmd = { "ssh" }
-- windows powershell
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	ssh_cmd = { "powershell.exe", "ssh" }
	table.insert(launch_menu, {
		label = "PowerShell Core",
		args = { "pwsh.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "NyaGOS",
		args = { "nyagos.exe", "--glob" },
	})
end
-- ssh config
local ssh_config_file = wezterm.home_dir .. "/.ssh/config"
local f = io.open(ssh_config_file)
if f then
	local line = f:read("*l")
	while line do
		if line:find("Host ") == 1 then
			local host = line:gsub("Host ", "")
			table.insert(launch_menu, {
				label = "SSH " .. host,
				args = { "ssh", host },
			})
		end
		line = f:read("*l")
	end
	f:close()
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#57606f"
	local background = "#a4b0be"
	local foreground = "#2f3542"
	local dim_foreground = "#3A3A3A"

	if tab.is_active then
		background = "#70a1ff"
		foreground = "#1C1B19"
	elseif hover then
		background = "#1e90ff"
		foreground = "#1C1B19"
	end

	local edge_foreground = background
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon

	if exec_name == "nu" then
		title_with_icon = NU_ICON .. " NuShell"
	elseif exec_name == "pwsh" then
		title_with_icon = PS_ICON .. " PS"
	elseif exec_name == "cmd" then
		title_with_icon = CMD_ICON .. " CMD"
	elseif exec_name == "elvish" then
		title_with_icon = ELV_ICON .. " Elvish"
	elseif exec_name == "wsl" or exec_name == "wslhost" then
		title_with_icon = WSL_ICON .. " WSL"
	elseif exec_name == "nyagos" then
		title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
	elseif exec_name == "yori" then
		title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
	elseif exec_name == "nvim" then
		title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
		title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
	elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
		title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
	elseif exec_name == "btm" or exec_name == "ntop" then
		title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
	elseif exec_name == "python" or exec_name == "hiss" then
		title_with_icon = PYTHON_ICON .. " " .. exec_name
	elseif exec_name == "node" then
		title_with_icon = NODE_ICON .. " " .. exec_name:upper()
	elseif exec_name == "deno" then
		title_with_icon = DENO_ICON .. " " .. exec_name:upper()
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	else
		title_with_icon = HOURGLASS_ICON .. " " .. exec_name
	end
	if pane_title:match("^Administrator: ") then
		title_with_icon = title_with_icon .. " " .. ADMIN_ICON
	end
	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end
	local id = SUB_IDX[tab.tab_index + 1]
	local pid = SUP_IDX[tab.active_pane.pane_index + 1]
	local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Text = title },
		{ Foreground = { Color = dim_foreground } },
		{ Text = pid },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = "Normal" } },
	}
end)

wezterm.on("update-right-status", function(window)
	local hostname = wezterm.hostname()
	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end
	window:set_right_status(wezterm.format({
		{ Text = bat .. " | " .. hostname .. " | " .. date },
	}))
end)

-- mouse bindings
local mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
	},
	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = "OpenLinkAtMouseCursor",
	},
}

-- key bindings
local keybind = {
	{
		key = "f",
		mods = "SUPER|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	-- CTRL-SHIFT-l activates the debug overlay
	{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	--{
	--  key = 'a',
	--  mods = 'LEADER|CTRL',
	--  action = wezterm.action.SendString '\x01',
	--},
	-- LEADER + | split panel
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Resize
	{
		key = "LeftArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action({
			AdjustPaneSize = { "Left", 5 },
		}),
	},
	{
		key = "DownArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action({
			AdjustPaneSize = { "Down", 5 },
		}),
	},
	{
		key = "UpArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action({
			AdjustPaneSize = { "Up", 5 },
		}),
	},
	{
		key = "RightArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action({
			AdjustPaneSize = { "Right", 5 },
		}),
	},
	-- Copy/paste buffer
	{
		key = "[",
		mods = "CTRL",
		action = "ActivateCopyMode",
	},
	{
		key = "]",
		mods = "CTRL",
		action = "QuickSelect",
	},
}

-- set window mini maximize on startup
wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().active
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local inner_x, inner_y = math.modf(screen.width * 0.8), math.modf(screen.height * 0.8)
	window:gui_window():set_inner_size(inner_x, inner_y)
	window:gui_window():set_position(
		math.modf(screen.width / 2) - math.modf(inner_x / 2),
		math.modf(screen.height / 2) - math.modf(inner_y / 2) + 50 -- is MacOS menus bar
	)
end)

return {
	window_frame = {
		font_size = 14.0,
	}, -- needed only if using fancy tab
	launch_menu = launch_menu,
	mouse_bindings = mouse_bindings,
	native_macos_fullscreen_mode = true,
	font = wezterm.font_with_fallback({
		"CaskaydiaCove Nerd Font Propo",
		"CaskaydiaCove Nerd Font",
		"JetBrainsMono Nerd Font Propo",
		"JetBrainsMono Nerd Font",
		"CaskaydiaCove Nerd Font Mono",
		"JetBrainsMono Nerd Font Mono",
		"DejaVu Sans Mono",
		"Consolas",
	}),
	font_size = 16.0,
	line_height = 1.2,
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 0.9,
		brightness = 0.8,
	},
	--color_scheme = "Dracula",
	color_scheme = "Catppuccin Macchiato",
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 50,
	window_padding = {
		left = 2,
		right = 2,
		top = 3,
		bottom = 1,
	},
	initial_cols = 160,
	initial_rows = 42,
	window_background_opacity = 0.8,
	text_background_opacity = 0.95,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = "a", mods = "SUPER", timeout_milliseconds = 1000 },
	keys = keybind,
}
