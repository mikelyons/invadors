
-- Middleclass Root Game class with Stateful state machine
Game = Class('Game'):include(Stateful)

-- loads states that are a folder instead of a file
function loadState(name)
  local path = "states/" .. name
  require(path .. '/main')
  load(name)
end
function load(name)
end

-- make available the following states
loadState('earth2')
require 'states/menu'
require 'states/pause'
require 'states/bizzaro'
require 'states/earth1'
require 'states/splash'

-- Game's methods
function Game:initialize()
  print(os.date())
  -- print(os.getenv('PATH')) -- get environmental variable
  -- print(os.getenv('HOME')) -- get environmental variable
  print(os.getenv('USER')) -- get environmental variable
  self:gotoState('Splash')
end

function Game:update(dt) end
function Game:draw(dt) end

function Game:keypressed(key, code) end
function Game:mousepressed(x, y, button, istouch) end
function Game:mousereleased(x, y, button) 
end

