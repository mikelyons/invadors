--[[
  characterCreation.lua

  a template foradding a new gamestate
  @IDEALS

  - Name the character something goherent
  - all characters are saved to the save directory
  - all characters can be recalled from anywhere in the game once saved
  - characters make up the world
]]

print('characterCreation.lua -> ')
print('characterCreation -> ')

-- dependencies
local fanfic = require 'states/menu/fanfic'

text = fanfic.new(
  200,300,
  "You are approaching the planet 'Nebulon'",
  false,
  16
)

-- registering the gamestate
local characterSheet = Game:addState('characterCreation')

-- input
function characterSheet:mousepressed(x,y, button , istouch) end
function characterSheet:mousereleased(x, y, button) end
function characterSheet:keypressed(key, code)
  text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
end

function characterSheet:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER template STATE - %s \n", os.date()))
  end

  scarA = love.graphics.newImage("assets/scars/scar_1.png")
  scarB = love.graphics.newImage("assets/scars/scar_2.png")
end
function characterSheet:update(dt)
  text:update(dt)
  data = text:enteredText()
end
function characterSheet:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()

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


  -- head
  love.graphics.setColor(255,209,127)
  -- love.graphics.rectangle("fill", centerx + boxwidth/2, centery - 100, headw, headh)
  love.graphics.circle("fill",
    centerx + boxwidth/2,
    centery - 100,
    headw,
    headh
  )
  -- eye
  love.graphics.setColor(0,0,0)
  love.graphics.circle("fill",
    centerx + boxwidth/2 + 32,
    centery - 100 + 32,
    16,
    16
  )
  love.graphics.setColor(255,209,127)
  love.graphics.circle("fill",
    centerx + boxwidth/2 + 32,
    centery - 100 + 37,
    16,
    16
  )
  -- love.graphics.circle("fill",
  --   centerx + boxwidth/2,
  --   centery - 100,
  --   headw,
  --   headh
  -- )

    -- chest shape
		love.graphics.setColor(255,209,127)
    love.graphics.rectangle("fill",
      centerx,
      centery,
      boxwidth,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx,
      centery,
      boxwidth,
      boxheight
    )
    -- Abdomen shape
    love.graphics.rectangle("fill",
      centerx + (boxwidth*0.1),
      centery + boxheight/2,
      boxwidth*0.8,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx + (boxwidth/4),
      centery + boxheight,
      boxwidth/2,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx + (boxwidth/3),
      centery + boxheight*2,
      boxwidth/3,
      boxheight
    )

    -- muscle shadows (pex)
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery+10,
      boxwidth-6,
      (10)
    )
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery,
      boxwidth-4,
      (20)
    )
    love.graphics.rectangle("line",
      centerx,
      centery+40,
      boxwidth-2,
      (40)
    )
    -- armpit shadow
    love.graphics.rectangle("fill",
      centerx+3,
      centery+3,
      32,
      32
    )

    -- muscle shadows (abs)
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery+10,
      boxwidth/6,
      (10)
    )
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery,
      boxwidth/4,
      (20)
    )
    love.graphics.rectangle("line",
      centerx+40,
      centery+40,
      boxwidth/2,
      (40)
    )

    -- tattoo
		-- love.graphics.setColor(245,159,97)
    local tatbarh = 4
		love.graphics.setColor(0,5,55)
    love.graphics.rectangle("fill",
      centerx+80,
      centery+30,
      64,
      tatbarh
    )
    love.graphics.rectangle("fill",
      centerx+80,
      centery+40,
      64,
      tatbarh
    )
    love.graphics.rectangle("fill",
      centerx+80,
      centery+50,
      64,
      tatbarh
    )
    
		love.graphics.setColor(0,5,55)
    love.graphics.rectangle("fill",
      centerx+180,
      centery+30,
      tatbarh,
      64
    )
    love.graphics.rectangle("fill",
      centerx+190,
      centery+40,
      tatbarh,
      64
    )
    love.graphics.rectangle("fill",
      centerx+200,
      centery+50,
      tatbarh,
      64
    )
    love.graphics.print("raint",
      centerx+120, --x,
      centery+50 --, y,
      -- r,
      -- sx,
      -- sy,
      -- ox,
      -- oy
    )
    love.graphics.print("r\na\ni\nn\nt",
      centerx+160, --x,
      centery+50 --, y,
      -- r,
      -- sx,
      -- sy,
      -- ox,
      -- oy
    )

    -- scars
    s1w = hamster:getWidth()
    s1h = hamster:getHeight()
    -- s1a= love.timer.getTime() * 2*math.pi / 2.5 -- Rotate one turn per 2.5 seconds.
    s1a=1
    love.graphics.draw(scarA,
      -- 100,
      -- 100,
      centerx+210, --x,
      centery+90, --, y,
      s1a,
      0.5,0.5,
      s1w/2, s1h/2
    )
    love.graphics.draw(scarB,
      -- 100,
      -- 100,
      centerx+170, --x,
      centery+90, --, y,
      s1a/2,
      0.9,0.9,
      s1w/2, s1h/2
    )

    -- armpit shadow
    love.graphics.rectangle("fill",
      centerx+3,
      centerx*2-300,
      32,
      32
    )

    -- nipples
		love.graphics.setColor(245,159,97)
    love.graphics.rectangle("fill",
      centerx+40,
      centery+40,
      32,
      32
    )
    love.graphics.rectangle("fill",
      centerx*2-300,
      centery+40,
      32,
      32
    )
    -- love.graphics.rectangle("fill",
    --   centerx,
    --   centery,
    --   boxwidth,
    --   (80)
    -- )

    -- pasties
		love.graphics.setColor(0,0,55)
    love.graphics.print("X",
      centerx+40 + 8,
      centery+40 + 8,
      0,-- r,
      2,-- sx,
      2-- sy,
      -- ox,
      -- oy
    )
    love.graphics.print("x",
      centerx*2-300 + 8,
      centery+40 + 8,
      0, -- r,
      2, -- sx,
      2-- sx,
      -- sy,
      -- ox,
      -- oy
    )
  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.rectangle("fill",
    camera.pos.x - (screen_width / 2) - 80,
    camera.pos.y - (screen_width / 2) - 80,
    (screen_width / 2 ) - 80,
    (screen_width / 2 ) - 80
  )
  love.graphics.setColor(_r, _g, _b, _a)

  love.graphics.setColor(0, 255, 255, 255)
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
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	text:draw()
	if data then
		love.graphics.setColor(0,30,70)
    -- love.graphics.print(data .."TATTED "..data,
    love.graphics.print(data,
      centerx+80, --x,
      centery+45, --, y,
      0, -- r,
      4,-- sx,
      4-- sy,
      -- ox,
      -- oy
    )
		love.graphics.setColor(255,255,255)
		love.graphics.print("You RAINTED: '"..data.."' into the captains log", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA

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
    love.graphics.rectangle("line", 100+camera.pos.x * 2.1, 100+camera.pos.y * 2.1, (82), (82))
    love.graphics.rectangle("line", 100+camera.pos.x * 2.1, 100+camera.pos.y * 2.1, (84), (84))

    love.graphics.setColor(_r, _g, _b, _a)
	end
end
function characterSheet:exitedState()
  love.graphics.clear()
end
