--[[
  This is a basic example and can be modified to your needs.
The above code defines an "entity" object with a draw() method that sets a "glow in the dark" effect using a custom shader. The new() method creates a new instance of the "entity" object with the specified position, image, and glow in the dark effect. The time variable is used to create a pulsing effect. The value of sin(time) ranges between -1 and 1, which is then scaled and offset to produce a value between 0 and 1 for the glow.
]]

local entity = {}

function entity:draw()
  love.graphics.setShader(self.shader)
  love.graphics.draw(self.image, self.x, self.y)
  love.graphics.setShader()
end

function entity:new(x, y, image)
  local obj = { x = x, y = y, image = image }
  setmetatable(obj, { __index = entity })

  -- Create the glow in the dark effect
  obj.shader = love.graphics.newShader([[
    extern number time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      vec4 pixel = Texel(texture, texture_coords);
      number glow = sin(time) * 0.5 + 0.5;
      return pixel * color * vec4(glow, glow, glow, 1);
    }
  ]])
  return obj
end

return entity

-- raint number 2

local entity = {}

function entity:draw()
  love.graphics.setShader(self.shader)
  love.graphics.draw(self.image, self.x, self.y)
  love.graphics.setShader()
end

function entity:new(x, y, image)
  local obj = { x = x, y = y, image = image }
  setmetatable(obj, { __index = entity })

  -- Create the rainbow effect
  obj.shader = love.graphics.newShader([[
    extern number time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      vec4 pixel = Texel(texture, texture_coords);
      number rainbow = sin(texture_coords.x * 10.0 + time) * 0.5 + 0.5;
      return pixel * color * vec4(1.0, rainbow, rainbow, 1.0);
    }
  ]])
  return obj
end

return entity
