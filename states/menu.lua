asm:load()
tween = require '/lib/tween/tween'
require 'splash_texts'
asm:add(love.graphics.newImage("assets/images/Doom_1.png"), 'hamster')
menuhelper = require('states/menu/menu_helper')
MenuHelper = menuhelper:new()

local Menu = Game:addState('Menu')

function Menu:load()

end

function Menu:enteredState()
  --it does not matter what your picture for the particle is named I just like to use index.
  local img = love.graphics.newImage("bloodParticle.png")
  --this is us setting our new particle system
  pSystem = love.graphics.newParticleSystem(img, 320)
  --this sets the particles lifetime to between 1 and 5 seconds
  --that will make the particals disappear within 1 to 5 seconds
  pSystem:setParticleLifetime(.9,3)
  --this will make your particals shoot out in diffrent directions
  --this will make your particles look much better
  --you can play with the numbers to make them move in diffrent directions
  pSystem:setLinearAcceleration(-20, -20, 20, 20)
  -- pSystem:setLinearAcceleration(-5, -5, 5, 5)
  -- pSystem:setLinearAcceleration(-10, -10, 10, 10)
  --by doing this it makes our particles shoot out a bit faster
  --you can play with the number to change how fast the particles move out
  -- setspeed maxes in each positive and negative direction
  pSystem:setSpeed(-10,10)
 --this will set the rotation of the particles between 10 and 20
  --change the numbers for diffrent outcomes
  --they will not continue to rotate but they will emit at a rotated angle
  -- pSystem:setRotation(10,20) 
    --the last bit of rotation code has been removed and this will take it's place
  --this will keep rotating the particles
  --this will make the particles rotate at a speed between 20 and 50
  --change the numbers for diffrent outcomes
  -- pSystem:setSpin(20, 50)

  

  -- print('ENTER MENU STATE')
  love.graphics.clear( )
  asm:add(love.graphics.newImage("brian.png"), 'brian')
  local brian = asm:get('brian')
  local hamster = asm:get('hamster')
  renderer:addRenderer(self, 5)

  -- entity componentize and animate this
  self.canvas = love.graphics.newCanvas(32, 32)
   
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
  love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 0, 0, 128)
    love.graphics.rectangle('fill', 0, 0, 100, 100)
    love.graphics.setColor(255, 255, 255, 255)
    -- use the canvas renderer to construct a player avatar from the player model
    love.graphics.draw(brian, 0, 0, 0, 1, 1)
  love.graphics.setCanvas()

end

math.randomseed(os.time())
local rand1 = math.random(#splashWords)
local rand2 = math.random(#splashColors)
local word = splashWords[rand1] 
local dur = 0.5
local sp = {x=400, y=300, sc=1, text = 'This will be ' .. word .. '!'}
local complete = false
local splashTextTween = tween.new(dur, sp, {sc=1.2}, 'linear')

  -- font = love.graphics.newFont("AwesomeFont.ttf", 15)
local font = love.graphics.newImageFont("Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")


-- local font = love.graphics.newImageFont("assets/outlinefont.png",
-- " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")

-- a font for tiny occasions
-- local font = love.graphics.newImageFont("assets/tinyfont.png",
-- " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-=[]\\,./;')!@#$%^&*(+{}!<>?:\"")

local splashColor = splashColors[rand2] 


local function drawCanvas(canvas)
  -- very important!: reset color before drawing to canvas to have colors properly displayed
  -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setBlendMode("alpha")

  -- The rectangle from the Canvas was already alpha blended.
  -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
  -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.

  -- Rectangle is drawn directly to the screen with the regular alpha blend mode.
  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(255, 0, 0, 128)
  love.graphics.rectangle('fill', 200, 0, 100, 100)
  love.graphics.setBlendMode("alpha")
  love.graphics.draw(canvas, 0, 0, 0, 1, 1)

end

local function drawSplashText()
  -- font = the font object you made before
  love.graphics.setFont(font)
  love.graphics.setColor(splashColor)
  love.graphics.print(sp.text,sp.x,sp.y,-.3,sp.sc,sp.sc,50,50,0,0)

end

-- we want multiline on this eventually: https://github.com/riidom/mlvtest/blob/master/multilineview.lua
-- Draggable tutorial: http://nova-fusion.com/2011/09/06/mouse-dragging-in-love2d/
-- https://gist.github.com/a-racoon/1ca3b9f467ed491d404035400dfd8953
rect = {
    x = 700,
    y = 500,
    width = 232,
    height = 232,
    dragging = { active = false, diffX = 0, diffY = 0 }
  }

local easetype = 'outQuad'

function Menu:update(dt)
  --this will update our particle system
  pSystem:update(dt)
  Menu:mousepressed()

  -- splashtext tween
  if complete == true then
    complete = false
    local scale = sp.sc
    if sp.sc == 1.2 then 
      scale =  1 
      easetype = 'inQuad'
    end
    if sp.sc == 1   then 
      scale = 1.2 
      easetype = 'outQuad'
    end
    -- https://github.com/kikito/tween.lua
    --(duration, subject, target, [easing])
    -- print(tostring(sp.x .. sp.y .. sp.sc .. sp.text))
    splashTextTween = tween.new(dur, sp, {sc=scale}, easetype)
  end
  complete = splashTextTween:update(dt)

  if rect.dragging.active then
    rect.x = love.mouse.getX() - rect.dragging.diffX
    rect.y = love.mouse.getY() - rect.dragging.diffY
  end
end

local function drawNote()
  -- draggable rect
  love.graphics.setColor(205, 205, 195, 255)
  love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
  love.graphics.setColor(205, 5, 5, 255)
  love.graphics.printf(sp.text,rect.x+20,rect.y+20,220)
end

function Menu:draw()
  menuhelper:new()
  MenuHelper:drawMenu()
  drawSplashText()
  drawNote()
  drawCanvas(self.canvas)

  --this draws our particles
  --in just a second I will explain why we are getting the mouses position
  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  -- print(mx..my)
  love.graphics.draw(pSystem, mx, my)
end

function Menu:exitedState()
  
  
  love.graphics.clear( )
end

function Menu:keypressed(key, code)
  if key == ('1' or 'return') then self:pushState('Training') end
  if key == ('2' or 'space') then self:pushState('Bizzaro') end
  -- if key == ('3' or 'q') then self:pushState('Space1') end
  if key == ('4' or 'w') then self:pushState('Earth2') end
  if key == ('5') then self:pushState('commando') end
  if key == ('q') then love.event.push('quit') end
end

function Menu:mousepressed(x,y, button , istouch)
   --this checks if you are left clicking, and if you are it runs the code under it
  if love.mouse.isDown(1) then
    print('blood')
    --this says if the user is left clicking then emit 32 particles and since the particles are drawn where the mouse is they come out of the mouse
    pSystem:emit(32) 
  end

  -- draggable note rect
  if button == 1 then
    if x>rect.x then
      if x<rect.x+rect.width then
        if y>rect.y then
          if y<rect.y+rect.height then
            rect.dragging.active = true
            rect.dragging.diffX = x - rect.x
            rect.dragging.diffY = y - rect.y
          end
        end
      end
    end
  end
end
function Menu:mousereleased(x, y, button)
  --draggable note rect
  if button == 1 then 
    rect.dragging.active = false 
  end
end
