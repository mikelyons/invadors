print('loadSave.lua -> ')

fanfic = require 'states/menu/fanfic'
print('loadSave -> ')

local NewGame = Game:addState('newGame')

function newButton(text, fn)
  return {
    text = text,
    fn = fn,

    now = false,
    last = false,
  }
end

function NewGame:loadButtons()
  self.buttons = {}

  local saveFiles = {}
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems('/states')

  PrintTable(filesTable)

  self.buttons = self:buildSavesButtonTable(self.buttons, filesTable) 

end

function NewGame:buildSavesButtonTable(buttonsTable, states) 
  local buttons = {}

  -- for i=6, 15 do --#states do
  for i=1, #states do
    table.insert(buttons, newButton(
      states[i] or 'empty',
      function()
        print(states[i]..'game mode '..i)
        self:pushState(states[i])
      end
    ))
  end
  return buttons
end

function NewGame:drawButtons()
  if not love.mouse.isDown(1) then
    can_fire = true
  end

  local buttons = self.buttons
  -- print('-------')
  -- PrintTable(self.buttons)
  -- print('-------')
  local _r, _g, _b, _a = love.graphics.getColor()

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_height = 32

  local button_width = ww * (1/3)
  local margin = 16
  local total_height = (button_height + margin) * #buttons
  local cursor_y = 0

  -- from tutorial:  https://www.youtube.com/watch?v=vMSjVuJ6wDs&t=303s
  for i, button in ipairs(buttons) do
    button.last = button.now

    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

    local mx, my = love.mouse.getPosition()
    local hovered = mx > bx and mx < bx + button_width and
                    my > by and my < by + button_height
    local color = {80, 80, 100, 255}
    local textColor = {0, 0, 0, 255}
    if hovered then
      color = {160, 160, 200, 255}
      textColor = {255, 255, 255, 255}
    end

    button.now = love.mouse.isDown(1)
    if (
      button.now -- isDown boolean
      and not button.last -- was down last tick
      and hovered
      and can_fire
    )
    then
      print(" ")
      print(" ")
      button.fn(self)
    end 

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle(
      'fill',
      bx,
      by,
      button_width,
      button_height
    )

    local textW = self.font:getWidth(button.text)
    local textH = self.font:getHeight(button.text)

    love.graphics.setColor(unpack(textColor))
    love.graphics.setFont(self.font)
    love.graphics.print(
      button.text,
      (ww * 0.4) - textW * 0.1, -- bx
      by + textW * 0.1 -- by
    )

    cursor_y = cursor_y + (button_height + margin)

    love.graphics.setColor(_r, _g, _b, _a)
  end
end

function NewGame:enteredState()
	can_fire = false --If true player can shoot

  -- love.graphics.clear(255,255,255,255)
  love.graphics.clear(1,1,1,1)
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER NewGame STATE - %s \n", os.date()))
  end

  -- why doesn't this work?
  -- self.text = fanfic.new(200,300, "New textbox", false, 16)

  self:loadButtons()

  -- Gravatar:load()
  -- love.graphics.clear( )

  -- really? vvv
  -- THIS CRUCIAL STEP needs to be added for all other renderables!! @TODO
  renderer:addRenderer(self, 5)
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

function NewGame:update(dt)
  if not can_fire then
		fire_tick = fire_tick + dt --Increases fire_tick by dt each frame which resaults in fire_tick increasing by 1 roughly every second
		if fire_tick > fire_wait then
			can_fire = true
			fire_tick = 0
		end
	end

	-- text:update(dt)
	-- data = text:enteredText()

  -- Menu:mousepressed()

  -- Particle:update(dt)
  Blood:update(dt)

  -- if rect.dragging.active then
  --   rect.x = love.mouse.getX() - rect.dragging.diffX
  --   rect.y = love.mouse.getY() - rect.dragging.diffY
  -- end

  -- textbox
  -- self.text:update(dt)
  -- data = self.text:enteredText()
end

-- local function drawNote()
--   -- draggable rect
--   love.graphics.setColor(205, 205, 195, 255)
--   love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
--   love.graphics.setColor(205, 5, 5, 255)
--   love.graphics.printf(SplashText:getText(),rect.x+20,rect.y+20,220)
--   love.graphics.setColor(255, 255, 255, 255)
-- end

function NewGame:draw(dt)
  self:drawButtons()

  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(r, g, b, a)
  love.graphics.setColor(0, 255, 255, 255)
  Gravatar:draw()
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  Particle:draw()
  Blood:draw(mx, my)


  -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
  love.mouse.isVisible(true)
  -- draw a pointer
  love.graphics.draw(brian, mx, my)
  -- love.graphics.draw(mouse, mx, my)

-- sign in text box
	-- self.text:draw()
	-- if data then
	-- 	love.graphics.setColor(255,255,255)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
  --   -- DO SOMTHING todo ToDO WITH THE DATA
	-- end

  -- drawNote()

	-- text:draw()
	-- if data then
	-- 	love.graphics.setColor(255,255,255)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
	-- end
end

function NewGame:exitedState()
  self.buttons = nil
  love.graphics.clear()
end
function NewGame:mousepressed(x,y, button , istouch) end
function NewGame:mousereleased(x, y, button) end
function NewGame:keypressed(key, code)
  -- how to set up text again?
  -- self.text:keypressed(key, code)
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('newGame') end
  
  -- this pushes to the state that was loaded in signin file!!!
  -- if key == ('return') then self:pushState('signin-success') end
end
function NewGame:pushedState()
  print('')
  print('newgame pushed')
  PrintTable(self:getStateStackDebugInfo())
end
function NewGame:poppedState()
  print('\n')
  print('newgame popped')
  PrintTable(self:getStateStackDebugInfo())
end

-- local SigninSuccess = Game:addState('signin-success')
-- function Signin:enteredState()
--   if DEBUG_LOGGING_ON then
--     print(string.format("ENTER signin-success STATE - %s \n", os.date()))
--   end

--   print(data)
--   if data then

--     score:setEmail(data)
--   end

--     print(score['email'])
-- end
-- function SigninSuccess:exitedState()
--   love.graphics.clear()
-- end

-- function SigninSuccess:draw()
--   local _r, _g, _b, _a = love.graphics.getColor()
--   -- love.graphics.setColor(r, g, b, a)
--   love.graphics.setColor(0, 255, 255, 255)
--   Gravatar:draw()
--   -- love.graphics.reset()
--   -- love.graphics.pop()
--   love.graphics.setColor(_r, _g, _b, _a)

--   local mx = love.mouse.getX()
--   local my = love.mouse.getY()
--   -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
--   love.mouse.isVisible(true)
--   love.graphics.draw(brian, mx, my)
--   -- love.graphics.draw(mouse, mx, my)

-- -- sign in text box
-- 	-- text:draw()
-- 	if data then
-- 		love.graphics.setColor(255,255,255)
-- 		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)


--     -- DO SOMTHING todo ToDO WITH THE DATA
-- 	end
-- end
-- function SigninSuccess:keypressed(key, code)
--   text:keypressed(key, code)
--   -- if key == ('escape') then love.event.push('quit') end
--   -- if key == ('escape') then love.event.push('quit') end
--   if key == ('return') then
--     print(data)
--     self:gotoState('menu')
--   end
--   if key == ('escape') then self:gotoState('menu') end
-- end-- 