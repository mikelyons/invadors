
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

-- TODO update this
-- -- currently doesn't offset for proper chunk tile collision
-- -- still set to the first chunk only and that column's
-- -- bottom row due to floor
function update_physics(obj, chunk, dt, customMap)
  local tiles
  -- if customMap then
  --   print('CUSTOM MAP - '..customMap)
  --   tiles = tlm.tiles[2]
  --   print(tiles)
  -- else
  --   print('CUSTOM MAP - '..customMap)
  --   tiles = chunk.tiles[2]
  --   print(tiles)
  -- end
  tiles = chunk.tiles[2]
  local chunksize = g_MapSize -- 16

  -- PrintTable(tiles[4][12], 1) --h[1][1].pos, 1)
  -- PrintTable(obj.pos, 1)

    -- collisions
  -- objects position integer and
  -- made positive to work as table index
  local x = floor(obj.pos.x / 32) + 1
  local y = floor(obj.pos.y / 32) + 1
  local w = 2
  local h = 2


  if x < 1 then x = 1 end
  if y < 1 then y = 1 end

  -- print('box: '..box.pos.x..'x '..box.pos.y..'y')
  -- print('obj: '..obj.pos.x..'x '..obj.pos.y..'y ')
  -- print('box: '..x..'x '..y..'y ')
  if DEBUG_LOGGING_COLLISION then
    print(
      'obj:'..obj.pos.x..'x '..obj.pos.y..'y '..'\n'..
      'box:'..floor(x)..'x '..floor(y)..'y '..'\n'..
      'chk: '..chunk.strKey
    )
  end

  -- if (tiles[x][y]) then
  --   print(tiles[x][y].index)
  --   print('box: '..x..'x '..y..'y ')
  -- end

  -- for i = y, y + h do
  --   for j = x, x + w do
  for i = 1,16 do
    for j = 1,16 do
      if i > chunksize then i = chunksize end
      if j > chunksize then j = chunksize end

      -- PrintTable(tiles, 1)
      local tile = tiles[i][j]
      -- print('Tile at x:' .. x .. ' y:' .. y .. ' ' .. tile)
      -- print('Tile at x:'..x..' '..tiles)
      -- print(' '..tile.type)
      if (tile ~= nil) then
        -- print(tile.type)
        -- PrintTable(tile)
      end

      -- print(tile)
      if tile == nil then 
        -- obj.on_ground = false 
        -- do I even need to know if the character is falling?
        -- Do nothing
      else
        -- prediction box to test where were going
        local box = rect:new(
          obj.pos.x + (obj.vel.x * dt * obj.dir.x),
          obj.pos.y + obj.vel.y * dt,
          obj.size.x,
          obj.size.y
        )

        local coll = rectangle_collision(box, tile)
        -- print('box: '..box.pos.x..'x '..box.pos.y..'y')
        -- print('tlm: '..tile.pos.x..'x '..tile.pos.y..'y')
        if coll then
          -- print('coll')
          -- y coll, landing, onground
          if obj.pos.y + obj.size.y / 2 < tile.pos.y + tile.size.y / 2 then

            if DEBUG_LOGGING_COLLISION then
              print('Bottom '..'tileindex: '..tile.index..' - '..chunk.strKey, math.random())
            end

            -- Bottom of player collision
            if box.pos.y + box.size.y > tile.pos.y and
              obj.pos.y + obj.size.y < tile.pos.y + 8 then

              obj.vel.y = 0
              obj.dir.y = 0

              obj.on_ground = true
              obj.pos.y = tile.pos.y - obj.size.y
              if (floor(obj.pos.y) == obj.pos.y) then
                -- print('bottom', floor(obj.pos.y) )

                -- print the colliding tile position
                -- print(tile.index..' x'..tile.pos.x..' y'..tile.pos.y)

              end
            end

          else
            -- Top of player collision
            if obj.pos.y > tile.pos.y + tile.size.y - 8 then
              obj.vel.y = 0
              obj.dir.y = 0
              obj.pos.y = tile.pos.y + tile.size.y + 1

              if DEBUG_LOGGING_COLLISION then
                if (floor(obj.pos.y) == obj.pos.y) then
                  print('top '..'tileindex: '..tile.index..' - '..chunk.strKey, math.random())
                  -- PrintTable(tile)
                end
              end

              -- goto cont -- skip the x collisions
              goto skip_x
            end
          end
          --

          -- x coll 
          if obj.pos.x + obj.size.x / 2 < tile.pos.x + tile.size.x /2 then
            if box.pos.x + box.size.x > tile.pos.x and
              obj.pos.y + obj.size.y > tile.pos.y then

              obj.vel.x = 0
              obj.dir.x = 0

              obj.pos.x = tile.pos.x - obj.size.x
              if DEBUG_LOGGING_COLLISION then
                if (floor(obj.pos.x) == obj.pos.x) then
                  -- print("left", math.random())
                  PrintTable(tile)
                end
              end
            end
          else
            if box.pos.x < tile.pos.x + tile.size.x and
              obj.pos.y + obj.size.y > tile.pos.y then

              obj.vel.x = 0
              obj.dir.x = 0

              obj.pos.x = tile.pos.x + tile.size.x
              if DEBUG_LOGGING_COLLISION then
                if (floor(obj.pos.x) == obj.pos.x) then
                  -- print("right", math.random())
                  PrintTable(tile)
                end
              end
            end
          end
          --
          ::skip_x::
        end
      end
    end
  end
end