local wezterm = require "wezterm"

wezterm.on('format-tab-title', function(tab, _, _, _, _, _)
  local palette = {
    '#849dc4',
    '#80c49d',
    '#ffd780',
    '#f28fad',
    '#aca6ff',
    '#e5c890',
  }

  local color = palette[(tab.tab_index % #palette) + 1]
  local index = tab.tab_index + 1

  if tab.is_active then
    return {
      { Background = { Color = 'none' } },
      { Foreground = { Color = color } },
      { Text = ' ' },
      { Background = { Color = color } },
      { Foreground = { Color = 'black' } },
      { Text = ' ' .. index .. ' ' },
      { Background = { Color = 'none' } },
      { Foreground = { Color = color } },
      { Text = ' ' },
    }
  else -- 
    return {
      { Background = { Color = 'none' } },
      { Foreground = { Color = color } },
      { Text = ' ' .. index .. ' ' },
    }
  end
end)
