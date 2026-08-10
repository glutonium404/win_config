local wezterm = require 'wezterm'

local helper_path = "modules.status_bar.helpers"

wezterm.on('update-status', function(window, pane)
  window:set_right_status ''

  local mux_window = window:mux_window()
  if not mux_window then
    return
  end

  local tabs = mux_window:tabs()
  local active_tab = mux_window:active_tab()
  local total_tab_width = 0

  for _, t in ipairs(tabs) do
    local is_active = active_tab and (t:tab_id() == active_tab:tab_id())
    if is_active then
      -- Length of active pill format: "  #I  " -> 5 chars + index length
      total_tab_width = total_tab_width + #tostring(t:tab_id()) + 5
    else
      -- Length of inactive format: " #I " -> 2 chars + index length
      total_tab_width = total_tab_width + #tostring(t:tab_id()) + 2
    end
  end

  local window_dims = window:get_dimensions()
  local pane_dims = pane:get_dimensions()

  -- cell width in pixels: (pane pixel width) / (pane columns)
  local cell_width = pane_dims.pixel_width / pane_dims.cols

  -- full window width in columns: (total window pixel width) / (cell pixel width)
  local term_width = math.floor(window_dims.pixel_width / cell_width)

  if not term_width or term_width == 0 then
    term_width = 80
  end

  local bat_items, bat_info_visual_width = require(helper_path .. ".get_battery").battery(window)

  local half_screen = term_width / 2
  local half_tabs = total_tab_width / 2
  local padding_amount = math.max(0, math.floor(half_screen - half_tabs - bat_info_visual_width))

  table.insert(bat_items, 'ResetAttributes')
  table.insert(bat_items, { Text = string.rep(' ', padding_amount) })

  window:set_left_status(wezterm.format(bat_items))
end)

