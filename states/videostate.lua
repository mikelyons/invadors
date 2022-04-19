
local Video = Game:addState('Pause')

function Video:initialize()
  print('pause INITED')
end

function Video:enteredState()
  print("PAUSED")
end
function Video:exitedState()
  print("UN-PAUSED")
end

-- function Pause:update(dt)
-- end

tanuki = love.graphics.newImage("assets/imageSequence/scene00001.png")

local images = {}

for i = 1, 20 do--748 do
  local filename = 'scene'..string.format("%05d", i)
  print(filename)

  images[i] = love.graphics.newImage('assets/imageSequence/'..filename..'.png')
end

imgno = 1

local function drawBg(number)
  print('img no '..number)
  love.graphics.draw(
    images[number],
    1,
    1
  )
end

function Video:draw()

  -- if imgno == 748 then
  if imgno == 20 then
    imgno = 1
  else
    imgno = imgno + 1
  end
  drawBg(imgno)
  -- love.graphics.draw(background,
  --   g_Width,
  --   g_Height
  -- )

  love.graphics.setBackgroundColor(51, 49, 99, 100)--BG_COLOR)

  love.graphics.setColor(0,0,51,100)
  love.graphics.rectangle('fill', 350, 350, 350, 350)

  love.graphics.setColor(255, 223, 0)
  love.graphics.printf('GAME PAUSED', 350, 220, 200, 'center')
end


function Video:update(dt)
end

function Video:keypressed(key, code)
  if key == ('escape' or 'p') then self:popState('Pause') end
  -- if key == ('return' or 'm') then self:gotoState('Menu') end
  if key == ('q') then love.event.push('quit') end
end
