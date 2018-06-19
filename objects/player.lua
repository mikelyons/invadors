require 'tools/camera'
require 'tools/physics_helper'
require 'tools/world_physics'

local Player = {}
local floor = math.floor
local tiles = tlm.tiles[2]

function Player:new(x,y)
  -- x,y,w,h,img,quad,id
  local player = require('objects/entity'):new(x,y,32,32,nil,nil,"player")

  function player:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    init_physics(self, 500)
  end

  local key = love.keyboard.isDown

  function player:tick(dt)
    camera:goToPoint(self.pos) -- camera follows this player

    -- velocities
    apply_gravity(self, dt)

    if key("left") then 
      self.dir.x = -1
      self.vel.x = 200
    end
    if key("right") then 
      self.dir.x = 1
      self.vel.x = 200
    end

    update_physics(self, tiles, dt)

    if key("space") then 
      physics_jump(self)
    end
    
  end

  function player:draw()
    love.graphics.setColor(0,0,250,255)
    love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
    love.graphics.setColor(255,255,255)
  end

  return player
end

return Player








--

-- local class = require './lib.middleclass.middleclass'

-- Player = class('player')

-- function Player:initialize()
--   player = {}
--   player.x = (love.graphics.getWidth() / 2)
--   player.y = (love.graphics.getHeight() / 2)
--   player.speed = 20

--   player.image = love.graphics.newImage('/assets/ufo2.png')
--   player.image:setFilter('nearest', 'nearest', 1)
-- end

-- function Player:update(dt)
  
-- end


