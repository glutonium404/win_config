local M = {}

require("modules.status_bar.update_status")
require("modules.status_bar.format_tab_title")

---@param config Config
function M.apply_to_config(config)
  config.tab_bar_at_bottom = false
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false

  config.colors = config.colors or {}

  config.colors.tab_bar = { background = 'none' }

  -- add physical space directly above the top tab line
  config.window_frame = config.window_frame or {}
  config.window_frame.border_top_height = '0.5cell'
  config.window_frame.border_top_color = 'none'
end

return M

