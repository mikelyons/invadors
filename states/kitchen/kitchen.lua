--[[
  kitchen.lua

  a kitchen for adding a new gamestate
]]

print('kitchen.lua -> ')
print('kitchen -> ')

-- dependencies
local fanfic = require 'states/menu/fanfic'

text = fanfic.new(200,300, "New textbox", false, 16)

-- registering the gamestate
local Kitchen = Game:addState('kitchen')

-- input
function Kitchen:mousepressed(x,y, button , istouch) end
function Kitchen:mousereleased(x, y, button) end
function Kitchen:keypressed(key, code)
  text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
end

function Kitchen:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER kitchen STATE - %s \n", os.date()))
  end


end
function Kitchen:update(dt)
  text:update(dt)
  data = text:enteredText()
end
  local _r, _g, _b, _a = love.graphics.getColor()

  -- body thumb rule measures TODO improve and encapsulate
  local boxwidth = 300
  local boxheight = 80
  local centerx = camera.pos.x + screen_width/2 - (boxwidth/2)
  local centery = camera.pos.y + screen_height/2

  local head = {
    w = 128,
    h = 128,
    x = centerx + boxwidth/2,
    y = centery - 100,
  }
  local headw = 64
  local headh = 156


-- coffeePot = love.graphics.newImage("assets/machines/computer/computer.png")
coffeePot = love.graphics.newImage("assets/objects/cpot.png")
coffeePot:setFilter("nearest", "nearest")

function Kitchen:draw()

  -- Draw COUNTER
  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255,0,0, 255)
  -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.rectangle(
    'fill',
    0, screen_height - 300, -- x, y
    screen_width, 1511 -- w, h
  )

  -- nipples
  love.graphics.rectangle('fill', 0, 0, 111, 111)
  love.graphics.setColor(_r, _g, _b, _a)
  love.graphics.setColor(245,159,97)
  love.graphics.rectangle("fill",
    centerx+40,
    centery+40,
    32,
    32
  )
  love.graphics.rectangle("fill",
    centerx*2-300,
    centery+40,
    32,
    32
  )

  require('helpers/draw_helpers')
  -- draw coffeePot
  love.graphics.draw(
    coffeePot,
    32, 32,
    nil,
    0.5
  )

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
function Kitchen:exitedState()
  love.graphics.clear()
end
