--[[
  player.lua

  The entity controlled by the player

  CURRENT TO DOs:
  - need to track inventory
  - directionalize walking anims and animation in general
  - display a debug ui detailing an entity's data in realtime 
  in editor mode, and click any entity to display it's debug info
]]

-- require 'tools/camera'
require 'tools/physics_helper'
require 'tools/world_physics'
local floor = math.floor
local quad = love.graphics.newQuad

function combat_attack(obj)
  print(obj.name .. ' ATTACKED')
end

local Player = {}
-- local tiles = tlm.tiles[2] -- tiles of the spawn chunk

local anim_data = {
  quad(0,0,16,16,192,16),
  quad(16,0,16,16,192,16),
  quad(32,0,16,16,192,16),
  quad(48,0,16,16,192,16),
  quad(64,0,16,16,192,16),
  quad(80,0,16,16,192,16),
  quad(96,0,16,16,192,16),
  quad(112,0,16,16,192,16),
}
local image = love.graphics.newImage('assets/newer/Leo.png')
image:setFilter("nearest","nearest")

function Player:new(x,y)
  -- x,y,w,h,img,quad,id
  local player = require('objects/entity'):new(
    x,y,32,32,nil,nil,"player"
  )

  function player:load()
    renderer:addRenderer(self, 3)
    gameloop:addLoop(self)

    self.name = 'Player'
    self.attackvector = nil
    self.inventory = {}

    init_physics(self, 500)
    -- tiles = tlm.chunks[0].tiles -- tiles of the spawn chunk
    -- tiles = tlm:getTilesAtCoords(player.pos)

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
          {-- attack animation
            anim_data[7],
            anim_data[8]
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
    camera:goToPoint(self.pos) -- camera follows this player

    -- is this a memory leak of boxes? update position instead?
    if (DEBUG_HITBOX_VIS and key) then
      box = rect:new(self.pos.x + (self.vel.x * dt * self.dir.x), self.pos.y + (self.vel.y * dt * self.dir.y),self.size.x,self.size.y)
    end

    self.animation:set_animation(1)
    -- velocities

    if (tlm.chunksLoaded == true) then

      -- these controls were to move around easily
      -- stop using raint for varname here, fix physics
      -- raint = 1
      -- if ( key("g") ) then 
      --   raint = raint + 1
      --   print(raint)
      --   if raint > 97 then raint = 97 end
      --   apply_gravity(self, dt)
      -- end
      -- if ( key("h") ) then 
      --   raint = raint - 1
      --   print(raint)
      --   if raint < 91 then raint = 91 end
      --   apply_gravity(self, -dt)
      --   self.vel.y = 0
      --   -- print(raint)
      -- end
      -- if ( key("b") ) then 
      --   self.vel.y = 0
      --   print(raint)
      -- end

    end
      apply_gravity(self, dt)

    -- walk left or right
    if ( key("left") or key('a') ) then
      self.animation:set_animation(2)
      self.dir.x = -1
      self.vel.x = 100
    end
    if ( key("right") or key('d') ) then
      self.animation:set_animation(2)
      self.dir.x = 1
      self.vel.x = 100
    end
    if( key('j')) then
      self.animation:set_animation(3)
    end


    if not tlm.customMap then
      local chunk = tlm.chunksByStrKey[
        tostring(floor(self.pos.x / 32 / 16))
        .. tostring(floor(self.pos.y / 32 / 16))
      ]
      if chunk == nil then
        print(
          'ERROR - chunk is nil: x'..self.pos.x
          .. ' y'.. self.pos.y .. ' strkey= '
          .. tostring(floor(self.pos.x / 32 / 16))
          .. tostring(floor(self.pos.y / 32 / 16))
        )
        player.pos.move(player, 0, 0, dt)
      else
        if DEBUG_LOGGING_COLLISION then
          print('player chunk strkey: '..chunk.strKey)
        end
        update_physics(self, chunk, dt, true) --tlm.customMap)
      end
    end
    -- print(tostring(floor(self.pos.x / 32 / 16))..tostring(floor(self.pos.y / 32 / 16)))
    -- print(tlm.chunksByStrKey[tostring(self.pos.x / 32 / 16)..tostring(self.pox.y / 32 / 16)].tiles)
    -- print(tostring(self.pos.x / 32 / 16)..tostring(self.pos.y / 32 / 16))
    -- print(tostring(self.pos.y / 32 / 16))
    -- PrintTable(tlm.chunksByStrKey[tostring(floor(self.pos.x / 32 / 16))..tostring(floor(self.pos.y / 32 / 16))], 3)


    -- if tlm.customMap then
    --   chunk.tiles = tlm.tiles
    --   -- PrintTable(chunk.tiles, 1)
    --   -- PrintTable(tlm.tiles, 1)
    -- end

    -- COLLISION HANDLING in world_physics.lua WIP
    -- update_physics(self, chunk, dt, true) --tlm.customMap)
    newupdate_physics(self, dt) --tlm.customMap)

    -- jump
    if ( key("space") or key('w') or key('up') ) then 
      physics_jump(self)
    end
    -- attack
    if key('j') then
      -- print('attack')
      combat_attack(self)
    end
    -- if key("") then -- end

    --Make the player move based on the velocities we set above
    self.pos.x  = self.pos.x + (self.vel.x * dt) * self.dir.x
    self.pos.y  = self.pos.y + (self.vel.y * dt) * self.dir.y

    self.vel.x = self.vel.x * (1-dt*8) -- friction entropy

    -- player movement test
    -- self.pos.y = self.pos.y +1

    self.animation:update(dt)
    -- print(self.pos.y)
  end

  function player:draw()
    -- love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)

    -- love.graphics.setColor(255,0,0,255) -- RED
    -- love.graphics.setColor(0,255,0,255) -- GREEN
    -- love.graphics.setColor(255,255,255,255) -- WHITE reset
    
    if (DEBUG_HITBOX_VIS) then 
      -- prediction box from check point origin
      love.graphics.setColor(0,255,0,255) -- GREEN
      love.graphics.rectangle("line",box.pos.x,box.pos.y,self.size.x,self.size.y)
      love.graphics.setColor(255,255,255,255) -- WHITE reset
    end
    
    -- drawing the attack hitbox -- shortsword
    if (DEBUG_HITBOX_VIS and key('j')) then 

      -- prediction box from check point origin
      love.graphics.setColor(255,0,0,255) -- RED
      love.graphics.rectangle(
        "line",
        box.pos.x+self.size.x,
        box.pos.y+self.size.y/2,
        self.size.x,
        self.size.y/10
      )
      love.graphics.setColor(255,255,255,255) -- WHITE reset
    end

    -- 10.2 draw( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
    self.animation:draw({self.pos.x,self.pos.y})

    -- a wall minimap position box for the player
    -- local x = floor(self.pos.x / 32)
    -- local y = floor(self.pos.y / 32)
    -- local w = 2
    -- local h = 2
    -- love.graphics.setColor(255,0,0,255)
    -- love.graphics.rectangle("fill",x,y,5,5)
    -- love.graphics.setColor(255,255,255,255)
 


    -- love.graphics.setColor(0,0,250,255)
    -- love.graphics.setColor(255,255,255)

    --minimap
    local cx = camera.pos.x
    local cy = camera.pos.y
    local x_pos = cx + floor(self.pos.x / g_TileSize)+1
    local y_pos = cy + floor(self.pos.y / g_TileSize)+1
    -- draws a green dot in the corner of a scale 1 camera
    -- staticly positioned like the HUD layer
    love.graphics.setColor(0, 255,5) -- GREEN
    love.graphics.rectangle("fill",x_pos,y_pos, 2,2)
    -- love.graphics.rectangle("line", 20,20, 200,200)
    -- love.graphics.setColor(255,5,5) -- RED

    -- love.graphics.print(
    --   -- love.timer.getFPS(),
    --   true,
    --   player.pos.x, --  + (windowWidth - 64),
    --   player.pos.y -- + (windowHeight - 64)
    --   -- camera.pos.x, --  + (windowWidth - 64),
    --   -- camera.pos.y -- + (windowHeight - 64)
    -- )
    love.graphics.print('WELCOME ...', 0, 0)

  end

  -- return the constructed player to the global scope
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


