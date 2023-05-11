--[[
  template.lua

  a template for adding a new gamestate
]]

print('template.lua -> ')
print('template -> ')

-- dependencies
local fanfic = require 'states/menu/fanfic'

text = fanfic.new(200,300, "The shopkeep says, 'greetings'", false, 16)

-- registering the gamestate
local Shop = Game:addState('shop')

-- input
function Shop:mousepressed(x,y, button , istouch) end
function Shop:mousereleased(x, y, button) end
function Shop:keypressed(key, code)
  text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
end

function Shop:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER shop STATE - %s \n", os.date()))
  end
end
function Shop:update(dt)
  text:update(dt)
  data = text:enteredText()
end
function Shop:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	text:draw()
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print("You say: '"..data.."' to the shopkeep.", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end
end
function Shop:exitedState()
  love.graphics.clear()
end
