local vec2     = require "tools/vec2"

local Rect = {}

function Rect:new(x,y,w,h)
  local rect = {}

  rect.pos  = vec2:new(x or 0, y or 0)
  rect.size = vec2:new(w or 0, h or 0) 

  return rect
end

return Rect