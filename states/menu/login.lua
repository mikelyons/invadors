local suit = require '../../lib/suit'
local utf8 = require 'utf8'

local function validate(input)
  local len = utf8.len(input.text)

  -- allow only lowercase a-z (also no spaces, etc)
  input.text = input.text:gsub("[^a-z]", "")

  -- reset cursor to where it was before charater removal
  input.cursor = input.cursor - (len - utf8.len(input.text))
end

local input = {text = ""}
function love.update(dt)
  -- place textbox at (100,100) with with 200px and height 30px
  suit.Input(input, 100,100,200,30)
  validate(input)
end

function love.draw(dt)
  suit.draw()
end

function love.textinput(t)
  suit.textinput(t)
end

function love.keypressed(key)
  suit.keypressed(key)
end

-- if you want IME input, requires a font that can display the characters
function love.textedited(text, start, length)
  suit.textedited(text, start, length)
end