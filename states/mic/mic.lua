
--[[
  Records a user's microphone and echos it back to them.

  This uses the included QueueableSource object, which may still have issues.
]]

print('mic.lua -> ')

-- dependencies
-- Alias love-microphone as microphone

local microphone = require 'lib/love-microphone/love-microphone/init'
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
print('RAINT')
-- h,microphone = pcall(require,'states/mic/love-microphone/init')

-- print(h,j)

local Mic = Game:addState('mic') -- registering the gamestate


  local h, j = pcall(require, 'lib/love-microphone/love-microphone/init')
  print(h, j)
-- local microphone = require 'lib/love-microphone/love-microphone/init'
PrintTable(microphone, 1)

local device, source
function Mic:enteredState()
  print('mic 18 -> ')
  -- if DEBUG_LOGGING_ON then print(string.format("ENTER mic STATE - %s \n", os.date())) end

  -- Report the name of the microphone we're going to use
  print("Opening microphone:")
  print("Opening microphone:")


  local h, j = pcall(microphone.getDefaultDeviceName)
  print(h, j)


  print("Opening microphone:", microphone.getDefaultDeviceName())

  -- Open the default microphone device with default quality and 100ms of latency.
  device = microphone.openDevice(nil, nil, 0.1)

  -- Create a new QueueableSource to echo our audio
  source = microphone.newQueueableSource()

  -- Register our local callback
---@diagnostic disable-next-line: need-check-nil
  device:setDataCallback(function(device, data)
    source:queue(data)
    source:play()
  end)

  -- Start recording
  device:start()
end
function Mic:exitedState() love.graphics.clear() end

-- Add microphone polling to our update loop
function Mic:update(dt)
  device:poll()
end

function Mic:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)

  -- love.graphics.print("raint", 100, 100)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Mic:mousepressed(x,y, button , istouch) end
function Mic:mousereleased(x, y, button) end
function Mic:keypressed(key, code)

  if key == ('escape') then love.event.push('quit') end
  -- if key == ('escape') then self:popState('mic') end
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
