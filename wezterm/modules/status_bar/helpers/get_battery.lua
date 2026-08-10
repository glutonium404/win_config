local wezterm = require 'wezterm'

local M = {}

function M.battery(window)
  local state_icons = {
    charging = {
      '󰂎 ', '󰢜 ', '󰂆 ', '󰂇 ', '󰂈 ', '󰢝 ', '󰂉 ', '󰢞 ', '󰂊 ', '󰂋 ', '󰂅 '
    },
    discharging = {
      '󰂎 ', '󰁺 ', '󰁻 ', '󰁼 ', '󰁽 ', '󰁾 ', '󰁿 ', '󰂀 ', '󰂁 ', '󰂂 ', '󰁹 '
    },
  }

  local battery_list = wezterm.battery_info()

  local palette = window:effective_config().resolved_palette
  local terminal_white  = palette.foreground

  local icon = '󰂑 '
  local percent_str = ' %'
  local icon_color = '#f28fad'

  if battery_list and battery_list[1] then
    local b = battery_list[1]
    local percent = b.state_of_charge * 100

    local state = "discharging"
    if b.state == "Charging" or b.state == "Full" then
      state = "charging"
    end

    local idx = math.floor(percent / 10) + 1
    idx = math.max(1, math.min(11, idx))

    icon = state_icons[state][idx]
    percent_str = string.format('%.0f%%', percent)

    if b.state == 'Charging' or b.state == 'Full' then
      icon_color = '#80c49d'
    elseif percent < 20 then
      icon_color = '#f28fad'
    elseif percent < 50 then
      icon_color = '#ffd780'
    else
      icon_color = '#89b4fa'
    end
  end

  local full_text = '  ' .. icon .. percent_str
  local visual_width = wezterm.column_width(full_text)

  local format_items = {
    { Foreground = { Color = icon_color } },
    { Text = '  ' .. icon },
    'ResetAttributes',
    { Foreground = { Color = terminal_white } },
    { Text = percent_str },
    'ResetAttributes',
  }

  return format_items, visual_width
end

return M
