DEBUG_NOSPLASH = false

-- default states to boot to, to skip the menu
-- BOOT_TO_STATE = 'wireArt' -- doesn't work
-- BOOT_TO_STATE = 'generate'
-- BOOT_TO_STATE = nil

-- broken?
DEBUG_CONSOLE_FUNCTION = false

DEBUG_HITBOX_VIS = true
DEBUG_HITBOX_UI = true

-- used in computer and dialogue - useful for layouting
DEBUG_GRID_ON = false
-- DEBUG_GRID_ON = true

DEBUG_SHOW_FPS = true

--==============
--LOGGING LEVELS
--==============
DEBUG_LOGGING_LOADING = false
DEBUG_PRESSSTART_OFF = true -- what did this do?
-- this is broken, then you turn it off the game crashes
DEBUG_LOGGING_ON = true
DEBUG_LOGGING_COLLISION = false
DEBUG_LOGGING_CHUNKS = false
DEBUG_LOGGING_MAP = false
DEBUG_LOGGING_INPUT = false

-- from main.lua
g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()
g_GameTime = 0
g_TileSize = 32
g_MapSize  = 16