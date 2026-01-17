--[[
  kitchen.lua

  a kitchen for adding a new gamestate
  @TODO
  - drag and drop
  - coffee maker
  - fridge
  - counter top
    - use trapezoid texture transform for counter top perspective
  - physics

  @KNOWN ISSUES
  - exiting this state breaks the menu.lua - probably conflicting variable name in global scope

]]
if DEBUG_LOGGING_LOADING then
  print('kitchen.lua -> ')
  print('kitchen -> ')
end

-- dependencies

require 'states/kitchen/kitchen-items'

-- registering the gamestate
local Kitchen = Game:addState('kitchen')

function Kitchen:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER kitchen STATE - %s \n", os.date()))
  end

  -- Load images safely
  local success1, raintar_img = pcall(love.graphics.newImage, "states/kitchen/coffee-bag.png")
  if success1 then
    raintar = raintar_img
    raintar:setFilter("nearest", "nearest")
  else
    print("Error loading coffee-bag.png:", raintar_img)
    raintar = nil
  end

  local success2, coffee_pot_img = pcall(love.graphics.newImage, "assets/objects/cpot.png")
  if success2 then
    coffeePot = coffee_pot_img
    coffeePot:setFilter("nearest", "nearest")
  else
    print("Error loading cpot.png:", coffee_pot_img)
    coffeePot = nil
  end

  rect = {
    image = raintar,
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
  -- Get screen dimensions safely
  local screen_w = love.graphics.getWidth()
  local screen_h = love.graphics.getHeight()
  
  coffee_pot = {
    image = coffeePot,
    x = 32,
    y = screen_h - 32 - 256 - 256,
    w = 100,
    h = 100,
    dragging = {
      active = false,
      dx = 0,
      dy = 0
    }
  }
  dropCollider = {
    x = 100,
    y = 100,
    w = 100,
    h = 100
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
  -- if key == ('escape') then self:popState('kitchen') end
  if key == ('escape') then self:gotoState('menu') end
end

function Kitchen:update(dt)
  if rect.dragging.active == true then
    -- rect.dragging.dx = x - rect.x
    -- rect.dragging.dy = y - rect.y
    rect.x = love.mouse.getX() - rect.dragging.dx
    rect.y = love.mouse.getY() - rect.dragging.dy
    -- if true -- button == 1
    --   and dropCollider.x>rect.x and dropCollider.x<rect.x+rect.w
    --   and dropCollider.y>rect.y and dropCollider.y<rect.y+rect.h
    -- then -- the mouse collision check for dropping
    --   print('drop collided!')
    -- end
  end
end

  local _r, _g, _b, _a = love.graphics.getColor()

  -- Get screen dimensions safely
  local screen_w = love.graphics.getWidth()
  local screen_h = love.graphics.getHeight()

  -- body thumb rule measures TODO improve and encapsulate
  local boxwidth = 300
  local boxheight = 80
  
  -- Get camera position safely
  local cam_x = 0
  local cam_y = 0
  if camera and camera.pos then
    cam_x = camera.pos.x
    cam_y = camera.pos.y
  end
  
  local centerx = cam_x + screen_w/2 - (boxwidth/2)
  local centery = cam_y + screen_h/2


-- coffeePot = love.graphics.newImage("assets/machines/computer/computer.png")

-- the kitchen counter
-- use https://love2d.org/wiki/TexturedPolygon to make perspective with a trapezoid
-- https://love2d.org/forums/viewtopic.php?f=5&t=12483
local success3, tempdesk_img = pcall(love.graphics.newImage, "states/computer/wood.png")
if success3 then
  tempdesk = tempdesk_img
else
  print("Error loading wood.png:", tempdesk_img)
  tempdesk = nil
end
-- tempdesk_transform = love.math.newTransform(
-- 660, 500,
-- 0,
-- .2, .2,
-- nil, nil,
-- 0.1, 0)
function Kitchen:draw()
  -- Get screen dimensions safely
  local screen_w = love.graphics.getWidth()
  local screen_h = love.graphics.getHeight()
  
  -- Draw kitchen COUNTER top
  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255,0,0, 255)
  -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.rectangle(
    'fill',
    0, screen_h - 300, -- x, y
    screen_w, 1511 -- w, h
  )

  -- wall
  -- -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.setColor(155,100,100, 255)
  love.graphics.rectangle(
    'fill',
    0, 0, -- x, y
    screen_w, screen_h-- w, h
  )

  --desk
  love.graphics.setColor(255,255,255, 255)
  -- love.graphics.draw(tempdesk, tempdesk_transform)

  if tempdesk then
    love.graphics.draw(
      tempdesk, -- wood
      0, screen_h-300,
      nil,
      6,
      1.92
    )
  end
  -- END DESK


  -- rect for dragdrop
  -- love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)


  -- nothing relevant in here yet
  -- require('helpers/draw_helpers')

  -- draw coffeePot
  if coffee_pot and coffee_pot.image then
    love.graphics.draw(
      coffee_pot.image,
      -- 32, screen_h - 32 - 256 - 256,
      coffee_pot.x, coffee_pot.y,
      nil,
      0.5
    )
  end


  -- love.graphics.draw(drawable,
    -- x,y,
    -- r,
    -- sx,sy,
    -- ox,oy)
  if rect and rect.image then
    love.graphics.draw(rect.image,
      rect.x, rect.y,
      nil,
      3, 3,
      nil,
      nil
    )
  end

  -- ensure proper gravatar color
  -- local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

end
function Kitchen:exitedState()
  -- does nothing?
  -- love.graphics.clear()
end