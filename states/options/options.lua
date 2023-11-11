--[[
  options.lua

  the options menu
  - resolution
  - aspect ratio
  - key bindings
  - sound
  - save file
  - feedback
  - 
]]

print('options.lua -> ')
-- dependencies
print('options -> ')

local Options = Game:addState('options') -- registering the gamestate

function Options:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER options STATE - %s \n", os.date())) end

  Options.rect = {
    x = 20,
    y = 20,
    width = 200,
    height = 200
  }

end
function Options:update(dt) end

function Options:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  local rect = Options.rect


  love.graphics.setColor(0, 255, 255, 255)

        -- from evilnote
        love.graphics.setColor(175, 225, 195, 255)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
        love.graphics.setColor(205, 255, 205, 255)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height/20)
        -- love.graphics.setColor(205, 5, 5, 255)

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf(
          'OPTIONS MENU',-- text, --SplashText:getText()
          rect.x+20,
          rect.y+20,
          220
        )
        love.graphics.setColor(255, 255, 255, 255)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- function Options:exitedState() love.graphics.clear() end

-- input
function Options:mousepressed(x,y, button , istouch) end
function Options:mousereleased(x, y, button) end
function Options:keypressed(key, code)
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then  end
  -- if key == ('escape') then self:popState() end
end
