--[[
  kitchen.lua

  a kitchen for adding a new gamestate
  @TODO
  - drag and drop
  - coffee maker
  - fridge
  - counter top
  - physics

  @KNOWN ISSUES
  - exiting this state breaks the draggable rect for evilnote in menu.lua - probably conflicting variable name in global scope

]]

print('kitchen.lua -> ')
print('kitchen -> ')

-- dependencies

-- registering the gamestate
local Kitchen = Game:addState('kitchen')

function Kitchen:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER kitchen STATE - %s \n", os.date()))
  end

  raintar = love.graphics.newImage("states/kitchen/coffee-bag.png")
  raintar:setFilter("nearest", "nearest")

  rect = {
    x = 100,
    y = 100,
    w = 100,
    h = 100,
    dragging = {
      active = false,
      dx = 0,
      dy = 0
    }
  }
end

-- input
function Kitchen:mousepressed(x,y, button , istouch)
  if button == 1 and x>rect.x and x<rect.x+rect.w and y>rect.y and y<rect.y+rect.h then -- the mouse collision check for grabbing
    rect.dragging.active = true
    rect.dragging.dx = x - rect.x
    rect.dragging.dy = y - rect.y
  end
end
function Kitchen:mousereleased(x, y, button)
  if button == 1 then
    rect.dragging.active = false
  end
end
function Kitchen:keypressed(key, code)
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('kitchen') end
  -- if key == ('escape') then love.event.push('quit') end
end

function Kitchen:update(dt)
  if rect.dragging.active == true then
    -- rect.dragging.dx = x - rect.x
    -- rect.dragging.dy = y - rect.y
    rect.x = love.mouse.getX() - rect.dragging.dx
    rect.y = love.mouse.getY() - rect.dragging.dy
  end
end

  local _r, _g, _b, _a = love.graphics.getColor()

  -- body thumb rule measures TODO improve and encapsulate
  local boxwidth = 300
  local boxheight = 80
  local centerx = camera.pos.x + screen_width/2 - (boxwidth/2)
  local centery = camera.pos.y + screen_height/2


-- coffeePot = love.graphics.newImage("assets/machines/computer/computer.png")
coffeePot = love.graphics.newImage("assets/objects/cpot.png")
coffeePot:setFilter("nearest", "nearest")

tempdesk = love.graphics.newImage("states/computer/wood.png")
function Kitchen:draw()
  -- Draw kitchen COUNTER top
  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255,0,0, 255)
  -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.rectangle(
    'fill',
    0, screen_height - 300, -- x, y
    screen_width, 1511 -- w, h
  )

  -- wall
  -- -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.setColor(155,100,100, 255)
  love.graphics.rectangle(
    'fill',
    0, 0, -- x, y
    screen_width, screen_height-- w, h
  )

  --desk
  love.graphics.setColor(255,255,255, 255)
  love.graphics.draw(
    tempdesk, -- wood
    0, screen_height-300,
    nil,
    6,
    1.92
  )
  -- END DESK


  -- rect for dragdrop
  love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)


  -- nothing relevant in here yet
  -- require('helpers/draw_helpers')

  -- draw coffeePot
  love.graphics.draw(
    coffeePot,
    32, screen_height - 32 - 256 - 256,
    nil,
    0.5
  )

  love.graphics.draw(raintar,
    320, 320,
    nil,
    10.5
  )

  -- ensure proper gravatar color
  -- local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

end
function Kitchen:exitedState()
  love.graphics.clear()
end
