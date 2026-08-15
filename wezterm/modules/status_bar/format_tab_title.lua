local wezterm = require "wezterm"

---@class ColorPalette
---@field palettes string[][]
---@field current_palette string[]?

---@type ColorPalette
local M = {
  palettes = {
    { '#849dc4', '#80c49d', '#ffd780', '#f28fad', '#E5D1FA' },
    { '#E6F2DD', '#ffd780', '#B1D3B9', '#88BDA4', '#659287' },
    { '#FFD6A6', '#FFF0BE', '#FFB399', '#FF9A86', '#80c49d' },
    { '#FFD1DA', '#FBF3D1', '#DEDED1', '#C5C7BC', '#B6AE9F' },
    { '#ECF9FF', '#C4E1E6', '#A4CCD9', '#8DBCC7', '#EBFFD8' },
    { '#E5D1FA', '#FFDBAA', '#FFD1DA', '#F1F0E8', '#FFB399' },
  },
}

M.current_palette = M.palettes[math.random(#M.palettes)]

wezterm.on('format-tab-title', function(tab, _, _, _, _, _)
  local color = M.current_palette[(tab.tab_index % #M.current_palette) + 1]
  local index = tab.tab_index + 1
  local working_dir = tab.active_pane.foreground_process_name

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
  else
    return {
      { Background = { Color = 'none' } },
      { Foreground = { Color = color } },
      { Text = ' ' .. index .. ' ' },
    }
  end
end)

return M
