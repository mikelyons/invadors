--[[
  marina.lua

  the state of topdown exploration of a marina
]]

print('marina.lua -> ')
print('marina -> ')

-- dependencies
-- local fanfic = require 'states/menu/fanfic'

-- text = fanfic.new(200,300, "New textbox", false, 16)

-- registering the gamestate
local Marina = Game:addState('marina')

-- input
function Marina:mousepressed(x,y, button , istouch) end
function Marina:mousereleased(x, y, button) end
function Marina:keypressed(key, code)
  -- text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
end

function Marina:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER marina STATE - %s \n", os.date()))
  end
end
function Marina:update(dt)
  -- text:update(dt)
  -- data = text:enteredText()
end
function Marina:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()

  love.graphics.setColor(0, 255, 255, 255)
  love.graphics.print("You typed: '' in the text box?", 200, 350)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	-- text:draw()
	-- if data then
	-- 	love.graphics.setColor(255,255,255)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
  --   -- DO SOMTHING todo ToDO WITH THE DATA
	-- end
  love.graphics.setColor(_r, _g, _b, _a)
end
function Marina:exitedState()
  love.graphics.clear()
end
