--[[
  book.lua

  The gamestate for reading books
]]

print('book.lua -> ')
print('book -> ')

-- dependencies
local fanfic = require 'states/menu/fanfic'

local text = fanfic.new(200,300, "New textbox", false, 16)

bookGraphic = love.graphics.newImage("assets/machines/computer/computer.png")
fingers = love.graphics.newImage("states/book/fingers.png")
bookGraphic:setFilter("nearest", "nearest")

-- registering the gamestate
local Book = Game:addState('book')

-- input
function Book:mousepressed(x,y, button , istouch) end
function Book:mousereleased(x, y, button) end
function Book:keypressed(key, code)
  text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
end

function Book:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER book STATE - %s \n", os.date()))
  end
end
function Book:update(dt)
  text:update(dt)
  data = text:enteredText()
end
function Book:draw()
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
		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end
end
function Book:exitedState()
  love.graphics.clear()
end
