--[[
  game_config.lua

  Centralized game configuration with all magic numbers and constants.
  Import this instead of hardcoding values throughout the codebase.

  Usage:
    local Config = require('src/core/game_config')
    local gravity = Config.physics.gravity
]]

local Config = {}

-- Window settings (from conf.lua and main.lua)
Config.window = {
    default_width = 1340,    -- (was hardcoded in conf.lua:86, main.lua:88)
    default_height = 900,    -- (was hardcoded in conf.lua:87, main.lua:87)
    min_width = 400,
    min_height = 300,
    title = "InvadortZ",
    vsync = false,
    resizable = true,
}

-- Physics constants (from world_physics.lua)
Config.physics = {
    gravity = 500,           -- units/sec^2 (was hardcoded in world_physics.lua:18)
    max_fall_velocity = 300, -- units/sec (was hardcoded in world_physics.lua:24)
    jump_velocity = -200,    -- units/sec (was hardcoded in world_physics.lua:33)
    ground_threshold = 10,   -- velocity threshold for "on ground" check
    friction = 8,            -- friction multiplier (was hardcoded in player.lua:190)
}

-- Player settings (from player.lua)
Config.player = {
    speed = 100,             -- movement speed (was hardcoded in player.lua:143, 148)
    spawn_x = 32,            -- default spawn X
    spawn_y = 32,            -- default spawn Y
    width = 16,
    height = 32,
}

-- Enemy settings (from zombie.lua)
Config.enemy = {
    zombie_speed = 50,       -- zombie movement speed (was hardcoded in zombie.lua:52, 55)
}

-- Item settings (from item.lua)
Config.item = {
    speed = 50,              -- item movement speed
}

-- Tile/Map settings (from tlm.lua)
Config.tiles = {
    size = 32,               -- pixels per tile (was g_TileSize, hardcoded in multiple files)
    chunk_size = 16,         -- tiles per chunk (was hardcoded in tlm.lua)
    atlas_size = 512,        -- default atlas dimensions
}

-- Animation settings
Config.animation = {
    default_duration = 0.2,  -- seconds per frame (was hardcoded in player.lua:87)
}

-- Camera settings
Config.camera = {
    default_scale = 1,
    min_scale = 0.25,
    max_scale = 4,
}

-- Debug settings (mirrors constants.lua but centralized)
Config.debug = {
    show_fps = true,
    show_grid = false,
    show_hitbox = true,
    logging_on = true,
}

return Config
