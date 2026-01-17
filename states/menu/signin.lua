print('signin.lua -> ')

-- Load fanfic library
local success, fanfic = pcall(require, 'lib/fanfic')
if not success then
  print("Error loading fanfic:", fanfic)
  fanfic = nil
else
  print("Signin: fanfic loaded")
end

print('signin -> ')
text = nil

local Signin = Game:addState('signin')

-- menuhelper = require('states/menu/menu_helper')
-- MenuHelper = menuhelper:new(startGame)
-- MenuHelper:load()
-- MenuHelper:loadButtons()


function Signin:mousepressed(x,y, button , istouch) end
function Signin:mousereleased(x, y, button) end
function Signin:keypressed(key, code)
  if text and text.keypressed then
    text:keypressed(key, code)
  end
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('return') then self:pushState('signin-success') end

  if key == ('escape') then self:popState('signin') end
  if key == ('escape') then self:popState('signin-success') end
end

function Signin:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER Signin STATE - %s \n", os.date()))
  end

  -- Gravatar:load()
  -- love.graphics.clear( )

  -- really? vvv
  -- THIS CRUCIAL STEP needs to be added for all other renderables!! @TODO
  renderer:addRenderer(self, 5)
  
  -- Initialize text input if fanfic is available
  if fanfic then
    text = fanfic.new(200, 300, "Enter your email:", false, nil, 16)
    print("Signin: Text input initialized")
  else
    print("Signin: Warning - No text input available")
  end

  -- entity componentize and animate this
  -- self.canvas = love.graphics.newCanvas(32, 32)
   
    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
  -- love.graphics.setCanvas(self.canvas)
  --   love.graphics.clear()
  --   love.graphics.setBlendMode("alpha")

  --   love.graphics.setColor(255, 0, 0, 128)
  --   love.graphics.rectangle('fill', 0, 0, 100, 100)
  --   -- love.graphics.rectangle('fill', 100, 100, 100, 100)
  --   -- love.graphics.rectangle('fill', 200, 200, 100, 100)
  --   -- love.graphics.rectangle('fill', 0, 0, 200, 200)
  --   -- love.graphics.rectangle('fill', 0, 0, 300, 300)

  --   love.graphics.setColor(255, 255, 255, 255)
  --   -- use the canvas renderer to construct a player avatar from the player model
  --   love.graphics.draw(brian, 0, 0, 0, 1, 1)
  -- love.graphics.setCanvas()

end

local function drawCanvas(canvas)
  -- very important!: reset color before drawing to canvas to have colors properly displayed
  -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
  -- local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(255, 255, 255, 255)
  -- love.graphics.setBlendMode("alpha")

  -- The rectangle from the Canvas was already alpha blended.
  -- Use the premultiplied alpha blend mode when drawing the Canvas itself to prevent improper blending.
  -- Observe the difference if the Canvas is drawn with the regular alpha blend mode instead.

  -- 3 semi-transparent red Rectangles drawn directly to the screen
  -- with the regular alpha blend mode.
  -- love.graphics.setBlendMode("alpha")
  -- love.graphics.setColor(255, 0, 0, 128)
  -- love.graphics.rectangle('fill', 200, 0, 100, 100)
  -- love.graphics.rectangle('fill', 300, 0, 200, 200)
  -- love.graphics.rectangle('fill', 200, 200, 300, 300)

  -- love.graphics.draw(canvas, 0, 0, 0, 1, 1)

  -- love.graphics.setColor(_r, _g, _b, _a)
end

-- we want multiline on this eventually: https://github.com/riidom/mlvtest/blob/master/multilineview.lua
-- Draggable tutorial: http://nova-fusion.com/2011/09/06/mouse-dragging-in-love2d/
-- https://gist.github.com/a-racoon/1ca3b9f467ed491d404035400dfd8953
-- rect = {
--   x = 700,
--   y = 500,
--   width = 232,
--   height = 232,
--   dragging = { active = false, diffX = 0, diffY = 0 }
-- }

-- local easetype = 'outQuad'

function Signin:update(dt)
	if text and text.update then
		text:update(dt)
		data = text:enteredText()
	end

  -- Menu:mousepressed()

  -- Particle:update(dt)
  -- Blood:update(dt)

  -- SplashText:update(dt)

  -- if rect.dragging.active then
  --   rect.x = love.mouse.getX() - rect.dragging.diffX
  --   rect.y = love.mouse.getY() - rect.dragging.diffY
  -- end

  -- textbox
  text:update(dt)
  data = text:enteredText()
end

-- local function drawNote()
--   -- draggable rect
--   love.graphics.setColor(205, 205, 195, 255)
--   love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
--   love.graphics.setColor(205, 5, 5, 255)
--   love.graphics.printf(SplashText:getText(),rect.x+20,rect.y+20,220)
--   love.graphics.setColor(255, 255, 255, 255)
-- end

function Signin:draw()
  -- MenuHelper:drawMenu()

  -- love.graphics.setColor(255, 255, 255, 255)
  -- MenuHelper:drawButtons()

  -- SplashText:draw()

  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(r, g, b, a)
  love.graphics.setColor(0, 255, 255, 255)
  if Gravatar and Gravatar.draw then
    Gravatar:draw()
  end
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  if Particle and Particle.draw then
    Particle:draw()
  end
  if Blood and Blood.draw then
    Blood:draw(mx, my)
  end


  -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
  love.mouse.isVisible(true)
  -- draw a pointer
  if brian then
    love.graphics.draw(brian, mx, my)
  end
  -- love.graphics.draw(mouse, mx, my)
-- PrintDebug(fanfic)

-- sign in text box
  if text and text.draw then
    text:draw()
  end
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end

  -- drawNote()
  -- drawCanvas(self.canvas)

	-- text:draw()
	-- if data then
	-- 	love.graphics.setColor(255,255,255)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
	-- end
end

function Signin:exitedState()
  love.graphics.clear()
end

local SigninSuccess = Game:addState('signin-success')
function Signin:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER signin-success STATE - %s \n", os.date()))
  end

  print(data)
  if data and score and score.setEmail then

    score:setEmail(data)
  end

    if score then
      print(score['email'])
    end
end
function SigninSuccess:exitedState()
  love.graphics.clear()
end

function SigninSuccess:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(r, g, b, a)
  love.graphics.setColor(0, 255, 255, 255)
  if Gravatar and Gravatar.draw then
    Gravatar:draw()
  end
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
  love.mouse.isVisible(true)
  if brian then
    love.graphics.draw(brian, mx, my)
  end
  -- love.graphics.draw(mouse, mx, my)

-- sign in text box
	-- text:draw()
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)


    -- DO SOMTHING todo ToDO WITH THE DATA
	end
end
function SigninSuccess:keypressed(key, code)
  if text and text.keypressed then
    text:keypressed(key, code)
  end
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('return') then
    print(data)
    self:gotoState('menu')
  end
  if key == ('escape') then self:gotoState('menu') end
end