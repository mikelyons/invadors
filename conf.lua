
--	InvadortZ {__VERSION}
--  author : Mike Lyons
--  developed using : lua + love2d 
--  
--  github repo link: https://github.com/mikelyons/invadors
--

--https://love2d.org/wiki/Config_Files

if love._version_major == 0 and love._version_minor < 9 then
	error("InvadortZ requires love2d 0.9.0 or newer")
-- elseif love._version_minor > 11 then
--   error("too new the love version is")
end

-- make console work?
-- io.stdout:setvbuf("full")
io.write("hello", "Lua"); io.write("Hi", "\n")
-- make sure the standard io works

-- ~ console in game - https://love2d.org/wiki/Cupid -- @TODO : separate dev libs
-- require("./lib/cupid/cupid");

local snapdate = os.date("m%md%d")

__SNAP = snapdate or "m10w43"
__VERSION = "0.4.7.2"
__TITLE_STR = string.format("InvadortZ v%s", __VERSION..'.'..__SNAP)

function love.conf( t ) 
  t.console = true -- did this ever work?

  -- where is this directory?
  -- 	%appdata%\LOVE\{t.identity}
  -- change this with https://love2d.org/wiki/love.filesystem.setIdentity
  t.identity = "invadors_save_directory"       -- The name of the save directory (string)
  t.version = "0.10.2"                -- The LÖVE version this game was made for (string)
  t.window.title = __TITLE_STR --string.format("Invadors v%s", __VERSION)        -- The window title (string)

  -- mushroom wasn't 32x32 and wouldn't work on windows so I made small one named shroom
  -- t.window.icon = 'assets/mushroom.png' -- Filepath to an image to use as the window's icon (string)

  t.window.icon = 'assets/shroom.png' -- Filepath to an image to use as the window's icon (string)

  t.window.width = 1340
  t.window.height = 900

  -- t.window.width  = 512
  -- t.window.height = 512
  -- t.window.width  = 1024
  -- t.window.height = 768
  t.window.x = 800                   -- set the position of the window on launch
  t.window.y = 30
  t.window.borderless = false        -- Remove all border visuals from the window (boolean)
  t.window.resizable = true          -- Let the window be user-resizable (boolean)
  t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
  t.window.minheight = 1             -- Minimum window height if the window is resizable (number)

  t.window.fullscreen = false        -- Enable fullscreen (boolean)
  -- t.window.fullscreentype = "normal" -- Standard fullscreen or desktop fullscreen mode (string)

  t.window.vsync = true              -- Enable vertical sync (boolean)
  t.window.fsaa = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
  -- t.window.msaa = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
  t.window.display = 1               -- Index of the monitor to show the window in (number)
  t.window.highdpi = false           -- Enable high-dpi mode for the window on a Retina display (boolean). Added in 0.9.1
  t.window.srgb = false              -- Enable sRGB gamma correction when drawing to the screen (boolean). Added in 0.9.1

  -- Modules, disable unused ones eventually
  t.modules.audio = true             -- Enable the audio module (boolean)
  t.modules.event = true             -- Enable the event module (boolean)
  t.modules.graphics = true          -- Enable the graphics module (boolean)
  t.modules.image = true             -- Enable the image module (boolean)
  t.modules.keyboard = true          -- Enable the keyboard module (boolean)
  t.modules.math = true              -- Enable the math module (boolean)
  t.modules.mouse = true             -- Enable the mouse module (boolean)
  t.modules.physics = true           -- Enable the physics module (boolean)
  t.modules.sound = true             -- Enable the sound module (boolean)
  t.modules.system = true            -- Enable the system module (boolean)
  t.modules.timer = true             -- Enable the timer module (boolean)
  t.modules.window = true            -- Enable the window module (boolean)
  t.modules.thread = true            -- Enable the thread module (boolean)

  t.modules.joystick = false          -- Enable the joystick module (boolean)
  t.modules.touch = false            -- Enable the touch module (boolean)
end


-- function love.conf(t)
--     t.identity = nil                    -- The name of the save directory (string)
--     t.version = "0.10.2"                -- The LÖVE version this game was made for (string)
--     t.console = false                   -- Attach a console (boolean, Windows only)
--     t.accelerometerjoystick = true      -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
--     t.externalstorage = false           -- True to save files (and read from the save directory) in external storage on Android (boolean) 
--     t.gammacorrect = false              -- Enable gamma-correct rendering, when supported by the system (boolean)
 
--     t.window.title = "Untitled"         -- The window title (string)
--     t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)
--     t.window.width = 800                -- The window width (number)
--     t.window.height = 600               -- The window height (number)
--     t.window.borderless = false         -- Remove all border visuals from the window (boolean)
--     t.window.resizable = false          -- Let the window be user-resizable (boolean)
--     t.window.minwidth = 1               -- Minimum window width if the window is resizable (number)
--     t.window.minheight = 1              -- Minimum window height if the window is resizable (number)
--     t.window.fullscreen = false         -- Enable fullscreen (boolean)
--     t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
--     t.window.vsync = true               -- Enable vertical sync (boolean)
--     t.window.msaa = 0                   -- The number of samples to use with multi-sampled antialiasing (number)
--     t.window.display = 1                -- Index of the monitor to show the window in (number)
--     t.window.highdpi = false            -- Enable high-dpi mode for the window on a Retina display (boolean)
--     t.window.x = nil                    -- The x-coordinate of the window's position in the specified display (number)
--     t.window.y = nil                    -- The y-coordinate of the window's position in the specified display (number)
 
--     t.modules.audio = true              -- Enable the audio module (boolean)
--     t.modules.event = true              -- Enable the event module (boolean)
--     t.modules.graphics = true           -- Enable the graphics module (boolean)
--     t.modules.image = true              -- Enable the image module (boolean)
--     t.modules.joystick = true           -- Enable the joystick module (boolean)
--     t.modules.keyboard = true           -- Enable the keyboard module (boolean)
--     t.modules.math = true               -- Enable the math module (boolean)
--     t.modules.mouse = true              -- Enable the mouse module (boolean)
--     t.modules.physics = true            -- Enable the physics module (boolean)
--     t.modules.sound = true              -- Enable the sound module (boolean)
--     t.modules.system = true             -- Enable the system module (boolean)
--     t.modules.timer = true              -- Enable the timer module (boolean), Disabling it will result 0 delta time in love.update
--     t.modules.touch = true              -- Enable the touch module (boolean)
--     t.modules.video = true              -- Enable the video module (boolean)
--     t.modules.window = true             -- Enable the window module (boolean)
--     t.modules.thread = true             -- Enable the thread module (boolean)
-- end
