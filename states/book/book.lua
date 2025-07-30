--[[
  book.lua

  The gamestate for reading books
]]

print('book.lua -> ')
print('book -> ')

-- Add step-by-step debugging
print("Book: Starting to load dependencies...")

-- dependencies
print("Book: Skipping fanfic library - removed to avoid module system issues")

-- No text input for now
text = nil

-- Load assets with error handling
print("Book: Loading bookGraphic...")
local success, bookGraphic = pcall(love.graphics.newImage, "assets/machines/computer/computer.png")
if not success then
  print("Warning: Could not load bookGraphic")
  bookGraphic = nil
else
  bookGraphic:setFilter("nearest", "nearest")
  print("Book: bookGraphic loaded successfully")
end

print("Book: Loading fingers image...")
local success2, fingers = pcall(love.graphics.newImage, "states/book/fingers.png")
if not success2 then
  print("Warning: Could not load fingers image")
  fingers = nil
else
  print("Book: fingers image loaded successfully")
end

-- registering the gamestate
print("Book: Registering gamestate...")
local Book = Game:addState('book')
print("Book: Gamestate registered successfully")

if DEBUG_LOGGING_LOADING then
  print("Book state registered successfully")
end

print("Book: State loading completed successfully!")

-- input
function Book:mousepressed(x, y, button, istouch)
  -- Handle mouse press events
  if DEBUG_LOGGING_INPUT then
    print("Book: mousepressed at", x, y, "button:", button)
  end
end

function Book:mousereleased(x, y, button)
  -- Handle mouse release events
  if DEBUG_LOGGING_INPUT then
    print("Book: mousereleased at", x, y, "button:", button)
  end
end
function Book:keypressed(key, code)
  if text and text.keypressed then
    text:keypressed(key, code)
  end
  if key == ('escape') then 
    print("Book: Escape pressed, calling popState()")
    print("Current state stack before pop:", table.concat(self:getStateStackDebugInfo(), ", "))
    self:popState() 
    print("Book: popState() called")
  end
  -- if key == ('escape') then love.event.push('quit') end
end

function Book:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER book STATE - %s \n", os.date()))
  end
  print("Book state entered successfully")
end
function Book:update(dt)
  if text and text.update then
    text:update(dt)
    data = text:enteredText()
  end
  -- No text input, so no data to process
  data = nil
end
function Book:draw()
  -- ensure proper gravatar color
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)
  -- love.graphics.reset()
  -- love.graphics.pop()
  love.graphics.setColor(_r, _g, _b, _a)

  -- PrintDebug(fanfic)

  -- sign in text box
	if text and text.draw then
		text:draw()
	end
	if data then
		love.graphics.setColor(255,255,255)
		love.graphics.print("You typed: '"..data.."' in the text box", 200, 350)
    -- DO SOMTHING todo ToDO WITH THE DATA
	end
	
	-- Display a message since text input is disabled
	love.graphics.setColor(255,255,255)
	love.graphics.print("Text input disabled - press ESC to return to menu", 200, 350)

  if bookGraphic then
    love.graphics.draw(bookGraphic, 100, 100)
  end
  if fingers then
    love.graphics.draw(fingers, 200, 200)
  end
end
function Book:exitedState()
  love.graphics.clear()
  print("Book state exited")
end
