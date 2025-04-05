--[[
  wireArt.lua

  a wireArt for adding a new gamestate
  generates a copper wire with 10 twists in it

  @TODO
  - **drive the twist functions with objects from the wire class**
  - 
  - add a twist each time you press a button (animate this?)
  - finish the twists and then make them draggable
  - physics and kinematics?
  - saving sculptures
    - serialize? or image and load
  
  - videos to watch
    - https://www.youtube.com/watch?v=odwEphAwX5M&list=PLYBJzqz8zpWYip5ZkTMQiOkqya9Iiefm9
]]
print('wireArt.lua -> ')

-- dependencies
-- local Wire = require 'states/wireArt/wire'
local WireArt = Game:addState('wireArt') -- registering the gamestate

-- wire colors @TODO move this
local colors = {
  {152, 80, 6, 255}, -- dark copper
  {212, 116, 26, 255}, -- light copper
  {100, 100, 100, 255}, -- Titanium
  {200, 200, 200, 255}, -- silver
}

-- named colors based on wire material, move into wire class
local namedColors = {
  tarnishedCopper = {152, 80, 6}, -- dark copper
  copper = {212, 116, 26}, -- light copper
  titanium = {100, 100, 100}, -- Titanium
  silver = {200, 200, 200}, -- silver
}

function WireArt:enteredState()
  print('wireArt -> ')
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER wireArt STATE - %s \n", os.date()))
  end

  -- Start repeating after 0.5 seconds, with 0.1 second intervals
  love.keyboard.setKeyRepeat(true)


  WireArt.number_of_wires = 20 -- angled wires

  WireArt.wires = {
    -- Wire:new(10, 20, 'copper', 1) -- @TODO - move this into the wire class
  }

  -- insert angled wires into the wires table
  -- for i = 1, WireArt.number_of_wires, 1 do
  --   table.insert(WireArt.wires,
  --     Wire:new(10, 20 * i)
  --   )
  -- end

  -- set the raintor to 10, a number to read for debugging
  raintor = 10
end

function WireArt:update(dt) end

function WireArt:draw()
  -- store colors and linewidth from before
  local _r, _g, _b, _a = love.graphics.getColor()
  local _linewidth = love.graphics.getLineWidth()



  -- draw crafting bench - red trapezoid - fill with color

  love.graphics.setColor(25, 130, 25, 255)
  love.graphics.polygon('fill', {200,50, 400,50, 500,300, 100,300, 200,50})   -- last pair is a repeat to complete the trapezoid

  love.graphics.setLineWidth( 10 )
  love.graphics.setColor(200, 155, 95, 255)
  love.graphics.line(200,50, 400,50, 500,300, 100,300, 200,50)   -- last pair is a repeat to complete the trapezoid
  love.graphics.setLineWidth( _linewidth ) -- reset the line width

  -- draw the angled wires
  -- for i = 1, WireArt.number_of_wires, 1 do
  --   WireArt.wires[i]:draw()
  -- end


  -- debugging coordinates for moving wires aroudd
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
    -- 200,50,
  }

  -- line[#line+1] = x2+ww*#line
  line[#line+1] = margin_x
  line[#line+1] = y2+ww*#line


  -- line style doesn't work because we are pixel-perfect rendering
  -- love.graphics.setLineStyle( "rough" )
  -- love.graphics.setLineStyle( "smooth" )

  -- print the number of wires in the wallet
  love.graphics.setColor(212, 116, 26, 255)
  love.graphics.print("Your wallet contains "..WireArt.number_of_wires.." wires", 100, 150)

  -- this removes sub-pixel blurring
  love.graphics.setLineStyle("rough")
  love.graphics.setLineWidth( 1 )
  -- love.graphics.setDefaultFilter('nearest', 'nearest') -- this seems to do nothing
  draw2WireTwist(raintor or 10, 0)
  draw2WireTwist(raintor or 10, 100)
  drawWireWrap()

  love.graphics.setColor(_r, _g, _b, _a) -- reset drawing color
  love.graphics.setLineWidth( _linewidth ) -- reset the line width
end


function calculateNextBend() end -- put the wire to the next fold node position
function insertNextWireEndPosition() end -- insert the x and y coordinates into the wire's table

-- draw a twisted wire n twists in length
function draw2WireTwist(n, spacing, color)
  local _r, _g, _b, _a = love.graphics.getColor()
  local wire = {}

  -- tables that track the coordinates of each bend in each wire
  local wire1 = {}
  local wire2 = {}

  local margin_x = 20 + spacing
  local margin_y = 20
  local wrap_distance = 20
  local wrap_count = 1
  local wrap_width = 20
  local ww = wrap_width

  -- 10 times generate x and y zig zagging coords
  for i=1, n or raintor or 10 do
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
  if color == 'copper' then
    love.graphics.setColor(colors[1])
  else
    love.graphics.setColor(colors[4])
  end
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
  if color == 'copper' then
    love.graphics.setColor(colors[2])
  else
    love.graphics.setColor(colors[3])
  end
  love.graphics.line(wire2)

  -- print the number of twists logged in raintor
  love.graphics.setColor(212, 116, 26, 255)
  love.graphics.print("You twisted a copper wire '"..  raintor .."' times", 200, 350)

  love.graphics.setColor(_r, _g, _b, _a) -- reset drawing color
end

local wireWrap = {}
wireWrap.x = 100
wireWrap.y = 100
wireWrap.length = 500

-- draw a thick wire with a thin wire wrapped around it
function drawWireWrap(n)
  -- print('drawWireWrap')
  local _r, _g, _b, _a = love.graphics.getColor()
  local _linewidth = love.graphics.getLineWidth()

  -- getting the thin wire reppeated on wraps is a loop or should it be a texture?

  -- -- thick wire
  -- love.graphics.setColor(200, 155, 95, 255)
  love.graphics.setColor(namedColors['silver'])
  love.graphics.setLineWidth( 9 )
  love.graphics.line(wireWrap.x-2, wireWrap.y, wireWrap.x + wireWrap.length + 2, wireWrap.y)
  love.graphics.setColor(namedColors['copper'])
  love.graphics.setLineWidth( 5 )
  love.graphics.line(wireWrap.x, wireWrap.y, wireWrap.x + wireWrap.length, wireWrap.y)

  -- love.graphics.line(200,50, 400,50, 500,300, 100,300, 200,50)   -- last pair is a repeat to complete the trapezoid
  -- love.graphics.setLineWidth( _linewidth ) -- reset the line width

  -- -- thin wire
  love.graphics.setColor(namedColors['tarnishedCopper'])
  love.graphics.setLineWidth( 1 )
  -- for i = 1, n or 10 do
  --   love.graphics.line(wireWrap.x, wireWrap.y, wireWrap.x + wireWrap.length, wireWrap.y)
  -- end

  -- 10 times generate x and y zig zagging coords
  local offx = wireWrap.x + 10
  local offy = wireWrap.y - 5

  for i=1, raintor or 100, 1 do
    -- love.graphics.line(
    --   offx + 6*i, offy,
    --   offx + 6*i, offy + 10
    -- )
    if (i % 2 == 0) then
      love.graphics.line(
        offx + i, offy,
        offx + i, offy + 10
      )
    else
      love.graphics.line(
        offx + i, offy + 2,
        offx + i, offy + 8
      )
    end
  end
  love.graphics.setLineWidth( _linewidth ) -- reset the line width
  love.graphics.setColor(_r, _g, _b, _a) -- reset drawing color
end

-- input
function WireArt:mousepressed(x,y, button , istouch) end
function WireArt:mousereleased(x, y, button) end

function WireArt:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  if key == ('w') then
    -- addTwist()
    draw2WireTwist(100, math.random(10, 100), 'copper')
    -- print("draw more wire")
    raintor = raintor + 1
  elseif key == ('s') then
    raintor = raintor + 2
  end
  -- if key == ('d') then
  --   drawWireWrap()
  -- end

  -- if key == ('escape') then love.event.push('quit') end
end

function WireArt:exitedState()
  love.keyboard.setKeyRepeat(false) -- disable key repeat
  love.graphics.clear()
end
