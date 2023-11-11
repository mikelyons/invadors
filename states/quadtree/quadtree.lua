
--[[
  quadtree.lua

  a template for adding a new gamestate
]]

print('template.lua -> ')
-- dependencies
print('template -> ')

Quadtree = require 'tools/quadtree'

local Signin = Game:addState('quadtree') -- registering the gamestate

function drawQuadtree(node)
    if node.children then
        for _, child in pairs(node.children) do
            drawQuadtree(child)
        end
    end
    love.graphics.rectangle("line", node.x, node.y, node.width, node.height)
end

function Signin:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER template STATE - %s \n", os.date())) end

  -- this wasn't right!!!!
  self.quadtree = Quadtree:new(0, 0, 800, 600)  -- Replace with your screen dimensions
-- Insert objects into the quadtree
-- quadtree:insert(object)


end
function Signin:exitedState() love.graphics.clear() end

function Signin:update(dt)
    self.quadtree:clear()
    -- Insert or remove objects from the quadtree as needed
end

function Signin:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)

      love.graphics.setColor(1, 1, 1)
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Draw other game elements

    -- Draw the quadtree
    drawQuadtree(self.quadtree.root)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Signin:mousepressed(x,y, button , istouch) end
function Signin:mousereleased(x, y, button) end
function Signin:keypressed(key, code)

  if key == ('escape') then love.event.push('quit') end
end

--[[

print('template.lua -> ')
print('template -> ')

-- dependencies
local fanfic = require 'states/menu/fanfic'

text = fanfic.new(200,300, "New textbox", false, 16)

-- registering the gamestate
local Signin = Game:addState('template')

-- input
function Signin:mousepressed(x,y, button , istouch) end
function Signin:mousereleased(x, y, button) end
function Signin:keypressed(key, code)
  text:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then love.event.push('quit') end
end

function Signin:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER template STATE - %s \n", os.date()))
  end
end
function Signin:update(dt)
  text:update(dt)
  data = text:enteredText()
end
function Signin:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	text:draw()
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end
end
function Signin:exitedState()
  love.graphics.clear()
end

]]
