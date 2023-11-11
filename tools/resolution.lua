--[[
resolution.lua

Helper functions for screen resolution

API:
information about the window mode (fullscreen, vsync, size, etc.)
https://love2d.org/wiki/love.window.getMode
https://love2d.org/wiki/love.window.setMode

@TODO - make the resolution alwasy open in a window 
- with a 1/4 margin and only when the player
- maximizes it do they see the evilnote.lua
- Add this to the Options menu
]]--

print('')
print('resolution.lua -> ')
print('')

-- record current window dimensions
function windowDimensions()
    local width, height, flags = love.window.getMode()
    if DEBUG_LOGGING_ON then
        print('')
        print('Current device resolution -- .getMode() :')
        print(width, height)
        print('begin FLAGS -- ')
        PrintTable(flags)
        print(' end  FLAGS -- ')
    end
    return {width, height, flags}
end


-- record the players screen resolution
function deviceDimensions()
    local width, height, flags = love.window.getMode()
    love.window.setMode(0, 0)--, {false, false})

    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

    -- set the window back to the original dimensions
    love.window.setMode(width, height) --, {false, false})

    if DEBUG_LOGGING_ON then
        print('Screen dimensions detected :')
        print(screen_width, screen_height)
        print('window :')
        print(width, height)
    end
end

-- logg the window and device dimensions on startup if debug logging on
if DEBUG_LOGGING_ON then
    print('')
    print('resolution.lua -- debug logging dimensions functions -- -> ')
    deviceDimensions()
    windowDimensions()
end
