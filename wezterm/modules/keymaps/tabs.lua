local wezterm = require 'wezterm'
local act = wezterm.action

---@type Key[]
return {
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
}
