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
print("Game: Creating Game class...")
Game = Class('Game'):include(Stateful)
print("Game: Game class created successfully")
function Game:new() 
  print("Game: Game:new() called")
  local success, result = pcall(function() return Game.super.new(self) end)
  if success then
    print("Game: Game:new() completed successfully")
    return result
  else
    print("Game: Game:new() failed with error:", result)
    return nil
  end
end

--[[
  When the game initializes, it loads all the specified states
  these are gamemodes and instantiable tools
  then it goes to the menu state unless a boot bypass is specified
]]
function Game:initialize()
  print('Game: initialize() called')
  
  local success, err = pcall(function()
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
  loadStateFolder('dinner')
  -- loadStateFolder('book')  -- Removed book state
  loadStateFile  ('bizzaro')
  loadStateFolder('prog2')
  loadStateFile  ('pro')
  loadStateFolder('kitchen')
  loadStateFolder('space1')
  loadStateFolder('worldMap')

  -- ingame UIs
  loadStateFolder('inventory')
  loadStateFolder('vapeStatus')

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
  loadStateFolder('drivingSim')
  loadStateFolder('livelove')
  loadStateFolder('characterCustomizer')
  -- loadStateFolder('mic')
  -- loadStateFolder('template')
  -- self:gotoState('template')
  -- loadMenuStateFile('pressStart')
  -- self:gotoState('PressStart')

  -- local BOOT_TO_STATE = 'tiledZoom'
  -- local BOOT_TO_STATE = 'generate'
  -- local BOOT_TO_STATE = 'synth'
  -- local BOOT_TO_STATE = 'mic'
  print("Game: All states loaded, initializing default state...")
  if BOOT_TO_STATE ~= nil then -- boot to skip the menu, or the default state menu
    print("Game: Booting to state:", BOOT_TO_STATE)
    self:gotoState(BOOT_TO_STATE or 'menu')
  else
    print("Game: Booting to default menu state")
    print("Game: About to call gotoState('menu')")
    print("Game: Available states:", self:getStateStackDebugInfo())
    local success, err = pcall(function() self:gotoState('menu') end)
    if success then
      print("Game: gotoState('menu') called successfully")
    else
      print("Game: gotoState('menu') failed with error:", err)
    end
  end
  print("Game: Initialization complete")
  print("Game: Current state after initialization:", self.currentState)
  end)
  
  if not success then
    print("Game: initialize() failed with error:", err)
  else
    print("Game: initialize() completed successfully")
  end
end

function Game:update(dt)
  -- Delegate update to current state
  if self.currentState and self.currentState.update then
    self.currentState:update(dt)
  end
end
function Game:keypressed(key, code)
  -- Delegate to current state if it exists
  if self.currentState and self.currentState.keypressed then
    self.currentState:keypressed(key, code)
  end
end
function Game:mousepressed(x, y, button, istouch)
  -- Delegate to current state if it exists
  if DEBUG_LOGGING_INPUT then
    print("Game: mousepressed called, currentState:", self.currentState and "exists" or "nil")
  end
  
  if self.currentState and self.currentState.mousepressed then
    self.currentState:mousepressed(x, y, button, istouch)
  else
    if DEBUG_LOGGING_INPUT then
      print("Warning: No mousepressed method found in current state")
    end
  end
end

function Game:mousereleased(x, y, button)
  -- Delegate to current state if it exists
  if self.currentState and self.currentState.mousereleased then
    self.currentState:mousereleased(x, y, button)
  end
end
-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
function Game:draw(dt)
  -- Delegate drawing to current state
  if self.currentState and self.currentState.draw then
    self.currentState:draw(dt)
  end
  
  -- why isn't this happening
  if DEBUG_SHOW_FPS then
    love.graphics.print(
      'FPS '..tostring(love.timer.getFPS()),
      -- camera.pos.x + (windowWidth - 128),
      -- camera.pos.y + (windowHeight - 128)
      32, 32
    )
  end
end

-- Ensure Game class is available globally
return Game

