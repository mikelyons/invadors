-- print('pressStart.lua -> ')

PressStart = Game:addState('PressStart')

function Game:initialize()
  print("")
  print("")
  print('pressStart.lua -> ')
  print("")
  print("")
end

-- love.graphics.clear( r, g, b, a, clearstencil, cleardepth )
function PressStart:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER PressStart STATE - %s \n", os.date()))
  end

  love.graphics.clear( 0, 0, 0, 255)--, clearstencil, cleardepth )

  -- doom effect of frames not clearing
  -- love.graphics.clear = function() end


  print('pressStart.lua -> helo ')
  print('hello')
end

function PressStart:mousereleased(x, y, button) end

  print("")
  print("")
  print('butt')
  print("")
  print("")

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
  if math.floor(love.timer.getTime()) % 2 == 0 then
    -- love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )

    -- print(g_GameTime)
    -- print(g_Height)
    -- print(love.timer.getTime())
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    love.graphics.print('Press Start', w/2, h/2)
  end
end


function PressStart:exitedState() end
