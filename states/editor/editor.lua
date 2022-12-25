--[[
  A simple ui for game object editing in-game

  Creates a ui panel with form for object attributes
]]

print('editor.lua -> ')
print('editor -> ')

local fanfic = require 'states/menu/fanfic'
-- love.graphics.setFont(oldFont)

local editorui = require 'states/editor/editorui'


local Editor = Game:addState('editor')

function Editor:mousepressed(x,y, button , istouch) end
function Editor:mousereleased(x, y, button) end
function Editor:keypressed(key, code)
  text:keypressed(key, code)

  uipanel:keypressed(key, code)
  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState() end
end

function Editor:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER editor STATE - %s \n", os.date()))
  end
  love.window.setTitle(__TITLE_STR..' - editor STATE')

  text = fanfic.new(20,30, "Name", false, 16)

  uipanel = editorui:new(400, 100)
  uipanel:load()

end
function Editor:update(dt)
  text:update(dt)
  data = text:enteredText()

  uipanel:update(dt)
  output = panel.output
end
function Editor:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(055, 055, 055, 255)
  -- love.graphics.rectangle('fill', 400, 0, 100, 100)
  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- uieditor based module
  uipanel:draw()
	if uipanel.output then
    local data = uipanel.output
		love.graphics.setColor(255,255,255)
		-- love.graphics.print("You typed: '"..data.."' in the ui panel", 200, 350)
		love.graphics.print(""..data.."'", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end

  -- sign in text box
	text:draw()
 -- original tester
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print(""..data.."'", 200, 390)
		-- love.graphics.print(""..data.."'", 200, 350)
	end

end

function Editor:exitedState()
  love.window.setTitle(__TITLE_STR)
  love.graphics.clear()
end
