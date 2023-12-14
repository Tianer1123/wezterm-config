local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- init size
config.initial_cols = 96
config.initial_rows = 24

-- 关闭时不需要确认
config.window_close_confirmation = 'NeverPrompt'

-- fonts
config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 10

-- color
config.enable_scroll_bar = true
config.window_padding ={ left = 10, right = 15, top = 0, bottom = 0 }

config.color_scheme ="GruvboxDarkHard"
local gruvbox_scheme = wezterm.color.get_builtin_schemes()['GruvboxDarkHard']
gruvbox_scheme.scrollbar_thumb = '#cccccc' -- 滚动条更明显
config.colors = gruvbox_scheme


-- tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true

-- background Opacity
config.window_background_opacity = 0.98

-- spawn a powershell in login mode
config.default_prog = {'powershell'}
-- launch_menu
config.launch_menu = {
    { label = 'PowerShell', args = {'powershell'}, },
    { label = '内网穿透', args = {'ssh', 'tianer@49.232.162.165', '-p', '8000'}, },
}

-- 取消所有默认的热键
config.disable_default_key_bindings = true
local act = wezterm.action
config.keys = {
    -- Ctrl+Shift+Tab 遍历 tab
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },

    -- F11 切换全屏
    { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },

    -- Ctrl+Shift++ 字体增大
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },

    -- Ctrl+Shift+- 字体减小
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },

    -- Ctrl+Shift+C 复制选中区域
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },

    -- Ctrl+Shift+N 新窗口
    { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },

    -- Ctrl+Shift+T 新 tab
    { key = 'T', mods = 'SHIFT|CTRL', action = act.ShowLauncher },

    -- Ctrl+Shift+Enter 显示启动菜单
    { key = 'Enter', mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },

    -- Ctrl+Shift+V 粘贴剪切板的内容
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },

    -- Ctrl+Shift+W 关闭 tab 且不进行确认
    { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = false } },

    -- Ctrl+Shift+PageUp 向上滚动一页
    { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },

    -- Ctrl+Shift+PageDown 向下滚动一页
    { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },

    -- Ctrl+Shift+UpArrow 向上滚动一行
    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(-1) },

    -- Ctrl+Shift+DownArrow 向下滚动一行
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(1) },

    -- ALT + - 横向切屏
    { key = [[-]] , mods = 'ALT', action = act.SplitVertical({ domain = 'CurrentPaneDomain' })},
    { key = [[\]] , mods = 'ALT', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' })},
    -- 在 panes 中移动
    { key = 'k', mods = 'CTRL|ALT', action = act.ActivatePaneDirection('Up') },
    { key = 'j', mods = 'CTRL|ALT', action = act.ActivatePaneDirection('Down') },
    { key = 'h', mods = 'CTRL|ALT', action = act.ActivatePaneDirection('Left') },
    { key = 'l', mods = 'CTRL|ALT', action = act.ActivatePaneDirection('Right') },
}


return config