local wezterm = require 'wezterm'
local act = wezterm.action
local wall_handler = require 'modules.wallpaper'

---@type Key[]
return {
    -- =========================================================================
    -- CHANGE WALLPAPERS
    -- =========================================================================
    {
        key = ']',
        mods = 'LEADER',
        action = wezterm.action_callback(function (window)
            wall_handler.set_next(window)
        end)
    },

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
