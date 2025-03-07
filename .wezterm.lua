-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.initial_cols = 120
config.initial_rows = 40

-- fonts default is jetbrains mono
-- wezterm ls-fonts --list-system
-- config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular" })
-- config.font = wezterm.font("Fira Code", { weight = "Regular" })
-- config.font = wezterm.font("Maple Mono CN", { weight = "Light" })
config.font = wezterm.font("Maple Mono CN")
-- config.font = wezterm.font("Intel One Mono")Consolas
-- config.font = wezterm.font("Consolas")
config.font_size = 11   -- 200%
-- config.line_height = 1.2

-- default open wsl2
-- config.default_domain = "WSL:Ubuntu-22.04"

-- performence
-- fps settings
config.max_fps = 120

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

-- ui
config.enable_scroll_bar = true
config.scrollback_lines = 10000

config.window_padding = {
	left = 3,
	right = 3,
	top = 10,
	bottom = 3,
}

-- background Opacity
-- config.window_background_opacity = 0.95

-- keybindings
config.disable_default_key_bindings = true
local act = wezterm.action
config.keys = {
	-- Ctrl+Shift+Tab 遍历 tab
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },

	-- F11 切换全屏
	{ key = "F11", mods = "NONE", action = act.ToggleFullScreen },

	-- Ctrl+Shift++ 字体增大
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },

	-- Ctrl+Shift+- 字体减小
	{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },

	-- Ctrl+Shift+C 复制选中区域
	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },

	-- Ctrl+Shift+V 粘贴剪切板的内容
	{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },

	-- Ctrl+Shift+N 新窗口
	{ key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },

	-- Ctrl+Shift+T 新 tab
	{ key = "T", mods = "SHIFT|CTRL", action = act.ShowLauncher },

	-- Ctrl+Shift+Enter 显示启动菜单
	{ key = "Enter", mods = "SHIFT|CTRL", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS|LAUNCH_MENU_ITEMS" }) },

	-- Ctrl+Shift+W 关闭 tab 且不进行确认
	{ key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = false }) },

	-- Ctrl+Shift+PageUp 向上滚动一页
	{ key = "PageUp", mods = "SHIFT|CTRL", action = act.ScrollByPage(-1) },

	-- Ctrl+Shift+PageDown 向下滚动一页
	{ key = "PageDown", mods = "SHIFT|CTRL", action = act.ScrollByPage(1) },

	-- Ctrl+Shift+UpArrow 向上滚动一行
	{ key = "UpArrow", mods = "SHIFT|CTRL", action = act.ScrollByLine(-1) },

	-- Ctrl+Shift+DownArrow 向下滚动一行
	{ key = "DownArrow", mods = "SHIFT|CTRL", action = act.ScrollByLine(1) },

	-- ALT + - 横向切屏
	{ key = [[-]], mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = [[\]], mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- 在 panes 中移动
	{ key = "k", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },

	-- not clear the buffer
	{
		key = "M",
		mods = "SHIFT|CTRL",
		action = wezterm.action_callback(function(window, pane)
			-- scroll to bottom in case you aren't already
			window:perform_action(wezterm.action.ScrollToBottom, pane)

			-- get the current height of the viewport
			local height = pane:get_dimensions().viewport_rows

			-- build a string of new lines equal to the viewport height
			local blank_viewport = string.rep("\r\n", height)

			-- inject those new lines to push the viewport contents into the scrollback
			pane:inject_output(blank_viewport)

			-- send an escape sequence to clear the viewport (CTRL-L)
			pane:send_text("\x0c")
		end),
	},

	--  rename the table
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
