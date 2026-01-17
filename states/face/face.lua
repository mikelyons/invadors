
--[[
  face.lua

  The gamestate for designing the interrogation face
]]

print('face.lua -> ')
-- dependencies
print('face -> ')

local colors = {
  {255,209,127} -- flesh tone
}

local Face = Game:addState('face') -- registering the gamestate

function Face:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER face STATE - %s \n", os.date())) end

  -- Face.face = require('objects/entity'):new(
  --   64,64,32,32,nil,nil,"face"
  -- )
  -- WIP @TODO - this needs to be made like wires.lua
  self.pos = {x=0,y=0}
  self.size = {w=100,y=100}

end
function Face:exitedState() love.graphics.clear() end

function Face:update(dt) end

drawman = require 'states/face/man1'
function Face:draw()
  -- store resets
  local _r, _g, _b, _a = love.graphics.getColor()

  -- drawman:drawMan()
  -- drawman:drawskull()
  -- drawman:secondskull()
  -- drawman:skully()
  drawman:pencil()

  -- -- face 1
  -- -- love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.setColor(colors[1])
  -- love.graphics.ellipse("fill",100,100, 100,50)

  -- -- --eyes
  -- love.graphics.setColor(255, 255, 255, 255)
  -- love.graphics.ellipse("fill",100+20,100+10, 10,10)

  -- -- face 2
  -- -- -- Draw the head (ellipse)
  -- love.graphics.setColor(255, 210, 179)
  -- love.graphics.ellipse("fill", 128, 128, 100, 120)

  -- -- -- Draw the eyes (circles)
  -- love.graphics.setColor(255, 255, 255)
  -- love.graphics.circle("fill", 88, 100, 20)
  -- love.graphics.circle("fill", 168, 100, 20)

  -- -- -- Draw the mouth (half-ellipse)
  -- love.graphics.setColor(255, 0, 0)
  -- love.graphics.arc("fill", 128, 170, 40, math.pi, 2 * math.pi)


  -- -- face 3
  --     -- Draw the head (ellipse)
  --   love.graphics.setColor(255, 210, 179)
  --   love.graphics.ellipse("fill", 128, 128, 100, 120)

  -- --   -- Draw the eyes (whites)
  --   love.graphics.setColor(255, 255, 255)
  --   love.graphics.circle("fill", 100, 110, 18)
  --   love.graphics.circle("fill", 156, 110, 18)

  -- --   -- Draw the irises (blue)
  --   love.graphics.setColor(0, 0, 255)
  --   love.graphics.circle("fill", 100, 110, 8)
  --   love.graphics.circle("fill", 156, 110, 8)

  -- --   -- Draw the nose (triangle)
  --   love.graphics.setColor(255, 210, 179)
  --   love.graphics.polygon("fill", 128, 125, 120, 140, 136, 140)

  -- --   -- Draw the mouth (arc)
  --   love.graphics.setColor(255, 0, 0)
  --   love.graphics.arc("fill", 128, 160, 35, math.pi / 7, 6 * math.pi / 7)


  -- -- face 4
  --     -- Draw the head (ellipse)
  --   love.graphics.setColor(255, 210, 179)
  --   love.graphics.ellipse("fill", 128, 128, 100, 120)

  -- --   -- Draw shading for the eyes (darker ovals)
  --   love.graphics.setColor(230, 230, 230)
  --   love.graphics.ellipse("fill", 100, 110, 18, 12)
  --   love.graphics.ellipse("fill", 156, 110, 18, 12)

  -- --   -- Draw the eyes (whites)
  --   love.graphics.setColor(255, 255, 255)
  --   love.graphics.circle("fill", 100, 110, 12)
  --   love.graphics.circle("fill", 156, 110, 12)

  -- --   -- Draw the irises (blue)
  --   love.graphics.setColor(0, 0, 255)
  --   love.graphics.circle("fill", 100, 110, 6)
  --   love.graphics.circle("fill", 156, 110, 6)

  -- --   -- Draw shading for the nose (darker triangle)
  --   love.graphics.setColor(230, 230, 230)
  --   love.graphics.polygon("fill", 128, 125, 120, 140, 136, 140)

  -- --   -- Draw the nose (triangle)
  --   love.graphics.setColor(255, 210, 179)
  --   love.graphics.polygon("fill", 128, 128, 120, 140, 136, 140)

  --   -- Draw shading for the mouth (darker arc)
  --   love.graphics.setColor(100, 0, 0)
  --   love.graphics.arc("fill", 128, 160, 35, math.pi / 7, 6 * math.pi / 7)

  --   -- Draw the mouth (red arc)
  --   love.graphics.setColor(255, 0, 0)
  --   love.graphics.arc("fill", 128, 160, 33, math.pi / 7, 6 * math.pi / 7)


  -- reset
  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Face:mousepressed(x,y, button , istouch) end
function Face:mousereleased(x, y, button) end
function Face:keypressed(key, code)

  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('face') end
end

--[[
-- Template code removed to avoid fanfic module system issues
]]
