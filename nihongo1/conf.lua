function love.conf(t)
    t.title = "Nihongo"        -- The title of the window the game is in (string)
    t.author = "Ubermann"        -- The author of the game (string)
    t.version = "0.8.0"         -- The LÖVE version this game was made for (string)
    t.console = true           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.modules.joystick = false   -- Enable the joystick module (boolean)
    t.modules.audio = false      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = false      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = false      -- Enable the sound module (boolean)
    t.modules.physics = false    -- Enable the physics module (boolean)
end
