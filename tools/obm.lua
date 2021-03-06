-- Object manager
local OBM = {}

function OBM:load()
  self.objects = {}
  gameloop:addLoop(self)
end
function OBM:tick(dt)
  for i = #self.objects,1,-1 do
    local obj = self.objects[i]
    if obj.remove then
      table.remove(self.objects,i)
    end
  end
end
function OBM:add(obj)
  obj:load()
  table.insert(self.objects, obj)
end

function OBM:get_closest_by_id(obj, id)
  local o = 0

  for i = 1, #self.objects do
    local _obj = self.objects[i]
    if _obj.id == id then
      return _obj
    end
  end

  return nil
end

return OBM
