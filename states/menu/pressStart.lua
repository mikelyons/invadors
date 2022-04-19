-- print('pressStart.lua -> ')

PressStart = Game:addState('PressStart')

-- love.graphics.clear( r, g, b, a, clearstencil, cleardepth )
function PressStart:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER PressStart STATE - %s \n", os.date()))
  end

  -- love.graphics.clear( 0, 0, 0, 255)--, clearstencil, cleardepth )

  -- doom effect of frames not clearing
  -- love.graphics.clear = function() end

  print(' -> entered PRESSSTART STATE -> ')
end

function PressStart:mousereleased(x, y, button) end
function PressStart:keypressed(key)
  print("")
  print(key)

  if key == ('q') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
  self:pushState('menu')
end
function PressStart:mousepressed(x,y, button, istouch)
  print("")
  print(button)
end
function PressStart:update(dt) end
function PressStart:draw()
  -- print('raint')
  if math.floor(love.timer.getTime()) % 2 == 0 then
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    love.graphics.setColor(255, 255, 255, 255)
  --   -- love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
    love.graphics.print(
      'Press Start',
      (camera.pos.x + w/2) - 100*3,
      camera.pos.y + h/2,
      nil,
      3
    )
  else
    -- print('press start')
    -- love.graphics.setColor(55, 55, 55, 255)
    -- love.graphics.print('Press Start', camera.pos.x + w/2, camera.pos.y + h/2)
  end
end


function PressStart:exitedState() end
