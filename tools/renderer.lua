local Renderer = {}

local num_of_layers = 5
local layer_table = {
  ['foreground']  = 1,
  ['solid']       = 2,
  ['background']  = 3,
  ['layer4']      = 4,
  ['layer5']      = 5
}
local insert = table.insert
local remove = table.remove

function Renderer:create()
  local renderer = {}

  renderer.drawers = {}
  for i = 0,num_of_layers do
    renderer.drawers[i] = {}
  end

  function renderer:addRenderer( obj, layer )
    -- print("ADDING RENDERER obj: "..obj or "unknown")
    -- PrintTable(obj)
    -- PrintTable(self)
    print("ADD RENDERER # "..#self.drawers.." layer "..layer or 'unknown')
    local l = layer or 0
    insert(self.drawers[l], obj)
  end

  function renderer:draw()
    for layer = 0, #self.drawers do
      for draw = 0, #self.drawers[layer] do
        local obj = self.drawers[layer][draw]
        if obj ~= nil then
          obj:draw()
        end
      end
    end
  end

  return renderer
end

return Renderer

