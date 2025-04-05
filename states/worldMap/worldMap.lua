--[[
  worldMap.lua

  World Map State

  This state is the main state for the world map.
  It is responsible for loading the world map and all of the locations on the map.
  It is also responsible for handling the player's movement on the map.
]]

print('worldMap.lua -> ')

-- dependencies
sti = require('lib/sti')

print('WM -> ')

local WM = Game:addState('worldMap') -- registering the gamestate

function WM:enteredState()
  print('WM -> ')
  print('WM:enteredState() ====================================')
  self.map = sti("assets/maps/worldMap/worldMap.lua", { "box2d" })

end
function WM:exitedState() end

function WM:update() end
function WM:draw() end
