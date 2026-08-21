local wezterm = require 'wezterm'
local act = wezterm.action
local wall_handler = require('modules.wallpaper') ---@type WallpaperHandler
local M = {}

local function merge_keys(...)
  local result = {}
  for _, key_list in ipairs({...}) do
    for _, key_map in ipairs(key_list) do
      table.insert(result, key_map)
    end
  end
  return result
end

function M.apply_to_config(config)
  config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = merge_keys(
    require 'modules.keymaps.panes',
    require 'modules.keymaps.tabs',
    require 'modules.keymaps.wallpaper',

    -- =========================================================================
    -- COPY MODE
    -- =========================================================================
    {{ key = 'v', mods = 'LEADER', action = act.ActivateCopyMode }}
  )
end

return M
