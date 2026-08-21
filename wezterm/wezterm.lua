local wezterm = require 'wezterm' ---@type Wezterm
local config = wezterm.config_builder() ---@type Config

config.default_domain = 'WSL:Ubuntu'
config.front_end = "WebGpu"
-- config.webgpu_preferred_adapter = wezterm.gui.enumerate_gpus()[2]

config.font_size = 12.0
config.adjust_window_size_when_changing_font_size = false

config.window_decorations = 'RESIZE'
config.color_scheme_dirs = { wezterm.config_dir .. '/modules/colors' }
config.color_scheme = 'MyTheme1'
config.win32_system_backdrop = "Acrylic"

config.inactive_pane_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
}

config.window_padding = {
    top = "0.5cell",
    bottom = 0,
    left = "1.5cell",
    right = "0.5cell"
}

config.initial_cols = 120
config.initial_rows = 35

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.audible_bell = 'Disabled'

config.colors = config.colors or {}
config.colors.selection_fg = '#7aa2f7'
config.colors.selection_bg = '#1a1b26'

require("modules.status_bar.status_bar").apply_to_config(config)
require("modules.keymaps.keymaps").apply_to_config(config)
require('modules.wallpaper'):load_wallpapers().init(config)

return config
