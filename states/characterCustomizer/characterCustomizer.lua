--[[
  template.lua

  @TODO
  - https://github.com/gustavostuff/urutora - UI try this
]]

if DEBUG_LOGGING_LOADING then
  print('template.lua -> ')
  print('template -> ')
end
-- dependencies
local font = love.graphics.newFont(192)
-- local Gspot = require 'Gspot'
local Gspot = require('lib/gspot/Gspot') -- import the library
-- local gui = require('lib/gspot/Gspot') -- import the library
local newSlider = require 'states/characterCustomizer/slider' -- Load our custom slider module

local Template = Game:addState('characterCustomizer') -- registering the gamestate

gui = Gspot() -- Initialize Gspot

function Template:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER characterCustomizer STATE - %s \n", os.date())) end

  -- Create a slider: gui, label, {x, y, w, h}, min, max, initial value
  -- mySlider = newSlider(gui, 'Volume', {50, 50, 200, 20}, 0, 100, 50)

	love.graphics.setFont(font)

	roboKnight = {
    image = love.graphics.newImage("states/characterCustomizer/roboKnight.png"),
    x = 100,
    y = 100,
    stretch = 0
  }

  _G.ui.lorem()
end
function Template:exitedState() love.graphics.clear() end

function Template:update(dt)
  gui:update(dt) -- Update all Gspot elements, including our slider
end

function Template:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.draw(roboKnight.image, 100, 100)

  love.graphics.print( "raint", 400, 400)
  love.graphics.rectangle("fill", 100, 100, 100, 100)

  gui:draw() -- Draw all Gspot elements

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Template:mousepressed(x,y, button , istouch)
  gui:mousepress(x, y, button) -- Forward mouse press to Gspot
end
function Template:mousereleased(x, y, button)
  gui:mouserelease(x, y, button) -- Forward mouse release to Gspot
end
function Template:keypressed(key, code)
  if key == ('escape') then love.event.push('quit') end
end
