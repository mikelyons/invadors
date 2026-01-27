--[[
  template.lua

  a template for adding a new gamestate

  when using this template, copy to the new state directory, then find-replace 
  the word 'template' with the new state name for internal variables and
  find-replace the word 'Template' (capitalization) for the instance/class name.
]]

if DEBUG_LOGGING_LOADING then
  print('vapeStatus.lua -> ')
  print('vapeStatus -> ')
end 
-- dependencies

local Template = Game:addState('vapeStatus') -- registering the gamestate
local lineColor = {0, 1, 5/255, 1} -- Initial color state

function Template:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER vapeStatus STATE - %s \n", os.date())) end
  love.keyboard.setKeyRepeat(true)
end

function Template:exitedState()
  love.graphics.clear()
  love.keyboard.setKeyRepeat(false)
end

function Template:update(dt) end

function Template:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 1, 1, 1)

  love.graphics.setColor(50/255, 50/255, 50/255, 1)
  love.graphics.circle("fill", 200, 200, 100)

  love.graphics.setColor(lineColor)
  love.graphics.circle("line", 200, 200, 80)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Template:mousepressed(x,y, button , istouch) end
function Template:mousereleased(x, y, button) end
function Template:keypressed(key, code)
  if key == 'v' then
    -- Cycle through different colors
    if lineColor[1] == 0 and lineColor[2] == 1 and lineColor[3] == 5/255 then
      lineColor = {1, 0, 0, 1} -- Red
    elseif lineColor[1] == 1 and lineColor[2] == 0 and lineColor[3] == 0 then
      lineColor = {0, 0, 1, 1} -- Blue
    else
      lineColor = {0, 1, 5/255, 1} -- Back to original green
    end
  end

  if key == ('escape') then love.event.push('quit') end
end
