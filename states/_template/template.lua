--[[
  template.lua

  a template for adding a new gamestate

  when using this template, copy to the new state directory, then find-replace 
  the word 'template' with the new state name for internal variables and
  find-replace the word 'Template' (capitalization) for the instance/class name.
]]

if DEBUG_LOGGING_LOADING then
  print('template.lua -> ')
  print('template -> ')
end 
-- dependencies

local Template = Game:addState('template') -- registering the gamestate

function Template:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER template STATE - %s \n", os.date())) end
end
function Template:exitedState() love.graphics.clear() end

function Template:update(dt) end

function Template:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Template:mousepressed(x,y, button , istouch) end
function Template:mousereleased(x, y, button) end
function Template:keypressed(key, code)

  if key == ('escape') then love.event.push('quit') end
end
