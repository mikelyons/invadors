local vec2 = require "tools/vec2"
local rect = require "objects/rect"

local Entity = {}

function Entity:new(x,y,w,h,img,quad,id)
  local entity = rect:new(x,y,w,h)

  entity.id         = id or "Entity"

  entity.pos        = vec2:new(x,y)
  entity.size       = vec2:new(w,h)

  entity.velocity   = vec2:new(0,0)
  entity.direction  = vec2:new(0,0)
  entity.speed      = vec2:new(0,0)

  entity.remove = false

  function entity:load( ) end
  function entity:tick(dt) end
  function entity:draw( ) end


  return entity
end


return Entity