
--[[
  dialogue.lua

  Displays a dialogue box with a message for the player
  seems to handle that
]]

-- @TODO
-- - make this driven by a dialog script file (as in a movie script or screenplay)
-- - allow 2 characters to dialogue, one on the right, and one on the left
-- - extract all the drawing functions into a drawing helper file
-- -- have all manner of expressiveness of the text,
-- -- multi-stage messages, selectable replies, animations
-- -- make the text type itself out instead of appearing all at once
-- -- https://twitter.com/flamendless this guy created this lib https://github.com/flamendless?page=2&tab=repositories
-- -- https://github.com/besnoi/lovelib/tree/master/Anima which (was it him?)
--

-- local fanfic = require 'states/menu/fanfic'
-- local text = fanfic.new(200,300, "New textbox", false, 16)

if DEBUG_LOGGING_LOADING then
  print('dialogue.lua -> ')
end
-- dependencies

local Dialogue = Game:addState('dialogue') -- register the gamestate

function Dialogue:keypressed(key, code)
--   text:keypressed(key, code) -- user input
  if key == ('l' or 'e') then self:popState('dialogue') end -- if key == ('l') then self:popState('dialogue') end
  if key == ('return') then -- advance dialogue
    Dialogue.number = Dialogue.number + 1
    print(Dialogue.script[Dialogue.number] or 'RAINT' .. ' number #' .. Dialogue.number or 'RAINT') -- log the dialog
  end
  if key == ('escape') then
    self:popState('dialogue')
    self:pushState('menu')
  end
  if key == ('q') then love.event.push('quit') end
end
function Dialogue:mousepressed(x,y, button , istouch) end
function Dialogue:mousereleased(x, y, button) end

function Dialogue:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER dialogue STATE - %s \n", os.date()))
  end

  -- hero image and avatar of character 1 (left side)
  self.heroImages = {
    hello = love.graphics.newImage("assets/character/avatars/elon/hello.PNG"),
    surprised = love.graphics.newImage("assets/character/avatars/elon/surprised.PNG"),
  }
  self.avatars = {
    hello = love.graphics.newImage("assets/character/avatars/EM.png"),
    surprised = love.graphics.newImage("assets/character/avatars/EM32.png")
  }

  Dialogue.number = 0
  Dialogue.limit = 5
  -- get some splash_texts_library.lua
  Dialogue.script = {
    'raint',
    'raint number two',
    "raint 3",
    "this is the fourth raint",
    'fifth debug raitn',
    'why not a sixth',
    'The longest raint : RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIIIIIIIIIIIIIIIIIIIIIIIIIIIIIINNNNNNNNNNNNNNTTTT',
    'Never again shall I raint!',
    'What\'re you on about?!'
  }

  Dialogue.advScript = {
    ["elon"] = 'raint' -- two character back and forth
  } -- a script that includes back and forth and prompts for the user to input information such as a character of mob's name.

  -- the character avatar
  -- https://pixel-me.tokyo/en/ - face to pixel art
  -- self.raintar = http.request('http://www.gravatar.com/avatar/'..hashedEmail)
  self.raintar = nil
end
function Dialogue:update(dt)
--   text:update(dt)
--   data = text:enteredText()
end
function Dialogue:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  local _lineWidth = love.graphics.getLineWidth()

  -- User-input conversations
	-- text:draw()
	-- if data then
	-- 	love.graphics.setColor(1, 1, 1, 1)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- -- DO SOMTHING todo ToDO WITH THE DATA
	-- end

  self.width = love.graphics.getWidth()
  self.height= love.graphics.getHeight()
  self.panex = camera.pos.x + (self.width/11)
  self.paney = camera.pos.y + (self.height - self.height/3) - 64

  local hero; -- character expression hero image - big avatar
  if Dialogue.number % 2 == 0 then -- alternate between two expressions
    hero = self.heroImages['hello']
  else
    hero = self.heroImages['surprised']
  end

  love.graphics.setColor(1, 1, 1, 1)
  if hero then
    love.graphics.draw(hero,
      -- self.panex+32, self.paney+32,
      10, 20,
      nil,
      -- 0.75
      0.5
      -- 1
    )
  end

  -- self.panexx = (self.width/4)*3
  -- self.paneyy = (self.height/4)*3
  self.panew = self.width - (self.width/6)
  self.paneh = self.height/3
  local panex = self.panex
  local paney = self.paney

  -- Get camera scale safely
  local cam_scale_x = 1
  local cam_scale_y = 1
  if camera and camera.scale then
    cam_scale_x = camera.scale.x
    cam_scale_y = camera.scale.y
  end
  
  panex = panex * cam_scale_x
  paney = paney * cam_scale_y
  local panew = self.panew
  local paneh = self.paneh

  panew = panew * cam_scale_x
  paneh = paneh * cam_scale_y


  -- random white boxes in the corners
  -- love.graphics.rectangle('fill', 300, 300, 511, 511)
  -- love.graphics.rectangle('fill', 0, 0, 111, 111)

  love.graphics.setColor(55/255, 55/255, 155/255, 1)
  love.graphics.rectangle('fill', panex-25, paney-25, panew+50, paneh+50, 32, 32)

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('line', panex-25, paney-25, panew+50, paneh+50, 32, 32)
  love.graphics.printf(
    Dialogue.script[Dialogue.number or 1] or Dialogue.script[1] .. ' #'..Dialogue.number,
    panex+32 + 200,
    paney,--+32,
    panew-32 - 200,
    'left'
  )
  love.graphics.rectangle('line',
  panex + 200,
  paney,
  panew - 200,
  paneh,
  0, 0)


  local action = 'readMore' -- for prompting the user to advance the dialogue once the typing out animation is done or skipped

  -- local vertices = {100,100, 200,100, 150,200}
  -- Get camera position safely
  local cam_x = 0
  local cam_y = 0
  if camera and camera.pos then
    cam_x = camera.pos.x
    cam_y = camera.pos.y
  end
  
  local vx = {
    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),
  }
  vx = {
    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),

    cam_x + (self.width - 32),
    cam_y + (self.height - 64),
  }
  
  -- local vertices = {300,300, 300,500, 150,300, 150,200, 700,100}

  -- The action indicator
  if action == 'readMore' then
    -- Giving the coordinates directly.
    -- love.graphics.polygon("fill", 100,100, 200,100, 150,200)

    -- coorinates of the dialogue action indicator
    -- This table could be built incrementally too.
    local vertices = {100,100, 200,100, 150,200}
    -- local vertices = {0,0, 0,100, 200,200, 250,300, 110,200, 100,100}

    -- Passing the table to the function as a second argument.
    love.graphics.setColor(55/255, 1, 55/255, 1)
    love.graphics.setLineWidth(3)
    love.graphics.polygon("line", vertices)
  else
    -- love.graphics.polygon("fill", 100,100, 200,100, 150,200)
    -- local vertices = {100,100, 200,100, 150,200}
    love.graphics.setColor(55/255, 55/255, 55/255, 1)
    love.graphics.setLineWidth(3)
    -- love.graphics.polygon("line", vertices)
  end


  -- the character avatar
  -- if self.raintar ~= nil then
  --   self.raintar = love.filesystem.newFileData(self.raintar, "raintar.png")
  --   self.raintar = love.graphics.newImage(self.raintar)
  -- else -- Default avatar == no internet or gravatar down
  -- local raintar = love.graphics.newImage("assets/newer/brian.png")
  --

  -- this draws on top of the chrome above
  local raintar -- small avatar
  if Dialogue.number % 2 == 0 then
    raintar = self.avatars['hello']
  else
    raintar = self.avatars['surprised']
  end
  love.graphics.draw(raintar,
    self.panex+32, self.paney+32,
    nil,
    0.5
  )

  -- love.graphics.rectangle("fill",
  --   self.panex+32,self.paney+32,
  --   96,96)
  -- love.graphics.print(score['email'], 50, 85) -- default w,h 80x80
  -- end
  -- love.graphics.setColor(love.math.random(), love.math.random(), love.math.random(), 1)
  -- love.graphics.draw(raintar, x + 500, y)
  -- love.graphics.print(score['email'], x + 500, y+85) -- default w,h 80x80
  -- love.graphics.setColor(_r, _g, _b, _a)

  -- love.graphics.pop()

  love.graphics.setLineWidth(_lineWidth)
  love.graphics.setColor(_r, _g, _b, _a)

  -- @TODO - make this into a debug drawfunction
  if DEBUG_GRID_ON then
    -- save state
    local _r, _g, _b, _a = love.graphics.getColor()
    local _lineWidth = love.graphics.getLineWidth()
    -- debug colors and line width
    -- love.graphics.setLineWidth(_lineWidth)
    -- love.graphics.setColor(_r, _g, _b, _a-200)

      -- @todo - DOCUMENT AND SAVE THESE WEIRD LINES IN draw_helpers.lua
    -- horizontal lines
    -- for y = 0, 16 do
      -- love.graphics.line(
      --   camera.pos.x,--0,--y,
      --   y*32,
      --   camera.pos.x + self.width
      --   y*32,
      -- )

        -- horizontal lines
        -- love.graphics.line(camera.pos.x + (y*32), camera.pos.y, camera.pos.y + (y*32), camera.pos.y + self.height)
        -- love.graphics.line(camera.pos.x, cammera.pos.y, camera.pos.x+self.width, camera.pos.y+32*y)

      -- love.graphics.line(
      --   camera.pos.x,--0,--y,
      --   y*32,
      --   camera.pos.x + self.width
      --   y*32,
      -- )
      -- love.graphics.line(
      --   x*32,
      --   camera.pos.y,--0,--y,
      --   x*32,
      --   camera.pos.y + self.height
      -- )
      -- love.graphics.line(
      --   camera.pos.x,--0,--y,
      --   x*32,
      --   camera.pos.x + self.width,
      --   x*32,
      -- )

      -- for j = -16, 16 do
        -- love.graphics.line(i, j, i+256, j+256)
        -- love.graphics.line(i, j, i*10, j*10)
        -- love.graphics.line(i, j*32, i+self.width, j*32)
      -- end
    -- end

    -- love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
    -- love.graphics.line(i*32*16, j-500, i*32*16, j+1000)

    for x = 0, 40 do
    -- vertical lines
      love.graphics.line(
        x*32,
        camera.pos.y,--0,--y,
        x*32,
        camera.pos.y + self.height
      )
      -- horizontal lines
      love.graphics.line(
        camera.pos.x,
        x*32,
        camera.pos.x+self.width,
        x*32
      )
      -- @todo - DOCUMENT AND SAVE THESE WEIRD LINES IN draw_helpers.lua
      -- love.graphics.line(camera.pos.x + (y*32), camera.pos.y, camera.pos.y + (y*32), camera.pos.y + self.height)
      -- love.graphics.line(
      --   x*32 +8,
      --   camera.pos.y,--0,--y,
      --   x*32 +8,
      --   camera.pos.y + self.height
      -- )
      -- love.graphics.line(
      --   camera.pos.x,--0,--y,
      --   x*32,
      --   camera.pos.x + self.width,
      --   x*32,
      -- )
      -- love.graphics.line(
      --   camera.pos.x,
      --   camera.pos.y,
      --   camera.pos.x+self.width,
      --   camera.pos.y+32*y
      -- )

      -- @todo - DOCUMENT AND SAVE THESE WEIRD LINES IN draw_helpers.lua
      -- for j = 0, 32 do
        -- love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
        -- love.graphics.line(i*32*16, j-500, i*32*16, j+1000)
        -- love.graphics.line(i*32, j, i*32, j+self.height)
        -- love.graphics.line(i, j*32, i+1000, j*32)
        -- love.graphics.line(i, j, i*10, j*10)
        -- love.graphics.line(i*16*32, j, i+256, j)
        -- love.graphics.line(i, j*16*32, i, j+256)
      -- end
    end
    -- reset state
    love.graphics.setLineWidth(_lineWidth)
    love.graphics.setColor(_r, _g, _b, _a)
  end
  love.graphics.setColor(_r, _g, _b, _a)
end
function Dialogue:exitedState()
  love.graphics.clear()
end

function setUpDialogue()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local dialogue_width = ww * (1/2)
  local dialogue_height = 100


end

-- what is this doing?
function drawDialogue()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local dialogue_width = ww * (1/2)
  local dialogue_height = 100
  local _r, _g, _b, _a = love.graphics.getColor()

  love.graphics.setColor(1, 5/255, 5/255, 1)

  local bx, by = {100, 200}
  love.graphics.rectangle(
    'fill',
    bx,
    by,
    dialogue_width,
    dialogue_height
  )

  love.graphics.setColor(_r, _g, _b, _a)
end


-- TTS - text to speech attempts below
-- https://github.com/fiendish/MS_Speech_API_Lua - windows
-- https://love2d.org/forums/viewtopic.php?t=94536 - and below: linux / mac

-- local op=print
-- local channel=love.thread.newChannel()
-- local tcode=[[ 
-- channel = ...
-- handle=io.popen("espeak","w")
-- handle:setvbuf ("no")
-- repeat
--  handle:write(channel:demand().."\n")
-- until false
-- ]]

-- -- not this one
-- local tcode=[[ 
-- channel = ...
-- repeat
--  text=os.execute("espeak '"..channel:demand().."'")
-- until false
-- ]]

-- Lthread = love.thread.newThread( tcode )
-- Lthread:start(channel)

-- print=function(...)  channel:push(table.concat({...})," ") op(...) end
-- Tx=""
-- function love.textinput(t)
--  Tx=Tx..t
-- end
-- function love.keypressed(_,k)
--  if k=="return" then
--   print(Tx)
--   Tx=""
--  end
-- end
