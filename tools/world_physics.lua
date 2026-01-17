--[[
  world_physics.lua
  
  WORLD PHYSICS

  Handles collision for the chunk the player is in
  needs updated to handle surrounding chunks and seams/borders of chunks
  -- does it work on custom maps? not the new ones
]]

local floor = math.floor

local rect = require('objects/rect')
local vec2 = require('tools/vec2')

function init_physics( obj, gravity, dt )
  obj.on_ground = false
  obj.gravity = gravity or 500
end
function apply_gravity(obj,dt)
  -- attempt to limit falling speed
  -- obj.vel.y = (obj.vel.y > 600) ? (obj.vel.y + obj.gravity * dt) : 600
  obj.vel.y = obj.vel.y + obj.gravity * dt
  if obj.vel.y > 300 then
    obj.vel.y = 300
  end
  obj.dir.y = 1
end

function physics_jump (obj)
  -- print('jump '..obj.vel.y..' '..tostring(obj.on_ground))
  if obj.vel.y < 10 and obj.vel.y > -10 and obj.on_ground == true then
    obj.vel.y = -200
    obj.dir.y = 1
    obj.on_ground = false
  end
end

--[[
  UNIFIED PHYSICS SYSTEM
  
  This function works with both chunk-based and custom maps
  It automatically detects which system to use and handles collisions accordingly
]]
function unified_physics(obj, dt)
  local tiles = nil
  local chunk = nil
  
  -- Get tiles using unified tile access system
  local allTiles = tlm:getTilesForPhysics()
  
  -- Determine which layer to use for collision detection
  if tlm.customMap then
    -- Custom map system - try different layers
    if allTiles[3] then
      tiles = allTiles[3] -- Foreground layer
    elseif allTiles[2] then
      tiles = allTiles[2] -- Solid layer
    elseif allTiles[1] then
      tiles = allTiles[1] -- Background layer
    end
  else
    -- Chunk-based system - use solid layer
    if allTiles[2] then
      tiles = allTiles[2]
    end
  end
  
  if not tiles then
    if DEBUG_LOGGING_COLLISION then
      print('ERROR: No tiles found for physics collision')
    end
    return
  end
  
  -- Object's next-frame predicted position
  local box = rect:new(
    obj.pos.x + (obj.vel.x * dt * obj.dir.x),
    obj.pos.y + obj.vel.y * dt,
    obj.size.x,
    obj.size.y
  )
  
  -- Reset ground state
  obj.on_ground = false
  
  -- Get map dimensions using unified system
  local tileSize = 32
  local dimensions = tlm:getMapDimensions()
  local mapWidth = dimensions.width
  local mapHeight = dimensions.height
  
  -- Calculate tile coordinates for collision detection
  local centx = box.pos.x + obj.size.x - 1
  local centy = box.pos.y + obj.size.y - 1
  local tilex = math.floor(centx / tileSize) + 1
  local tiley = math.floor(centy / tileSize) + 1
  
  -- Bounds checking
  if tilex < 1 then tilex = 1 end
  if tiley < 1 then tiley = 1 end
  if tilex > mapWidth then tilex = mapWidth end
  if tiley > mapHeight then tiley = mapHeight end
  
  -- Check collision with the tile at the predicted position
  local tile = tiles[tiley] and tiles[tiley][tilex]
  
  if tile and tile.type ~= 0 then
    local coll, t = rectangle_collision(box, tile)
    
    if DEBUG_LOGGING_COLLISION and coll then
      print('Collision: tile-type:' .. tile.type)
    end
    
    if coll and t and t.type ~= 0 then
      -- Vertical collision (ground/ceiling)
      if obj.pos.y + obj.size.y / 2 < tile.pos.y + tile.size.y / 2 then
        -- Bottom collision (landing on ground)
        if box.pos.y + box.size.y > tile.pos.y and
           obj.pos.y + obj.size.y < tile.pos.y + 8 then
          
          obj.vel.y = 0
          obj.dir.y = 0
          obj.on_ground = true
          obj.pos.y = tile.pos.y - obj.size.y
          
          if DEBUG_LOGGING_COLLISION then
            print('Bottom collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
          end
        end
      else
        -- Top collision (hitting ceiling)
        if obj.pos.y > tile.pos.y + tile.size.y - 8 then
          obj.vel.y = 0
          obj.dir.y = 0
          obj.pos.y = tile.pos.y + tile.size.y + 1
          
          if DEBUG_LOGGING_COLLISION then
            print('Top collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
          end
        end
      end
      
      -- Horizontal collision (left/right walls)
      if obj.pos.x + obj.size.x / 2 < tile.pos.x + tile.size.x / 2 then
        -- Left collision
        if box.pos.x + box.size.x > tile.pos.x and
           obj.pos.y + obj.size.y > tile.pos.y then
          
          obj.vel.x = 0
          obj.dir.x = 0
          obj.pos.x = tile.pos.x - obj.size.x
          
          if DEBUG_LOGGING_COLLISION then
            print('Left collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
          end
        end
      else
        -- Right collision
        if box.pos.x < tile.pos.x + tile.size.x and
           obj.pos.y + obj.size.y > tile.pos.y then
          
          obj.vel.x = 0
          obj.dir.x = 0
          obj.pos.x = tile.pos.x + tile.size.x
          
          if DEBUG_LOGGING_COLLISION then
            print('Right collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
          end
        end
      end
    end
  end
end

--[[
  NEW CUSTOM MAP COLLISION DETECTION

  @TODO - find a way to highlight the occupied tile
  skyvault collision detection episode
  https://www.youtube.com/watch?v=ZGyuKCD8o0w&list=PL5gRzHmN4Dg0Q9J9mMQwzVSbRnj2zWcUH&index=11

]]
local function get_tile()
end

function newupdate_physics(obj, dt)
  -- Use the unified physics system for custom maps
  unified_physics(obj, dt)
end

-- TODO update this
-- -- currently doesn't offset for proper chunk tile collision
-- -- still set to the first chunk only and that column's
-- -- bottom row due to floor
function update_physics(obj, chunk, dt, customMap)
  -- Use the unified physics system for chunk-based maps
  unified_physics(obj, dt)
end