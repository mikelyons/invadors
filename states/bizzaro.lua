
local Bizzaro = Game:addState('bizzaro')

function Bizzaro:enteredState()
  print('ENTERED bizzaro STATE!')
  print(os.date())
  -- print(os.getenv('PATH')) -- get environmental variable
  print(debug.getfenv(Game)) -- not sure what this does

  createBox = require "tools/createbox"

  -- r1 = createBox:create(64,64)
  -- r2 = createBox:create(96,96)
  -- r3 = createBox:create(164,164)
  -- r4 = createBox:create(196,196)
  r1 = createBox:createRandom()
  r2 = createBox:createRandom()
  r3 = createBox:createRandom()
  r4 = createBox:createRandom()

  r1:load()
  r2:load()
  r3:load()
  r4:load()
  -- self:popState('bizzaro')
end

function Bizzaro:exitedState() end
function Bizzaro:update(dt) end
function Bizzaro:draw(dt) end

function Bizzaro:keypressed(key, code)
  if key == 'escape' then self:popState('bizzaro') end
end
