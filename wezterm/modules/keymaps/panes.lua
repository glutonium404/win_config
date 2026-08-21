local wezterm = require 'wezterm'
local act = wezterm.action

---@type Key[]
return {
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
}
