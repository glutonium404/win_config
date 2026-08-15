local wezterm = require("wezterm")

local M = {}

require("modules.status_bar.update_status")
local p = require("modules.status_bar.format_tab_title") ---@type ColorPalette

---@param config Config
function M.apply_to_config(config)
  config.tab_bar_at_bottom = false
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.colors = config.colors or {}

  config.colors.tab_bar = { background = 'none' }

  config.tab_bar_style = {
    new_tab = wezterm.format {
      { Background = { Color = 'none' } },
      { Foreground = { Color = p.current_palette[1] } },
      { Text = ' [[+]] ' },
    },
    new_tab_hover = ""
  }

  -- add physical space directly above the top tab line
  config.window_frame = config.window_frame or {}
  config.window_frame.border_top_height = '0.5cell'
  config.window_frame.border_top_color = 'none'
end

return M

