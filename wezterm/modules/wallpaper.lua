local wezterm = require 'wezterm'

wezterm.GLOBAL.wallpaper_index = wezterm.GLOBAL.wallpaper_index or 1

---@class WallpaperHandler
---@field loaded boolean
---@field wallpaper_dir string
---@field wallpapers string[]
---@field load_wallpapers fun(self: WallpaperHandler?, path: string?): WallpaperHandler
---@field pick_random fun(): string?
---@field set_next fun(window: Window): nil
---@field set_prev fun(window: Window): nil
---@field set_at fun(window: Window, index: integer): nil
---@field init fun(config: Config): nil

---@class WallpaperHandler
local M = {}

M.loaded = false
M.wallpaper_dir = wezterm.config_dir .. '/assets/wallpapers/'
M.wallpapers = {}

function M.init(config)
    local curr_wall = M.wallpapers[1]
    local curr_idx = wezterm.GLOBAL.wallpaper_index

    if curr_idx then
        curr_wall = M.wallpapers[curr_idx]
    else
        local rand = M.pick_random()
        if rand then curr_wall = rand end
    end

    config.window_background_image = curr_wall
    config.window_background_opacity = 0.6
end

---@param path string?
function M:load_wallpapers(path)
    if M.loaded then return self end

    if path then M.wallpaper_dir = path end

    local files = wezterm.read_dir(M.wallpaper_dir)

    for _, file in ipairs(files) do
        if file:match('%.jpg$') or file:match('%.jpeg$') or file:match('%.png$') or file:match('%.webp$') then
            table.insert(M.wallpapers, file)
        end
    end

    M.loaded = true
    return self
end

function M.pick_random()
    if M.loaded == false then
        M.load_wallpapers(nil)
    end

    if #M.wallpapers <= 0 then return nil end

    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()

    local rand_idx = math.random(#M.wallpapers)
    wezterm.GLOBAL.wallpaper_index = rand_idx

    return M.wallpapers[rand_idx]
end

function M.set_next(window)
    local curr_idx = wezterm.GLOBAL.wallpaper_index or 1
    local next_idx = (curr_idx % #M.wallpapers) + 1
    wezterm.GLOBAL.wallpaper_index = next_idx

    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.wallpapers[next_idx]

    window:set_config_overrides(overrides)
end

function M.set_prev(window)
    local curr_idx = wezterm.GLOBAL.wallpaper_index or 1
    local prev_idx = ((curr_idx - 2) % #M.wallpapers) + 1
    wezterm.GLOBAL.wallpaper_index = prev_idx

    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.wallpapers[prev_idx]

    window:set_config_overrides(overrides)
end

function M.set_at(window, index)
    if index < 1 or index > #M.wallpapers then return end

    wezterm.GLOBAL.wallpaper_index = index

    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.wallpapers[index]

    window:set_config_overrides(overrides)
end

return M
