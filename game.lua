
-- Middleclass Root Game class with Stateful state machine
Game = Class('Game'):include(Stateful)

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
-- require 'states/space1'

-- Game's methods
function Game:initialize()
  self:gotoState('Menu')
  -- print("GAME INIT")
end

function Game:update(dt) end

function Game:draw(dt) end

function Game:keypressed(key, code)
  -- if key == ('escape' or 'p') then self:pushState('Pause') end
end

function Game:mousepressed(x, y, button, istouch)
end

