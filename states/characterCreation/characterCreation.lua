--[[
  characterCreation.lua

  - Name the character something goherent
  - all characters are saved to the save directory
  - all characters can be recalled from anywhere in the game once saved
  - characters make up the world
  - https://www.reddit.com/r/love2d/comments/w9us4g/methods_for_printing_a_table_like_an_excel_table/
    - Use this to display table of player stats
    - also take it to the scores board mode
    - flesh out the options menu
]]
print('characterCreation.lua -> ')
print('characterCreation -> ')

require('helpers/font_helpers')

-- dependencies
local fanfic = require 'states/menu/fanfic'
local man = require 'states/characterCreation/drawMan'

text = fanfic.new(
  200,300,
  "You are approaching the planet 'Nebulon'",
  false,
  16
)

-- registering the gamestate
local characterSheet = Game:addState('characterCreation')

function characterSheet:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER template STATE - %s \n", os.date()))
  end

  _G.character = {}
  local GC = _G.character
  -- print(_G)

  GC.name = ''
  GC.stats = {}
  GC.avatar = {}
  -- GC.weight
  -- GC.height
  -- GC.race

  _font = love.graphics.getFont( )

  __fonts['font20'] = love.graphics.newFont('assets/fonts/SummerDreamSans.ttf', 20)

  scarA = love.graphics.newImage("assets/scars/scar_1.png")
  scarB = love.graphics.newImage("assets/scars/scar_2.png")
end
function characterSheet:update(dt)
  text:update(dt)
  data = text:enteredText()
  if data then
    _G.character.name = data
  end
end
function characterSheet:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255,255,255, 255)

  -- headerbox
  love.graphics.setColor(250, 155, 155, 255)
  love.graphics.rectangle("fill",
    0,
    0,
    screen_width,
    100--screen_height
  )
  -- header box 2
  love.graphics.setColor(200, 155, 155, 255)
  love.graphics.rectangle("fill",
    0,
    100,
    screen_width,
    100--screen_height
  )


  -- love.graphics.setFont(font20)
  -- print(font20:getLineHeight())


  -- trying to use a testfont functionality
  love.graphics.setColor(0, 0, 0, 255)
  r, p = pcall(
    -- withFont('font20', love.graphics.print("Strength", 450, 150 ))
    withFont,
    {'font20', love.graphics.print("Strength", 450, 150 )}
  )
  -- print(r, p)

  love.graphics.setColor(100, 200, 400, 255)
  love.graphics.print(_G.character.name,
    50, 200,
    nil,
    4,4 -- sx, sy
  )

  -- withFont('font20', love.graphics.print("Strength", 450, 150 ))
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print('default', 50, 150 )
  -- love.graphics.print('RAINT RAINT', 250, 150 )
  -- love.graphics.print('RAINT RAINT', 350, 150 )
  -- love.graphics.print('RAINT RAINT', 50, 150 )
  -- -- pink raint
  -- love.graphics.print("raint", 400, 100 )
  -- love.graphics.setFont(_font)

  -- black raint left
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print("Create Your Character", 50, 50 )

  -- body thumb rule measures TODO improve and encapsulate
  local boxwidth = 300
  local boxheight = 80
  local centerx = camera.pos.x + screen_width/2 - (boxwidth/2)
  local centery = camera.pos.y + screen_height/2
  local head = {
    w = 128,
    h = 128,
    x = centerx + boxwidth/2,
    y = centery - 100,
  }
  local headw = 64
  local headh = 156
  local header = {
    pos = {
      x = centerx,
      y = centery
    }
  }

  -- red box around body
  love.graphics.setColor(250, 5, 5, 255)
  love.graphics.rectangle("line",
    header.pos.x,
    header.pos.y,
    (screen_width / 2 ) - 80,
    (screen_width / 2 ) - 80
  )

  --red box upper left
  love.graphics.setColor(200, 55, 55, 255)
  love.graphics.rectangle("fill",
    100,
    100,
    -- camera.pos.x - (screen_width / 2) - 480,
    -- camera.pos.y - (screen_width / 2) - 480,
    -- (screen_width / 2 ) - 180,
    -- (screen_width / 2 ) - 180
    100,
    100
  )

  man:drawHead()
  man:drawChest()
  man:drawAbdmen()

  man:drawShading()

  man:drawTattoo()
  man:drawScars()
  man:drawNipples()

  -- love.graphics.setColor(0, 255, 255, 255)

  -- love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- draw the tattoo
  man.drawText()
  -- tattoo text box
	text:draw()

  -- the applied tattoo - stamp - punchcard
	if data then
    -- the tatoo
		love.graphics.setColor(0,30,70)
    love.graphics.print(data,
      centerx+80, --x,
      centery+45, --, y,
      0, -- r,
      4,-- sx,
      4-- sy,
    )
    -- the captains log of the tatoo
		love.graphics.setColor(255,255,255)
		love.graphics.print(
      "You RAINTED: '"..data.."' into the captains log", 200, 350)
      -- DO SOMTHING todo ToDO WITH THE DATA

    -- what is this?
		love.graphics.setColor(155,155,155)
    love.graphics.rectangle("fill",
      100+camera.pos.x * 2.1,
      100+camera.pos.y * 2.1,
      (80),
      (80)
    )
    -- love.graphics.rectangle("fill",
    --   camera.pos.x - (screen_width / 2) - 80,
    --   camera.pos.y - (screen_width / 2) - 80,
    --   (screen_width / 2 ) - 80,
    --   (screen_width / 2 ) - 80
    -- )

    -- what is this?
		love.graphics.setColor(95,195,255)
    love.graphics.rectangle("line",
      100+camera.pos.x * 2.1,
      100+camera.pos.y * 2.1,
      (80),
      (80)
      -- camera.pos.x - (screen_width / 2) - 80,
      -- camera.pos.y - (screen_width / 2) - 80,
      -- (screen_width / 2 ) - 80,
      -- (screen_width / 2 ) - 80
    )
    -- what is this?
    love.graphics.rectangle("line",
    100+camera.pos.x * 2.1, 100+camera.pos.y * 2.1, (82), (82))
    love.graphics.rectangle("line",
    100+camera.pos.x * 2.1, 100+camera.pos.y * 2.1, (84), (84))


    love.graphics.setColor(_r, _g, _b, _a)
	end


  -- -- color and font resets
  -- love.graphics.setColor(_r, _g, _b, _a)
  -- love.graphics.setFont(_font)
end
function characterSheet:exitedState()
  love.graphics.clear()
end

-- input
function characterSheet:mousepressed(x,y, button , istouch) end
function characterSheet:mousereleased(x, y, button) end
function characterSheet:keypressed(key, code)
  text:keypressed(key, code)
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
end
