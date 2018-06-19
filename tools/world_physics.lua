
local floor = math.floor

local rect = require('objects/rect')
local vec2 = require('tools/vec2')

function init_physics( obj, gravity, dt )
  obj.on_ground = false 
  obj.gravity = gravity or 500
end
function apply_gravity(obj,dt)
  -- gravity
  obj.vel.y = obj.vel.y + obj.gravity * dt
  obj.dir.y = 1
end

function physics_jump (obj)
  if obj.vel.y < 10 and obj.vel.y > -10 and obj.on_ground == true then
    obj.vel.y = -obj.gravity
    obj.on_ground = false
  end
end

function update_physics(obj,tiles,dt)
    -- collisions
    local x = floor(obj.pos.x / 32)
    local y = floor(obj.pos.y / 32)
    local w = 2
    local h = 2

    if x < 1 then x = 1 end
    if y < 1 then y = 1 end

    for i = y, y + h do
      for j = x, x + w do
        local tile = tiles[i][j]
        if tile == nil then 
          -- Do nothing
        else
          -- prediction box to test where were going
          local box = rect:new(obj.pos.x + (obj.vel.x * dt * obj.dir.x), obj.pos.y + obj.vel.y * dt,obj.size.x,obj.size.y)

          local coll, rect = rectangle_collision(box, tile)
          if coll then
            obj.vel.y = 0
            obj.dir.y = 0

            -- y coll
            if obj.pos.y + obj.size.y / 1 < rect.pos.y + rect.size.y / 1 then

              -- Bottom of player collision
              if box.pos.y + box.size.y > rect.pos.y and
                obj.pos.y + obj.size.y < rect.pos.y + 8 then

                obj.on_ground = true
                obj.pos.y = rect.pos.y - obj.size.y
              end

            else

              -- Top of player collision
              if obj.pos.y > rect.pos.y + rect.size.y - 8 then
                obj.vel.y = 0
                obj.pos.y = rect.pos.y+rect.size.y + 1

                -- goto cont -- skip the x collisions
                goto skip_x
              end
            end
            --

            -- x coll 
            if obj.pos.x + obj.size.x / 2 < rect.pos.x + rect.size.x /2 then
              if box.pos.x + box.size.x > rect.pos.x and
                obj.pos.y + obj.size.y > rect.pos.y then

                obj.vel.x = 0
                obj.dir.x = 0

                obj.pos.x = rect.pos.x - obj.size.x
                print("left", math.random())
              end
            else
              if box.pos.x < rect.pos.x + rect.size.x and
                obj.pos.y + obj.size.y > rect.pos.y then

                obj.vel.x = 0
                obj.dir.x = 0

                obj.pos.x = rect.pos.x+rect.size.x
                print("reight", math.random())
              end
            end
            --
            ::skip_x::
          end
        end
      end
    end
  --Make the object move based on the velocities we set above
  obj.pos.x  = obj.pos.x + (obj.vel.x * dt) * obj.dir.x
  obj.pos.y  = obj.pos.y + (obj.vel.y * dt) * obj.dir.y

  obj.vel.x = obj.vel.x * (1-dt*8) -- friction entropy
end