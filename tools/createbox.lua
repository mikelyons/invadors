local b = {}

function b:create(x,y)
  local b = {}
  
  b.x = x or 0
  b.y = y or 0

  function b:load()
    renderer:addRenderer(self, 1)
  end

  function b:draw()
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.rectangle("fill",self.x,self.y,64,64)
  end

  function b:tick(dt)
    print(dt, math.random())
  end

  return b
end

function b:createRandom()
  local b = {}
  
  b.x = math.random(0,love.graphics.getWidth())
  b.y = math.random(0,love.graphics.getHeight())

  function b:load()
    renderer:addRenderer(self, 1)
  end

  function b:draw()
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.rectangle("fill",self.x,self.y,64,64)
  end

  function b:tick(dt)
    print(dt, math.random())
  end

  return b
end

return b
