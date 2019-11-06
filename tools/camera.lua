camera = {
  pos = require('tools/vec2'):new(0,0),
  size = require('tools/vec2'):new(0,0),
  scale = require('tools/vec2'):new(1,1),
  rot = 0
}

local lg      = love.graphics
local pop     = lg.pop
local trans   = lg.translate
local rotate  = lg.rotate
local scale   = lg.scale
local push    = lg.push


function camera:set()
  push()
  trans(-self.pos.x, -self.pos.y)
  rotate(-self.rot)
  scale(1 / self.scale.x, 1 / self.scale.y)
  -- love.graphics.push()
  -- love.graphics.rotate(-self.rotation)
  -- love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  -- love.graphics.translate(-self.x, -self.y)
end

function camera:goToPoint(pos)
  self.pos.x = pos.x * (1/self.scale.x) - g_Width / 2
  self.pos.y = pos.y * (1/self.scale.y) - g_Height / 2
end

function camera:unset()
  pop()
end

return camera

-- function camera:newLayer(scale, func)
--   table.insert(self.layers, { draw = func, scale = scale })
--   table.sort(self.layers, function(a, b) return a.scale < b.scale end)
-- end

-- function camera:move(dx, dy)
--   self._x = self._x + (dx or 0)
--   self._y = self._y + (dy or 0)
-- end

-- function camera:rotate(dr)
--   self.rotation = self.rotation + dr
-- end

-- function camera:scale(sx, sy)
--   sx = sx or 1
--   self.scaleX = self.scaleX * sx
--   self.scaleY = self.scaleY * (sy or sx)
-- end

-- function camera:setX(value)
--   if self._bounds then
--     self._x = math.clamp(value, self._bounds.x1, self._bounds.x2)
--   else
--     self._x = value
--   end
-- end

-- function camera:setY(value)
--   if self._bounds then
--     self._y = math.clamp(value, self._bounds.y1, self._bounds.y2)
--   else
--     self._y = value
--   end
-- end

-- function camera:setPosition(x, y)
--   if x then self:setX(x) end
--   if y then self:setY(y) end
-- end

-- function camera:setScale(sx, sy)
--   self.scaleX = sx or self.scaleX
--   self.scaleY = sy or self.scaleY
-- end

-- function camera:getBounds()
--   return unpack(self._bounds)
-- end

-- function camera:setBounds(x1, y1, x2, y2)
--   self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
-- end

-- function camera:draw()
--   local bx, by = self.x, self.y
  
--   for _, v in ipairs(self.layers) do
--     self.x = bx * v.scale
--     self.y = by * v.scale
--     camera:set()
--     v.draw()
--     camera:unset()
--   end
-- end

-- function math.clamp(x, min, max)
--   return x < min and min or (x > max and max or x)
-- end
