local wezterm = require 'wezterm'

wezterm.GLOBAL.wallpaper_index = wezterm.GLOBAL.wallpaper_index or 1

---@class WallpaperHandler
---@field loaded boolean
---@field wallpaper_dir string
---@field cache_dir string
---@field wallpapers string[]
---@field load_wallpapers fun(self: WallpaperHandler?, path: string?): WallpaperHandler
---@field pick_random fun(): string?
---@field set_next fun(window: Window): nil
---@field set_prev fun(window: Window): nil
---@field set_at fun(window: Window, index: integer): nil
---@field init fun(config: Config): nil
---@field save_to_cache fun(path: string): nil
---@field read_cache fun(): string?
---@field create_cache fun(): nil

---@class WallpaperHandler
local M = {}

M.loaded = false
M.wallpaper_dir = wezterm.config_dir .. '/assets/wallpapers'
M.cache_dir = wezterm.config_dir .. '/.cache'
M.wallpapers = {}

function M.init(config)
    if #M.wallpapers <= 0 then
        wezterm.log_error("no wallpapers loaded")
        return
    end

    local curr_wall = M.read_cache() or M.pick_random() or M.wallpapers[1]

    for idx, path in ipairs(M.wallpapers) do
        if path == curr_wall then
            wezterm.GLOBAL.wallpaper_index = idx
            break
        end
    end

    config.window_background_image = curr_wall
    config.window_background_opacity = 0.6
    M.save_to_cache(curr_wall)
end

---@param path string?
function M:load_wallpapers(path)
    if M.loaded then return self end

    if path then M.wallpaper_dir = path end

    local files = wezterm.read_dir(M.wallpaper_dir)

    for _, file in ipairs(files) do
        if file:lower():match('%.jpg$') or file:match('%.jpeg$') or file:match('%.png$') or file:match('%.webp$') then
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
    M.save_to_cache(M.wallpapers[next_idx])
end

function M.set_prev(window)
    local curr_idx = wezterm.GLOBAL.wallpaper_index or 1
    local prev_idx = ((curr_idx - 2) % #M.wallpapers) + 1
    wezterm.GLOBAL.wallpaper_index = prev_idx

    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.wallpapers[prev_idx]

    window:set_config_overrides(overrides)
    M.save_to_cache(M.wallpapers[prev_idx])
end

function M.set_at(window, index)
    if index < 1 or index > #M.wallpapers then return end

    wezterm.GLOBAL.wallpaper_index = index

    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = M.wallpapers[index]

    window:set_config_overrides(overrides)
    M.save_to_cache(M.wallpapers[index])
end

function M.save_to_cache(path)
    local file, err = io.open(M.cache_dir .. '/wallpaper.txt', 'w')

    if not file then
        wezterm.log_error("Failed to write wallpaper tracking file: " .. tostring(err))
    else
        file:write(path .. '\n')
        file:close()
    end
end

function M.read_cache()
    local file, err = io.open(M.cache_dir .. '/wallpaper.txt', 'r')

    if not file then
        wezterm.log_error("Failed to write wallpaper tracking file: " .. tostring(err))
        return nil
    end

    local saved_wallpaper = file:read('*a') ---@type string
    file:close()
    saved_wallpaper = saved_wallpaper:gsub("%s+$", "") 
    return saved_wallpaper
end

function M.create_cache()
    local success, _ = pcall(wezterm.read_dir, M.cache_dir)
    if success then return end

    if wezterm.target_triple:find("windows") then
        os.execute('if not exist "' .. M.cache_dir .. '" mkdir "' .. M.cache_dir .. '"')
    else
        os.execute('mkdir -p "' .. M.cache_dir .. '"')
    end
end

return M
