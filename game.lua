--[[
  game.lua

  Loads all the states, which are essentially cartridges

  The main game loop initializer this is loaded by the 
  main bootstrap file main.lua
]]

if DEBUG_LOGGING_LOADING then
  print(' ')
  print('game.lua ->')
  print(' ')
end

-- check all optional graphics features available to the engine to gracefully downgrade
-- https://love2d.org/wiki/GraphicsFeature
features = love.graphics.getSupported( )


-- networking tutorial with enet (which is installed)
-- https://rvagamejams.com/learn2love/pages/02-18-networking-part-2.html
-- https://www.reddit.com/r/love2d/comments/r3qg1k/luasocket_vs_luaenet/hmf4xk2/
-- are these doing anything?
renderer = Renderer:create()
gameloop = GameLoop:create()
require 'helpers/loading_helpers'

-- should we add this?
-- https://githubhelp.com/xkotori/love2d-console
--and this
-- https://github.com/SiENcE/astray
--https://github.com/mxgmn/WaveFunctionCollapse


-- Middleclass Root Game class with Stateful state machine
Game = Class('Game'):include(Stateful)
function Game:new() end

--[[
  When the game initializes, it loads all the specified states
  these are gamemodes and instantiable tools
  then it goes to the menu state unless a boot bypass is specified
]]
function Game:initialize()
  print('Game init')

  -- this only works if launched through run.BAT
  -- https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
  -- https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#samples
  -- @TODO - move this into logging to simplify this file
  print(' ')
  print(' ')
  print(' ')
  print(" -- TESTING logging color output -- ")
    PrintColor('print yellow', 'yellow')
    PrintColor('print red', 'red')
    PrintColor('print green', 'green')
    PrintColor('print white', 'white')
  print(" -- TESTING logging color output END -- ")
  print(' ')
  print(' ')
  print(' ')

    -- try to get multithreading working
    loadStateFile('mts')
    loadStateFile('orbital')
    -- self:gotoState('mts')

    loadStateFolder('characterCreation')

  loadStateFile  ('pause')
  -- Various mini-games 
  loadStateFolder('uiTest')
  loadStateFolder('asciiGame')
  loadStateFolder('synth')
  loadStateFolder('prog2')
  loadStateFolder('generate')
  loadStateFolder('dialogue')
  loadStateFolder('computer')
  loadStateFolder('book')
  loadStateFile  ('bizzaro')
  loadStateFolder('prog2')
  loadStateFile  ('pro')
  loadStateFolder('kitchen')
  loadStateFolder('space1')

  -- ingame UIs
  loadStateFolder('inventory')

  -- menu states
  loadStateFolder('menu')
  loadStateFolder('options')
  loadStateFolder('wireArt')
  loadMenuStateFile('newGame')
  loadStateFile  ('createWorld')
  loadMenuStateFile('loadSave')
  loadMenuStateFile('signin')
  loadStateFolder('infiniteRunner')
  loadStateFolder('editor')
  loadStateFolder('tiledZoom')
  loadStateFolder('face')
  loadStateFolder('quadtree')
  -- loadStateFolder('mic')
  -- loadStateFolder('template')
  -- self:gotoState('template')
  -- loadMenuStateFile('pressStart')
  -- self:gotoState('PressStart')

  -- local BOOT_TO_STATE = 'tiledZoom'
  -- local BOOT_TO_STATE = 'generate'
  -- local BOOT_TO_STATE = 'synth'
  -- local BOOT_TO_STATE = 'mic'
  if BOOT_TO_STATE ~= nil then -- boot to skip the menu, or the default state menu
    self:gotoState(BOOT_TO_STATE or 'menu')
  else
    self:gotoState('menu')
  end
end

function Game:update(dt) end
function Game:keypressed(key, code) end
function Game:mousepressed(x, y, button, istouch) end
function Game:mousereleased(x, y, button) end
-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
function Game:draw(dt)
  -- does this do anything? maybe in generate state?
  -- nothing for Menu
  -- renderer:draw() -- why isn't this happening?
end

