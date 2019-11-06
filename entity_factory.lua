local entity_factory = {}

local ec = require 'entity_container'
local r  = require('c_rectangle')

function entity_factory:new_rectangle(x,y,w,h)
  local ent = ec:new('rect')

  ent:add_component('rect', r:new(), {x,y,w,h})

  return ent
end

return entity_factory