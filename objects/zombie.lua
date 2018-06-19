require 'tools/camera'
require 'tools/physics_helper'
require 'tools/world_physics'

local Zombie = {}
local floor = math.floor
local tiles = tlm.tiles[2]

function Zombie:new(x,y)
  -- x,y,w,h,img,quad,id
  local zombie = require('objects/entity'):new(x,y,32,32,nil,nil,"enemy")

  function zombie:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    init_physics(self, 500)
  end

  function zombie:tick(dt)
    -- velocities
    apply_gravity(self, dt)
    update_physics(self, tiles, dt)
  end

  function zombie:draw()
    love.graphics.setColor(250,0,50)
    love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
    love.graphics.setColor(255,255,255)
  end

  return zombie
end

return Zombie