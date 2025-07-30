--[[
  bizzaro.lua

  The Bizzaro State

  Essentially all this does is add flashing squares to the screen 
  in a background layer and then popState itself
]]

local Bizzaro = Game:addState('bizzaro')

function Bizzaro:enteredState()
  print('ENTERED bizzaro STATE!')
  print(os.date())
  -- print(os.getenv('PATH')) -- get environmental variable
  print(debug.getfenv(Game)) -- not sure what this does

  local success, createBox = pcall(require, "tools/createbox")
  if not success then
    print("Error loading createBox:", createBox)
    createBox = nil
  end

  -- Initialize boxes safely
  r1, r2, r3, r4 = nil, nil, nil, nil
  
  if createBox then
    -- r1 = createBox:create(64,64)
    -- r2 = createBox:create(96,96)
    -- r3 = createBox:create(164,164)
    -- r4 = createBox:create(196,196)
    local success1, box1 = pcall(createBox.createRandom, createBox)
    if success1 then r1 = box1 end
    
    local success2, box2 = pcall(createBox.createRandom, createBox)
    if success2 then r2 = box2 end
    
    local success3, box3 = pcall(createBox.createRandom, createBox)
    if success3 then r3 = box3 end
    
    local success4, box4 = pcall(createBox.createRandom, createBox)
    if success4 then r4 = box4 end

    -- Load boxes safely
    if r1 and r1.load then pcall(r1.load, r1) end
    if r2 and r2.load then pcall(r2.load, r2) end
    if r3 and r3.load then pcall(r3.load, r3) end
    if r4 and r4.load then pcall(r4.load, r4) end
  end
  -- self:popState('bizzaro')
end

function Bizzaro:exitedState() end
function Bizzaro:update(dt) end
function Bizzaro:draw(dt) end

function Bizzaro:keypressed(key, code)
  -- if key == 'escape' then self:popState('bizzaro') end
  if key == 'escape' then self:popState() end
end
