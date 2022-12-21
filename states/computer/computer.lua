print('computer.lua -> ')

--
-- Displays a dialogue box with a message for the player
-- -- the goal is to eventually display a character avatar
-- -- and to have all manner of expressiveness of the text,
-- -- multi-stage messages, selectable replies, animations
-- -- make the text type itself out instead of appearing all at once
-- -- https://twitter.com/flamendless this guy created this lib https://github.com/flamendless?page=2&tab=repositories
-- -- https://github.com/besnoi/lovelib/tree/master/Anima which (was it him?)
-- -- seems to handle that
--

print('Computer -> ')

-- local fanfic = require 'states/menu/fanfic'
-- local text = fanfic.new(200,300, "New textbox", false, 16)

local Computer = Game:addState('computer')
function Computer:mousepressed(x,y, button , istouch) end
function Computer:mousereleased(x, y, button) end
function Computer:keypressed(key, code)
  --   text:keypressed(key, code)
  if key == ('l') then self:popState('dialogue') end
  if key == ('escape') then love.event.push('quit') end
end
function Computer:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER computer STATE - %s \n", os.date()))
  end

  
  -- love.graphics.setBackgroundColor( red, green, blue, alpha )
  -- love.graphics.setBackgroundColor(unpack(COLOR_GREEN_HUNTER))
  -- love.graphics.setBackgroundColor( 0, 1, 0, 1)
  -- love.graphics.setBackgroundColor( 1, 1, 1, 1)


  -- the character avatar
  -- https://pixel-me.tokyo/en/ - face to pixel art
  -- self.raintar = http.request('http://www.gravatar.com/avatar/'..hashedEmail)
  self.raintar = nil

  -- attempt_canvas = false
  attempt_canvas = true
  if attempt_canvas then
    -- attempt to set the canvas 
    -- self.canvas = love.graphics.newCanvas()
    print(string.format("canvas creating - ", os.date()))
    -- self.canvas = love.graphics.newCanvas(320, 320)
    self.canvas = love.graphics.newCanvas(
      love.graphics.getWidth(),
      love.graphics.getHeight()
    )
    print(string.format("canvas created - ", os.date()))


    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(self.canvas)
      love.graphics.clear()
      love.graphics.setBlendMode("alpha")

      -- DRAW THE COMPUTER

      -- screenspace - steel blue transparent squares from origin
      love.graphics.setColor(47,79,79,128)
      love.graphics.rectangle('fill', 0, 0, 100, 100)
      love.graphics.rectangle('fill', 100, 100, 100, 100)
      love.graphics.rectangle('fill', 200, 200, 100, 100)
      love.graphics.rectangle('fill', 0, 0, 200, 200)
      love.graphics.rectangle('fill', 0, 0, 300, 300)


      -- red test squares
      -- love.graphics.setColor(255, 0, 0, 128)
      -- love.graphics.rectangle('fill', 0, 0, 100, 100)
      -- love.graphics.rectangle('fill', 100, 100, 100, 100)
      -- love.graphics.rectangle('fill', 200, 200, 100, 100)
      -- love.graphics.rectangle('fill', 0, 0, 200, 200)
      -- love.graphics.rectangle('fill', 0, 0, 300, 300)

      love.graphics.setColor(255, 255, 255, 255)
      -- use the canvas renderer to construct a player avatar from the player model
      -- love.graphics.draw(brian, 0, 0, 0, 1, 1)
    love.graphics.setCanvas()
  end
end
function Computer:update(dt)
  --   text:update(dt)
  --   data = text:enteredText()

  -- The computer canvas update
  -- 
  if attempt_canvas then
    self.canvas:renderTo(
      function()
        local _r, _g, _b, _a = love.graphics.getColor()
        love.graphics.clear()
        -- love.graphics.setColor(love.math.random(), 0, 0);

        -- pink test squares
        love.graphics.setColor(255, 155, 200, 255);
        -- love.graphics.rectangle('fill', 300, 300, 511, 511)
        -- love.graphics.rectangle('fill', 0, 0, 111, 111)

        -- random test lines from origin 
        -- love.graphics.setColor(love.math.random(), 0, 0);
        love.graphics.setColor(
          love.math.random(0, 255),
          love.math.random(0, 255),
          love.math.random(0, 255)
        );
        love.graphics.line(0, 0,
          love.math.random(0, love.graphics.getWidth()),
          love.math.random(0, love.graphics.getHeight())
        );
        love.graphics.setColor(_r, _g, _b, _a);
      end
    );
  end

end

-- love.graphics.setDefaultFilter("nearest", "nearest")

-- tempcomp = love.graphics.newImage("assets/character/avatars/NN32.png")
tempcomp = love.graphics.newImage("assets/machines/computer/computer.png")
tempcomp:setFilter("nearest", "nearest")

-- love.graphics.draw(tempcomp,
--   self.panex+32, self.paney+32,
--   nil,
--   0.5
-- )
function Computer:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  local _lineWidth = love.graphics.getLineWidth()

  -- Draw DESK
  -- local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255,0,0, 255)
  -- love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
  love.graphics.rectangle(
    'fill',
    0, screen_height - 300, -- x, y
    screen_width, 1511 -- w, h
  )
  love.graphics.rectangle('fill', 0, 0, 111, 111)
  love.graphics.setColor(_r, _g, _b, _a)
  -- END DESK

  -- computer placeholder
  -- TODO - make this blur? diffo resolutions, switcher "animations"
  -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
  love.graphics.draw(
    tempcomp,
    32, 32,
    0,
    25,
    25
  )

  -- User-input conversations
	-- text:draw()
	-- if data then
	-- 	love.graphics.setColor(255,255,255)
	-- 	love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- -- DO SOMTHING todo ToDO WITH THE DATA
	-- end

  self.width = love.graphics.getWidth()
  self.height= love.graphics.getHeight()
  self.panex = camera.pos.x + (self.width/11)
  self.paney = camera.pos.y + (self.height - self.height/3) - 64
  -- self.panexx = (self.width/4)*3
  -- self.paneyy = (self.height/4)*3
  self.panew = self.width - (self.width/6)
  self.paneh = self.height/3

  local panex = self.panex
  local paney = self.paney
  panex = panex * camera.scale.x
  paney = paney * camera.scale.y

  local panew = self.panew
  local paneh = self.paneh
  panew = panew * camera.scale.x
  paneh = paneh * camera.scale.y

  -- love.graphics.rectangle('fill', 300, 300, 511, 511)
  -- love.graphics.rectangle('fill', 0, 0, 111, 111)
  -- love.graphics.setColor(_r, _g, _b, _a)

  love.graphics.setColor(55, 55, 155, 255)
  -- local txt = [[rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away rainting the day away]]
  -- local txt = [[AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA]]
  local txt = [[AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA]]

  -- love.graphics.setColor(1, 1, 1);
  love.graphics.setColor(55, 55, 155, 255)
  -- love.graphics.draw(self.canvas);
  if attempt_canvas then
    drawCanvas(self.canvas)
  end

  local Dpanel = false
  if Dpanel == true then
    -- Backpanel bg
    love.graphics.rectangle('fill', panex-25, paney-25, panew+50, paneh+50, 32, 32)
    love.graphics.setColor(55, 55, 155, 255)

    love.graphics.setColor(255, 255, 255, 255)
    -- Backpanel outline
    love.graphics.rectangle('line', panex-25, paney-25, panew+50, paneh+50, 32, 32)

    -- TEXT COLOR
    love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.setColor(55, 55, 155, 255)

    -- DIALOGUE TEXT
    love.graphics.printf(
      txt,
      panex+32 + 200,
      paney,--+32,
      panew-32 - 200,
      'left'
    )

    -- text box outline
    love.graphics.rectangle('line',
      panex + 200,
      paney,
      panew - 200,
      paneh,
      0, 0
    )
  end


  -- local action = 'read_more'
  -- local action = 'computer_boot'
  local showAvatar = true

  -- local vertices = {100,100, 200,100, 150,200}
  local vx = {
    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),
  }
  vx = {
    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),

    camera.pos.x + (self.width - 32),
    camera.pos.y + (self.height - 64),
  }
  

  -- coorinates of the dialogue action indicator
  -- This table could be built incrementally too.
  -- local vertices = {300,300, 300,500, 150,300, 150,200, 700,100}
  local vertices = {0,0, 0,100, 200,200, 250,300, 110,200, 100,100}
  -- The action indicator
  if action == 'read_more' then
    -- Giving the coordinates directly.
    -- love.graphics.polygon("fill", 100,100, 200,100, 150,200)

    -- local vertices = {100,100, 200,100, 150,200}
    vertices = {0,0, 0,100, 200,200, 250,300, 110,200, 100,100}

    -- Passing the table to the function as a second argument.
    love.graphics.setColor(55, 255, 55, 255)
    love.graphics.setLineWidth(3)
    love.graphics.polygon("line", vertices)
  else
    love.graphics.polygon("fill", 100,100, 200,100, 150,200)
    -- local vertices = {100,100, 200,100, 150,200}

    -- love.graphics.setColor(55, 55, 55, 255)
    -- love.graphics.setLineWidth(3)
    -- love.graphics.polygon("line", vertices)
  end


  -- the character avatar
  -- if self.raintar ~= nil then
  --   self.raintar = love.filesystem.newFileData(self.raintar, "raintar.png")
  --   self.raintar = love.graphics.newImage(self.raintar)
  -- else -- Default avatar == no internet or gravatar down
  -- local raintar = love.graphics.newImage("assets/newer/brian.png")
  -- the list of debug faces
  -- local raintar = love.graphics.newImage("assets/character/avatars/EM.png")
  -- local raintar = love.graphics.newImage("assets/character/avatars/NN128.png")

  -- if showAvatar == true then
    local raintar = love.graphics.newImage("assets/character/avatars/NN32.png")
    love.graphics.draw(raintar,
      self.panex+32, self.paney+32,
      nil,
      0.5
    )
  -- end
  -- love.graphics.rectangle("fill",
  --   self.panex+32,self.paney+32,
  --   96,96)
  -- love.graphics.print(score['email'], 50, 85) -- default w,h 80x80
  -- end
  -- local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255), 255)
  -- love.graphics.draw(raintar, x + 500, y)
  -- love.graphics.print(score['email'], x + 500, y+85) -- default w,h 80x80
  -- love.graphics.setColor(_r, _g, _b, _a)


  -- love.graphics.printf(txt, panex-25, t+topOffset, cellSize, 'center')
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
end

function drawCanvas(c)
  -- very important!: reset color before drawing to canvas to have colors properly displayed
  -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setBlendMode("alpha")

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

-- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
--   Drawable drawable
-- A drawable object.
-- number x (0)
-- The position to draw the object (x-axis).
-- number y (0)
-- The position to draw the object (y-axis).
-- number r (0)
-- Orientation (radians).
-- number sx (1)
-- Scale factor (x-axis).
-- number sy (1)
-- Scale factor (y-axis).
-- number ox (0)
-- Origin offset (x-axis).
-- number oy (0)
-- Origin offset (y-axis).
-- number kx (0)
-- Shearing factor (x-axis).
-- number ky (0)
-- Shearing factor (y-axis).

  love.graphics.draw(c, 0, 0, 0, 1, 1, 0, 0)

  love.graphics.setColor(_r, _g, _b, _a)
end

function Computer:exitedState()
  love.graphics.clear()
end

function setUpDialogue()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local dialogue_width = ww * (1/2)
  local dialogue_height = 100
end

-- what is this doing?
local function drawDialogue()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local dialogue_width = ww * (1/2)
  local dialogue_height = 100
  local _r, _g, _b, _a = love.graphics.getColor()

  love.graphics.setColor(255, 5, 5, 255)

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
