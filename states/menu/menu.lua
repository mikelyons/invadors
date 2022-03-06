asm:load()
tween = require '/lib/tween/tween'

require 'states/menu/splash_texts_library'
splashtext = require('states/menu/splash_texts')
SplashText = splashtext:new()

gravatar = require('states/menu/gravatar')
-- was this just a note or experiment?
Gravatar = gravatar:new(score['email'], 100, 100)
-- Gravatar = gravatar:new('', 100, 100)

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

Menu = Game:addState('menu')

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
    ['buttonText'] = 'Options',
    ['buttonFn'] = function() return Menu.openMenu('options') end
  },
  {
    ['buttonText'] = 'Quit',
    ['buttonFn'] = ''
  }
}

Menu.testingMenu = {}
local tm = Menu.testingMenu
  -- tm['trn']  = 'training'
  -- tm['biz']  = 'bizzaro'
  -- tm['sp1']  = 'space1'
  -- tm['e2']   = 'earth2'
  -- tm['cmd']  = 'commando'
  -- tm['gen']  = 'generate'
  -- tm['q']    = 'quit'
  tm = {'return','bizzaro', 'space1', 'earth2', 'commando','generate','quit'}
  -- if key == ('1' or 'return') then self:pushState('Training') end
  -- if key == ('2' or 'space') then self:pushState('Bizzaro') end
  -- if key == ('3' or 'q') then self:pushState('space1') end
  -- if key == ('4' or 'w') then self:pushState('Earth2') end
  -- if key == ('5') then self:pushState('commando') end
  -- -- if key == ('6') then self:pushState('generate') end
  -- if key == ('6') then self:gotoState('generate') end
  
  -- if key == ('q') then love.event.push('quit') end


-- what is this? find the length of the table?
-- table length util function
function Tlength(tbl)
  local getN = 0
  for n in pairs(tbl) do 
    getN = getN + 1 
  end
  return getN
end

local getN = 0
for n in pairs(tm) do 
  getN = getN + 1 
end
  -- find a value in a list
  -- print(tm['q'])
  -- print(Tlength(tm))

  -- for i=0,tm do
  --   print('found ' .. tm[i])
  -- end

  -- for i = 1,Tlength(tm),1 
  -- do 
  --   print(tm[i]) 
  --   if tm[i] == "quit" then 
  -- end




function Menu:keypressed(key, code)
  -- if key == ('1' or 'return') then self:startGame() end
  if key == ('1' or 'return') then self:pushState('generate') end
  -- if key == ('1' or 'return') then self:pushState('signin') end
  -- if key == ('1' or 'return') then self:pushState('generate') end
  -- if key == ('2' or 'space') then self:pushState('bizzaro') end
  -- if key == ('3' or 's') then self:pushState('synth') end
  -- if key == ('4' or 'm') then self:pushState('mts') end
  -- if key == ('5' or 'g') then self:pushState('prog2') end
  -- if key == ('6' or 'h') then self:pushState('pro') end
  -- if key == ('3' or 'q') then self:pushState('space1') end
  -- if key == ('4' or 'w') then self:pushState('Earth2') end
  -- if key == ('5') then self:pushState('commando') end
  -- if key == ('6') then self:pushState('generate') end
  -- if key == ('6') then self:gotoState('generate') end
  
  if key == ('escape') then self:popState('menu') end
  -- if key == ('q') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
end

function Menu:mousepressed(x,y, button , istouch)
  if love.mouse.isDown(1) then
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

function stackDebug(self)
end

function Menu:pushedState()
  print('')
  print('menu pushed')

  self:loadButtons({})
  -- PrintTable(self.buttons)

  PrintTable(self:getStateStackDebugInfo())
end
function Menu:poppedState()
  print('')
  print('menu popped')
  print(self.buttons)
  -- PrintTable(self.buttons)
  PrintTable(self:getStateStackDebugInfo())
end
function Menu:pausedState()
  print('menu paused')
end
function Menu:continuedState()
  self:loadButtons({})
  print('menu continued')
end

function Menu:enteredState()
  filesString = recursiveEnumerate("/saves", "")

  if DEBUG_LOGGING_ON then
    print(string.format("ENTER Menu STATE - %s \n", os.date()))
  end

  self.font = love.graphics.newImageFont("assets/newer/Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")

  self.font = love.graphics.newFont(32)

  self:loadButtons(Menu)
  Gravatar:load()

  love.graphics.clear()
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
    -- love.graphics.rectangle('fill', 100, 100, 100, 100)
    -- love.graphics.rectangle('fill', 200, 200, 100, 100)
    -- love.graphics.rectangle('fill', 0, 0, 200, 200)
    -- love.graphics.rectangle('fill', 0, 0, 300, 300)

    love.graphics.setColor(255, 255, 255, 255)
    -- use the canvas renderer to construct a player avatar from the player model
    love.graphics.draw(brian, 0, 0, 0, 1, 1)
  love.graphics.setCanvas()

end

local function drawCanvas(canvas)
  -- very important!: reset color before drawing to canvas to have colors properly displayed
  -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255, 255)
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

  love.graphics.draw(canvas, 0, 0, 0, 1, 1)

  -- love.graphics.setColor(_r, _g, _b, _a)
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

-- love.graphics.setColor(r, g, b, a)
function Menu:draw()

  love.graphics.print(filesString, 0, 0)

  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255, 255)

  -- Logo
  -- https://fontmeme.com/doom-font/
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(hamster, 50, 50, 0, 2.2, 2.2)
  love.graphics.setColor(_r, _g, _b, _a)

  -- MenuHelper:drawMenu()
  -- self:drawMenu()

  -- love.graphics.setColor(255, 255, 255, 255)
  -- MenuHelper:drawButtons()

  SplashText:draw()

  love.graphics.setColor(_r, _g, _b, _a)
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)
  Gravatar:draw()

  love.graphics.setColor(_r, _g, _b, _a)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  Particle:draw()
  Blood:draw(mx, my)

  -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
  love.mouse.isVisible(false)
  -- draw a pointer
  love.graphics.draw(brian, mx, my)
  -- love.graphics.draw(mouse, mx, my)
  -- PrintDebug(fanfic)

  self:drawButtons()

  drawNote()
  -- drawCanvas(self.canvas)
end

function Menu:exitedState()
  love.graphics.clear()
end

function Menu:drawButtons()
  if not love.mouse.isDown(1) then
    can_fire = true
  end
  local buttons = self.buttons
  local _r, _g, _b, _a = love.graphics.getColor()

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_height = 64
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
    if button.now and not button.last and hovered then
      button.fn(self)
    end
    if love.mouse.isDown(1) then
      can_fire = false
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

-- This function will return a string filetree of all files
-- in the folder and files in all subfolders
function recursiveEnumerate(folder, fileTree)
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		if lfs.isFile(file) then
			fileTree = fileTree.."\n"..file
		elseif lfs.isDirectory(file) then
			fileTree = fileTree.."\n"..file.." (DIR)"
			fileTree = recursiveEnumerate(file, fileTree)
		end
	end
	return fileTree
end

function Menu:loadButtons(menu)
  self.font = love.graphics.newFont(32)
  self.buttons = {}
  local buttons = self.buttons
  local menu = menu

  local saveFiles = {}
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems('/saves')

  success = love.filesystem.createDirectory( 'saves' )

  if not love.filesystem.exists('saves/scores.lua') then
    scores = love.filesystem.newFile('saves/scores.lua')
    love.filesystem.write('saves/scores.lua', "raint")
  end


  -- print(filesTable)
  -- PrintTable(filesTable)


  table.insert(buttons, self:newButton(
    'New Game',
    function(self)
      print('starting game')
      -- Game:gotoState('signin')
      self:pushState('newGame')
      -- self:pushState('generate')
    end
  ))
  table.insert(buttons, self:newButton(
    'Load Save',
    function(self)
      print('Load a save game')
      self:pushState('loadSave')
      -- self:pushState('signin')
      print('sign in')
    end,
    menu
  ))
  table.insert(buttons, self:newButton(
    'Options',
    function()
      self:popState('menu')
      print('Go to Options menu')
    end
  ))
  table.insert(buttons, self:newButton(
    'Quit',
    function()
      print('Goodbye')
      score:quit()
      love.event.quit(0)
    end
  ))
  return self.buttons
end

-- make a mode that just goes into a chatbot system
-- https://github.com/tavuntu/dialove
-- https://love2d.org/forums/viewtopic.php?t=82675&start=20
-- or get irc for support in game
-- oother games to check out
-- https://windmillgames.itch.io/

function Menu:newButton(text, fn, menu)

  return {
    text = text,
    fn = fn,
    menu = menu,

    now = false,
    last = false,
  }
end

function Menu.numericKeyboarMenu(key, code)
  -- how do we return this in keypressed
  if key == ('1' or 'return') then self:pushState('generate') end
  -- if key == ('1' or 'return') then self:pushState('signin') end
  -- if key == ('1' or 'return') then self:pushState('generate') end
  -- if key == ('2' or 'space') then self:pushState('bizzaro') end
  -- if key == ('3' or 's') then self:pushState('synth') end
  -- if key == ('4' or 'm') then self:pushState('mts') end
  -- if key == ('5' or 'g') then self:pushState('prog2') end
  -- if key == ('6' or 'h') then self:pushState('pro') end

  -- if key == ('3' or 'q') then self:pushState('space1') end
  -- if key == ('4' or 'w') then self:pushState('Earth2') end
  -- if key == ('5') then self:pushState('commando') end
  -- if key == ('6') then self:pushState('generate') end
  -- if key == ('6') then self:gotoState('generate') end
  
  if key == ('q') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end

  -- and this in draw
  love.graphics.printf(
    [[if key == (1 or return) then self:gotoState(Training) end
    if key == (2 or space) then self:gotoState(bizzaro) end
    if key == (3 or q) then self:gotoState(SPACE) end
    if key == ('4' or 'w') then self:gotoState('Earth2') end
    if key == ('5' or '') then self:gotoState('commando') end
    if key == ('6' or '') then self:gotoState('generate') end

    END OF TRANSMISSION]]
    , 50, 320, 620, 'left')
end-- 
