require 'tools/camera'
require 'tools/physics_helper'
require 'tools/world_physics'

local Player = {}
local floor = math.floor
local tiles = tlm.tiles[2]

local quad = love.graphics.newQuad
local anim_data = {
  quad(0,0,16,16,192,16),
  quad(16,0,16,16,192,16),
  quad(32,0,16,16,192,16),
  quad(48,0,16,16,192,16),
  quad(64,0,16,16,192,16),
}
local image = love.graphics.newImage('assets/newer/Leo.png')
image:setFilter("nearest","nearest")

function Player:new(x,y)
  -- x,y,w,h,img,quad,id
  local player = require('objects/entity'):new(x,y,32,32,nil,nil,"player")

  function player:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    init_physics(self, 500)

    -- rem
    self.animation = require('animation'):new(
        image,
        {
          { -- idle animation
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[1],
            anim_data[2]
          },
          {-- walk animation
            anim_data[4],
            anim_data[5]
          },
        },
        0.2
      )
    self.animation:play()
    -- end rem
  end

  local key = love.keyboard.isDown
  local rect = require 'objects/rect'

  function player:tick(dt)
    -- dt = dt
    camera:goToPoint(self.pos) -- camera follows this player
    box = rect:new(self.pos.x + (self.vel.x * dt * self.dir.x), self.pos.y + (self.vel.y * dt * self.dir.y),self.size.x,self.size.y)

    -- animation
    self.animation:set_animation(1)

    -- velocities
    apply_gravity(self, dt)

    if key("left") then 
      self.animation:set_animation(2)
      self.dir.x = -1
      self.vel.x = 100
    end
    if key("right") then 
      self.animation:set_animation(2)
      self.dir.x = 1
      self.vel.x = 100
    end

    update_physics(self, tiles, dt)

    if key("space") then 
      physics_jump(self)
    end

    -- if key("") then
    -- end

    --Make the selfect move based on the velocities we set above
    self.pos.x  = self.pos.x + (self.vel.x * dt) * self.dir.x
    self.pos.y  = self.pos.y + (self.vel.y * dt) * self.dir.y

    self.vel.x = self.vel.x * (1-dt*8) -- friction entropy
 
    self.animation:update(dt)
  end

  function player:draw()
    -- love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)

    -- love.graphics.setColor(255,0,0,255) -- RED
    -- love.graphics.setColor(0,255,0,255) -- GREEN
    -- love.graphics.setColor(255,255,255,255) -- WHITE reset
    
    -- prediction box from check point origin
    love.graphics.setColor(0,255,0,255) -- GREEN
    love.graphics.rectangle("line",box.pos.x,box.pos.y,self.size.x,self.size.y)
    love.graphics.setColor(255,255,255,255) -- WHITE reset

    -- 10.2 draw( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
    self.animation:draw({self.pos.x,self.pos.y})

    -- a wall minimap position box for the player
    local x = floor(self.pos.x / 32)
    local y = floor(self.pos.y / 32)
    local w = 2
    local h = 2
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",x,y,5,5)
    love.graphics.setColor(255,255,255,255)
 


    -- love.graphics.setColor(0,0,250,255)
    -- love.graphics.setColor(255,255,255)

    --minimap
    local cx = camera.pos.x
    local cy = camera.pos.y
    local x_pos = cx + floor(self.pos.x / g_TileSize)+1
    local y_pos = cy + floor(self.pos.y / g_TileSize)+1

    love.graphics.setColor(0, 255,5) -- GREEN
    -- love.graphics.setColor(255,5,5) -- RED
    --minimap?
    love.graphics.rectangle("fill",x_pos,y_pos, 2,2)
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


