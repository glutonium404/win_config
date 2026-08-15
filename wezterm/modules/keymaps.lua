local wezterm = require 'wezterm'
local act = wezterm.action
local wall_handler = require('modules.wallpaper') ---@type WallpaperHandler
local M = {}

function M.apply_to_config(config)
  config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {
    -- =========================================================================
    -- SPLIT PANES
    -- =========================================================================
    { key = 'UpArrow',    mods = 'LEADER|ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'DownArrow',  mods = 'LEADER|ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'RightArrow', mods = 'LEADER|ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'LeftArrow',  mods = 'LEADER|ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    { key = 'k',          mods = 'LEADER|ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'j',          mods = 'LEADER|ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'h',          mods = 'LEADER|ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'l',          mods = 'LEADER|ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- =========================================================================
    -- RESIZE PANES
    -- =========================================================================
    { key = 'LeftArrow',  mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'RightArrow', mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'UpArrow',    mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'DownArrow',  mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Down', 5 } },

    { key = 'h',          mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l',          mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'k',          mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'j',          mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Down', 5 } },

    -- =========================================================================
    -- NAVIGATE PANES
    -- =========================================================================
    { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

    { key = 'h',          mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'l',          mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'k',          mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'j',          mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

    -- =========================================================================
    -- SWITCH TABS
    -- =========================================================================
    { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },

    { key = 'h',          mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'l',          mods = 'CTRL', action = act.ActivateTabRelative(1) },

    -- =========================================================================
    -- MOVE TABS
    -- =========================================================================
    { key = 'LeftArrow',  mods = 'CTRL', action = act.MoveTabRelative(-1) },
    { key = 'RightArrow', mods = 'CTRL', action = act.MoveTabRelative(1) },

    -- =========================================================================
    -- NEW TABS
    -- =========================================================================
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

    -- =========================================================================
    -- DELETE CURRENT TABS
    -- =========================================================================
    { key = 'd', mods = 'CTRL|ALT',   action = act.CloseCurrentTab { confirm = true }},

    -- =========================================================================
    -- COPY MODE
    -- =========================================================================
    { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },

    -- =========================================================================
    -- CHANGE WALLPAPERS
    -- =========================================================================
    { key = ']', mods = 'LEADER',   action = wezterm.action_callback(function (window)
      wall_handler.set_next(window)
    end) },

    { key = '[', mods = 'LEADER',   action = wezterm.action_callback(function (window)
      wall_handler.set_prev(window)
    end) },

    {
      key = [[\]],
      mods = 'LEADER',
      action = wezterm.action_callback(function(window, pane)
        local choices = {}

        for index, value in ipairs(wall_handler.wallpapers) do
          local filename = value:match("([^/\\]+)$")
          table.insert(choices, {
            id = tostring(index),
            -- Custom formatted row layout
            label = wezterm.format {
              { Foreground = { Color = '#7aa2f7' } },
              { Text = string.format("%2d.", index) },
              'ResetAttributes',
              {Text = '  '},
              { Foreground = { Color = '#7aa2f7' } },
              { Text = '󰋩 ' },
              { Attribute = { Intensity = 'Bold' } },
              { Foreground = { Color = '#c0caf5' } },
              { Text = ' ' .. filename },
            },
          })
        end

        window:perform_action(
          act.InputSelector {
            title = ' 󰸉  Select Wallpaper',
            choices = choices,
            fuzzy = true,

            description = wezterm.format {
              { Attribute = { Intensity = 'Bold' } },
              { Foreground = { Color = '#bb9af7' } },
              { Text = ' 󰸉  WALLPAPER SELECTOR' },
              'ResetAttributes',
              { Foreground = { Color = '#565f89' } },
              { Text = '  │ Choose a background image\n' },
            },

            fuzzy_description = wezterm.format {
              { Attribute = { Intensity = 'Bold' } },
              { Foreground = { Color = '#7aa2f7' } },
              { Text = '   Filter: ' },
              'ResetAttributes',
            },

            action = wezterm.action_callback(function(window, pane, id, label)
              if not id then return end

              local is_id = tonumber(id)
              if is_id then
                wall_handler.set_at(window, math.floor(is_id))
              end
            end),
          },
          pane
        )
      end),
    }
  }
end

return M
