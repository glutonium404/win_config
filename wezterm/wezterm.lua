local wezterm = require 'wezterm' ---@type Wezterm
local config = wezterm.config_builder() ---@type Config

config.default_domain = 'WSL:Ubuntu'
config.front_end = "WebGpu"
-- config.webgpu_preferred_adapter = wezterm.gui.enumerate_gpus()[2]

require("modules.status_bar.status_bar").apply_to_config(config)
require("modules.keymaps").apply_to_config(config)

config.font_size = 12.0

config.window_decorations = 'RESIZE'
config.color_scheme_dirs = { wezterm.config_dir .. '/modules/colors' }
config.color_scheme = 'MyTheme1'
config.win32_system_backdrop = "Acrylic"

config.inactive_pane_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
}

config.window_background_image = wezterm.config_dir .. '/assets/wallpapers/black_gradient.png'
config.window_background_opacity = 0.5

config.window_padding = {
    top = "0.5cell",
    bottom = 0,
    left = "1.5cell",
    right = "0.5cell"
}

config.initial_cols = 120 -- Width (default is usually 80)
config.initial_rows = 35  -- Height (default is usually 24)

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.audible_bell = 'Disabled'

return config
