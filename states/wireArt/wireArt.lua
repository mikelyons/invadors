--[[
  wireArt.lua

  a wireArt for adding a new gamestate

  generates a copper wire with 10 twists in it

  @TODO
  - add a twist each time you press a button (animate this?)
  - finish the twists and then make them draggable
  - physics and kinematics?
  - saving sculptures
    - serialize? or image and load
  -
  - videos to watch
    - https://www.youtube.com/watch?v=odwEphAwX5M&list=PLYBJzqz8zpWYip5ZkTMQiOkqya9Iiefm9
]]

print('wireArt.lua -> ')

local colors = {
  {152, 80, 6},
  {212, 116, 26},
}


-- dependencies
-- local fanfic = require 'states/menu/fanfic'

-- text = fanfic.new(200,300, "New textbox", false, 16)

-- registering the gamestate
local WireArt = Game:addState('wireArt')

-- input
function WireArt:mousepressed(x,y, button , istouch) end
function WireArt:mousereleased(x, y, button) end
function WireArt:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end

  -- text:keypressed(key, code)

  if key == ('w') then
    -- love.event.push('quit')
    -- addTwist()
    draw2WireTwist(100)
    print("draw more wire")
    raintor = raintor + 1
  elseif key == ('s') then
    raintor = raintor + 2
  end

  -- if key == ('escape') then love.event.push('quit') end
end

function WireArt:enteredState()
print('wireArt -> ')
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER wireArt STATE - %s \n", os.date()))
  end
  raintor = 10
end
function WireArt:update(dt)
  -- text:update(dt)
  -- data = text:enteredText()
end
function WireArt:draw()
  -- store colors and linewidth from before
  local _r, _g, _b, _a = love.graphics.getColor()
  local _linewidth = love.graphics.getLineWidth()


  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	-- text:draw()
	if data then
		love.graphics.setColor(255,255,255)
		-- love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
		love.graphics.print(
      "You typed: '"
      .."RAINT"
      .."' in the text box"
      , 200, 350
    )
    -- DO SOMTHING todo ToDO WITH THE DATA
	end

  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(200, 55, 55, 255)
  love.graphics.line(200,50, 400,50, 500,300, 100,300, 200,50)   -- last pair is a repeat to complete the trapezoid

  -- local x = 200
  -- local y = 50

  local margin_x = 20
  local margin_y = 20
  local wrap_distance = 20
  local wrap_count = 1
  local wrap_width = 20
  local ww = wrap_width

  local x2 = margin_x + margin_x * wrap_count
  local y2 = margin_y + margin_y * wrap_count



  local line = {
    margin_x,margin_y,
    x2,y2,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- 200,50,
  }

  -- line[#line+1] = x2+ww*#line
  line[#line+1] = margin_x
  line[#line+1] = y2+ww*#line

  -- love.graphics.print("You typed: '"..
  -- y2 + ww * #line
  -- .."' in the text box", 200, 350)

  -- draw the lines
  -- love.graphics.setColor(212, 116, 26, 255)
  love.graphics.setColor(colors[1])
  -- love.graphics.line(line)
  -- love.graphics.line(
  --   200,50,
  --   400,50,
  --   500,300,
  --   100,300,
  --   200,50)   -- last pair is a repeat to complete the trapezoid

  love.graphics.setLineWidth( 3 )

  -- line style doesn't work because we are pixel-perfect rendering
  -- love.graphics.setLineStyle( "rough" )
  -- love.graphics.setLineStyle( "smooth" )

  draw2WireTwist(raintor or 10)

  -- reset drawing color
  -- reset the line width
  love.graphics.setColor(_r, _g, _b, _a)
  love.graphics.setLineWidth( _linewidth )
end

-- local wire1 = {}
-- local wire2 = {}
-- local wire1 = {}

-- put the wire to the next fold node position
function calculateNextBend() end

-- insert the x and y coordinates into the wire's table
function insertNextWireEndPosition() end

-- draw a twisted wire n twists in length
function draw2WireTwist(n)
  local _r, _g, _b, _a = love.graphics.getColor()
  local wire = {}

  local wire1 = {}
  local wire2 = {}

  local margin_x = 20
  local margin_y = 20
  local wrap_distance = 20
  local wrap_count = 1
  local wrap_width = 20
  local ww = wrap_width

  -- 10 times generate x and y zig zagging coords
  for i=1,n or raintor or 10 do
    if (i % 2 == 0) then
      wire[#wire+1] = margin_x -- X
      wire[#wire+1] = (margin_y * (i / 2))  -- Y
    else
      wire[#wire+1] = margin_x + 20 -- X
      wire[#wire+1] = (margin_y * (i / 2))  -- Y
    end
  end
  -- then print that line
  -- @TODO - use the table for multiple lines so it looks like a metalic gradient
  love.graphics.line(wire)

  -- again for wire2
  for i=2,n or raintor+1 or 11 do
    if (i % 2 == 0) then
      wire2[#wire2+1] = margin_x + 20 -- X
      wire2[#wire2+1] = (margin_y * (i / 2))  -- Y
    else
      wire2[#wire2+1] = margin_x -- X
      wire2[#wire2+1] = (margin_y * (i / 2))  -- Y
    end
  end
  love.graphics.setColor(colors[2])
  love.graphics.line(wire2)

  love.graphics.setColor(212, 116, 26, 255)
  love.graphics.print("You twisted a copper wire '"..
  raintor
  .."' times", 200, 350)
  love.graphics.setColor(_r, _g, _b, _a)
end

function WireArt:exitedState()
  love.graphics.clear()
end
