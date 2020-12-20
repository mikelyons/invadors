asm:load()
tween = require '/lib/tween/tween'

require 'states/menu/splash_texts_library'
splashtext = require('states/menu/splash_texts')
SplashText = splashtext:new()

gravatar = require('states/menu/gravatar')
Gravatar = gravatar:new(100,100)

-- test particle
particle = require('../src/particles/baseParticle')
Particle = particle:new(300, 300, img)
Particle:load()

-- blood particle on click
blood = require('../src/particles/blood')
Blood = blood:new(50, 50)
Blood:load()

asm:add(love.graphics.newImage("assets/conversions/invadors.png"), 'hamster')
asm:add(love.graphics.newImage("assets/newer/brian.png"), 'brian')
asm:add(love.graphics.newImage("assets/mouse.png"), 'mouse')

local Menu = Game:addState('Menu')

-- local raint = {['raint'] = 'raintor'}
local raint = {}

  --   print('raint')
  --  PrintTable(Menu)
  --   print('raint')

function startGame()
  Menu:pushState('generate')
end

menuhelper = require('states/menu/menu_helper')
MenuHelper = menuhelper:new(startGame)
MenuHelper:load()
-- MenuHelper:loadButtons()

-- trying to make menuhelper buttons configurable
local menuSelections = {
  {
    ['buttonText'] = 'Start Game',
    ['buttonFn'] = ''
  },
  {
    ['buttonText'] = 'Load Game',
    ['buttonFn'] = ''
  },
  {
    ['buttonText'] = 'Settings',
    ['buttonFn'] = ''
  },
  {
    ['buttonText'] = 'Quit',
    ['buttonFn'] = ''
  }
}

function Menu:keypressed(key, code)
  if key == ('1' or 'return') then self:pushState('Training') end
  if key == ('2' or 'space') then self:pushState('Bizzaro') end
  if key == ('3' or 'q') then self:pushState('space1') end
  if key == ('4' or 'w') then self:pushState('Earth2') end
  if key == ('5') then self:pushState('commando') end
  -- if key == ('6') then self:pushState('generate') end
  if key == ('6') then self:gotoState('generate') end
  
  if key == ('q') then love.event.push('quit') end
end

function Menu:mousepressed(x,y, button , istouch)
  if love.mouse.isDown(1) then
    -- print('click')
    Blood:emit()
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

function Menu:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER Menu STATE - %s \n", os.date()))
  end

  Gravatar:load()

  love.graphics.clear( )
  brian = asm:get('brian')
  hamster = asm:get('hamster')

  -- THIS CRUCIAL STEP needs to be added for all other renderables!! @TODO
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
  Menu:mousepressed()

  Particle:update(dt)
  Blood:update(dt)

  SplashText:update(dt)

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
  love.graphics.printf(SplashText:getText(),rect.x+20,rect.y+20,220)
  love.graphics.setColor(255, 255, 255, 255)
end

function Menu:draw()
  MenuHelper:drawMenu()

  -- love.graphics.setColor(255, 255, 255, 255)
  MenuHelper:drawButtons()

  SplashText:draw()
  Gravatar:draw()

  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  Particle:draw()
  Blood:draw(mx, my)


  -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
  love.mouse.isVisible(false)
  -- draw a pointer
  love.graphics.draw(brian, mx, my)
  -- love.graphics.draw(mouse, mx, my)

  drawNote()
  drawCanvas(self.canvas)
end

function Menu:exitedState()
  love.graphics.clear()
end
