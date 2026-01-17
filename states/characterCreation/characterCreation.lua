--[[
  characterCreation.lua
  menu 8

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

-- Add debugging to track loading progress
print("CharacterCreation: Starting to load...")

print("CharacterCreation: Loading font helpers...")
require('helpers/font_helpers')
print("CharacterCreation: Font helpers loaded")

-- dependencies
print("CharacterCreation: Loading fanfic library...")
local success1, fanfic = pcall(require, 'lib/fanfic')
if not success1 then
  print("Error loading fanfic:", fanfic)
  fanfic = nil
else
  print("CharacterCreation: fanfic loaded")
end

print("CharacterCreation: Loading drawMan...")
local success2, man = pcall(require, 'states/characterCreation/drawMan')
if not success2 then
  print("Error loading drawMan:", man)
  man = nil
else
  print("CharacterCreation: drawMan loaded")
end

-- Initialize text input
text = nil

-- registering the gamestate
print("CharacterCreation: Registering gamestate...")
local characterSheet = Game:addState('characterCreation')
print("CharacterCreation: Gamestate registered successfully")

print("CharacterCreation: State loading completed successfully!")

function characterSheet:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER template STATE - %s \n", os.date()))
  end
  print("CharacterCreation: State entered successfully")

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

  -- Load font safely
  local success, font = pcall(love.graphics.newFont, 'assets/fonts/SummerDreamSans.ttf', 20)
  if success then
    __fonts['font20'] = font
    print("CharacterCreation: font20 loaded successfully")
  else
    print("CharacterCreation: Error loading font20:", font)
    -- Fallback to default font
    __fonts['font20'] = love.graphics.newFont(20)
  end

  -- Load scar images safely
  local success1, scar1 = pcall(love.graphics.newImage, "assets/scars/scar_1.png")
  if success1 then
    scarA = scar1
    print("CharacterCreation: scar_1.png loaded successfully")
  else
    print("CharacterCreation: Error loading scar_1.png:", scar1)
    scarA = nil
  end
  
  local success2, scar2 = pcall(love.graphics.newImage, "assets/scars/scar_2.png")
  if success2 then
    scarB = scar2
    print("CharacterCreation: scar_2.png loaded successfully")
  else
    print("CharacterCreation: Error loading scar_2.png:", scar2)
    scarB = nil
  end
  
  -- Initialize text input if fanfic is available
  if fanfic then
    text = fanfic.new(200, 300, "Enter character name:", false, nil, 16)
    print("CharacterCreation: Text input initialized")
  else
    print("CharacterCreation: Warning - No text input available")
  end
end
function characterSheet:update(dt)
  if text and text.update then
    text:update(dt)
    data = text:enteredText()
    if data then
      _G.character.name = data
    end
  end
  -- Don't set data to nil here, as it's used in draw function
end
function characterSheet:draw()
  -- Add error handling to catch silent failures
  local success, err = pcall(function()
    local _r, _g, _b, _a = love.graphics.getColor()
    love.graphics.setColor(255,255,255, 255)

  -- Get screen dimensions safely
  local screen_w = love.graphics.getWidth()
  local screen_h = love.graphics.getHeight()

  -- headerbox
  love.graphics.setColor(250, 155, 155, 255)
  love.graphics.rectangle("fill",
    0,
    0,
    screen_w,
    100--screen_height
  )
  -- header box 2
  love.graphics.setColor(200, 155, 155, 255)
  love.graphics.rectangle("fill",
    0,
    100,
    screen_w,
    100--screen_height
  )


  -- love.graphics.setFont(font20)
  -- print(font20:getLineHeight())


  -- trying to use a testfont functionality
  love.graphics.setColor(0, 0, 0, 255)
  if withFont then
    r, p = pcall(
      -- withFont('font20', love.graphics.print("Strength", 450, 150 ))
      withFont,
      {'font20', love.graphics.print("Strength", 450, 150 )}
    )
    -- print(r, p)
  else
    -- Fallback if withFont is not available
    love.graphics.print("Strength", 450, 150)
  end

  love.graphics.setColor(100, 200, 400, 255)
  local characterName = ""
  if _G.character and _G.character.name then
    characterName = _G.character.name
  end
  love.graphics.print(characterName,
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
  local centerx = 0
  local centery = 0
  
  -- Get screen dimensions safely
  local screen_w = love.graphics.getWidth()
  local screen_h = love.graphics.getHeight()
  
  -- Get camera position safely
  if camera and camera.pos then
    centerx = camera.pos.x + screen_w/2 - (boxwidth/2)
    centery = camera.pos.y + screen_h/2
  else
    centerx = screen_w/2 - (boxwidth/2)
    centery = screen_h/2
  end
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
    (screen_w / 2 ) - 80,
    (screen_w / 2 ) - 80
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

  if man then
    if man.drawHead then man:drawHead() end
    if man.drawChest then man:drawChest() end
    if man.drawAbdmen then man:drawAbdmen() end
    if man.drawShading then man:drawShading() end
    if man.drawTattoo then man:drawTattoo() end
    if man.drawScars then man:drawScars() end
    if man.drawNipples then man:drawNipples() end
    if man.drawText then man:drawText() end
  end

  -- love.graphics.setColor(0, 255, 255, 255)

  -- love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- draw the tattoo
  -- tattoo text box
  if text and text.draw then
    text:draw()
  end

  -- the applied tattoo - stamp - punchcard
	if data and data ~= "" then
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
    local cam_x = 0
    local cam_y = 0
    if camera and camera.pos then
      cam_x = camera.pos.x
      cam_y = camera.pos.y
    end
    love.graphics.rectangle("fill",
      100+cam_x * 2.1,
      100+cam_y * 2.1,
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
      100+cam_x * 2.1,
      100+cam_y * 2.1,
      (80),
      (80)
      -- camera.pos.x - (screen_width / 2) - 80,
      -- camera.pos.y - (screen_width / 2) - 80,
      -- (screen_width / 2 ) - 80,
      -- (screen_width / 2 ) - 80
    )
    -- what is this?
    love.graphics.rectangle("line",
    100+cam_x * 2.1, 100+cam_y * 2.1, (82), (82))
    love.graphics.rectangle("line",
    100+cam_x * 2.1, 100+cam_y * 2.1, (84), (84))


    love.graphics.setColor(_r, _g, _b, _a)
	end


  -- -- color and font resets
  -- love.graphics.setColor(_r, _g, _b, _a)
  -- love.graphics.setFont(_font)
  end) -- Close pcall
  
  if not success then
    print("CharacterCreation draw error:", err)
    -- Fallback drawing - just show a simple message
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Character Creation", 50, 50)
    love.graphics.print("Error in drawing - check console", 50, 100)
  end
end
function characterSheet:exitedState()
  love.graphics.clear()
end

-- input
function characterSheet:mousepressed(x,y, button , istouch) end
function characterSheet:mousereleased(x, y, button) end
function characterSheet:keypressed(key, code)
  if text and text.keypressed then
    text:keypressed(key, code)
  end
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then love.event.push('quit') end
  if key == 'escape' then self:popState() end
end
