require 'tools/physics_helper'
require 'tools/world_physics'

local Zombie = {}
local floor = math.floor
local tiles = tlm.tiles[2]
local image = love.graphics.newImage('assets/zombie/zombie.png')
image:setFilter("nearest","nearest")

function Zombie:new(x,y)
  -- x,y,w,h,img,quad,id
  local zombie = require('objects/entity'):new(x,y,32,32,nil,nil,"enemy")

  function zombie:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    self.name = "zombie"
    self.attackvector = nil
    self.inventory = {}

    init_physics(self, 500)

    self.animation = require('animation'):new(
      image,
      { -- idle animation
        -- anim_data[1],
        -- anim_data[1],
        -- anim_data[1]
      },
      0.2
    )
    self.animation:play()
  end

  function zombie:tick(dt)
    -- velocities
    apply_gravity(self, dt)

    -- is this a memory leak of boxes? update position instead?
    if (DEBUG_HITBOX_VIS and key) then
      box = rect:new(self.pos.x + (self.vel.x * dt * self.dir.x), self.pos.y + (self.vel.y * dt * self.dir.y),self.size.x,self.size.y)
    end

    -- hunt the player - **move AI code**
    local player = obm:get_closest_by_id(self, "player")
    if self.on_ground then
      if self.pos.x < player.pos.x then
        self.vel.x = 50
        self.dir.x = 1
      else
        self.vel.x = 50
        self.dir.x = -1
      end
    end

    -- set the animation? every frame or else?
    self.animation:set_animation(1)

    -- if math.random(1,100) == 1 then
    --   physics_jump(self)
    --   print('raint')
    -- end

    --collisions
    update_physics(self, tiles, dt)

    local x_pos = floor(self.pos.x / g_TileSize)
    local y_pos = floor(self.pos.y / g_TileSize)+1
    -- local x_pos = floor(self.pos.x)
    -- local y_pos = floor(self.pos.y)+1
    -- print(x_pos .. ' ' .. y_pos)

    if tlm:is_solid_at_pos(x_pos,y_pos) then
      -- physics_jump(self)
    end

    if tlm:is_solid_at_pos(x_pos+3,y_pos) then
      -- physics_jump(self)
    end

    if not tlm:is_solid_at_pos(x_pos+3,y_pos+1) then
      -- physics_jump(self)
    end

    if not tlm:is_solid_at_pos(x_pos,y_pos+1) then
      -- physics_jump(self)
    end

    -- if tlm:is_solid_at_pos(x_pos, y_pos) then
    --   print('ouch  @ x:'..x_pos..' y:'..y_pos)
    --   print(self.id..'@ x:'..self.pos.x..' y:'..self.pos.y)
    --   print('tile@ x:'..(x_pos*g_TileSize)..' y:'..(y_pos*g_TileSize))
    --   physics_jump(self)
    -- end


    --Make the object move based on the velocities we set above
    self.pos.x  = self.pos.x + (self.vel.x * dt) * self.dir.x
    self.pos.y  = self.pos.y + (self.vel.y * dt) * self.dir.y
  end

  function zombie:draw()
    local x_pos = floor(self.pos.x / g_TileSize)+1
    local y_pos = floor(self.pos.y / g_TileSize)+1
    love.graphics.setColor(250,0,50)
    love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
    love.graphics.setColor(255,5,5)
    --minimap?
    love.graphics.rectangle("fill",x_pos,y_pos,2,2)
    love.graphics.setColor(255,255,255)

    if (DEBUG_HITBOX_VIS) then 
      -- prediction box from check point origin
      love.graphics.setColor(0,255,0,255) -- GREEN
      love.graphics.rectangle("line",box.pos.x,box.pos.y,self.size.x,self.size.y)
      love.graphics.setColor(255,255,255,255) -- WHITE reset
    end

  end

  return zombie
end

return Zombie


-- https://dev.to/jeansberg/make-a-shooter-in-lualove2d---part-3