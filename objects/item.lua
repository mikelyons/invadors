require 'tools/physics_helper'
require 'tools/world_physics'

local Item = {}
local floor = math.floor
local tiles = tlm.tiles[2]

function Item:new(x,y)
  -- x,y,w,h,img,quad,id
  local item = require('objects/entity'):new(x,y,16,16,nil,nil,"item")

  function item:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    init_physics(self, 500)
  end

  function item:tick(dt)
    -- velocities
    apply_gravity(self, dt)

    -- leftover from zombie class -- hunt the player
    -- local player = obm:get_closest_by_id(self, "player")

    if self.on_ground then
      if self.pos.x < player.pos.x then
        self.vel.x = 50
        self.dir.x = 1
      else
        self.vel.x = 50
        self.dir.x = -1
      end
    end

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
      physics_jump(self)
    end

    if tlm:is_solid_at_pos(x_pos+3,y_pos) then
      physics_jump(self)
    end

    if not tlm:is_solid_at_pos(x_pos+3,y_pos+1) then
      physics_jump(self)
    end

    if not tlm:is_solid_at_pos(x_pos,y_pos+1) then
      physics_jump(self)
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

  function item:draw()
    local x_pos = floor(self.pos.x / g_TileSize)+1
    local y_pos = floor(self.pos.y / g_TileSize)+1
    love.graphics.setColor(50,90,50)
    love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
    love.graphics.setColor(255,5,5)
    --minimap?
    love.graphics.rectangle("fill",x_pos,y_pos,2,2)
    love.graphics.setColor(255,255,255)
  end

  return item 
end

return Item