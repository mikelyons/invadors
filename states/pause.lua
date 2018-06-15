
local Pause = Game:addState('Pause')

function Pause:initialize()
  print('pause INITED')
end

function Pause:enteredState()
  print("PAUSED")
end
function Pause:exitedState()
  print("UN-PAUSED")
end

-- function Pause:update(dt)
-- end

function Pause:draw()
  love.graphics.setBackgroundColor(51, 49, 99, 100)--BG_COLOR)

  love.graphics.setColor(0,0,51,100)
  love.graphics.rectangle('fill', 350, 350, 350, 350)

  love.graphics.setColor(255, 223, 0)
  love.graphics.printf('GAME PAUSED', 350, 220, 200, 'center')
end


function Pause:update(dt)
end

function Pause:keypressed(key, code)
  if key == ('escape' or 'p') then self:popState('Pause') end
  -- if key == ('return' or 'm') then self:gotoState('Menu') end
  if key == ('q') then love.event.push('quit') end
end
