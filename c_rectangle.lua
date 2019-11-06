local c_rectangle = {}

local lg = love.graphics

function c_rectangle:new() 
  local rect = {}
  function rect:init(args)
    self.x = args[1] or 0
    self.y = args[2] or 0
    self.w = args[3] or 0
    self.h = args[4] or 0
  end
  function rect:tick()end
  function rect:draw()
    lg.setColor(100,100,100,200)
    lg.rectangle('fill', self.x, self.y, self.w, self.h)
    lg.setColor(255,255,255,255)
  end
  return rect
end

return c_rectangle