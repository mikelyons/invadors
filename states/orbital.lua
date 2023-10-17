
local orbital = Game:addState('orbital')


-- This is the code that's going to run on the our thread. It should be moved
-- to its own dedicated Lua file, but for simplicity's sake we'll create it
-- here.
local threadCode = [[
  require('love.sound')
  require('love.audio')
  local denver  = require '../../lib/denver'
  local songUfo = require '../src/audio/music/ufo1'
  local whitenoise = require '../src/audio/music/whitenoise'
  local noise = require '../src/audio/music/noise'

  -- songUfo(denver)
  -- whitenoise(denver)
  noise(denver, 'brownnoise')
  -- noise(denver, 'pinknoise')

  -- print(...)


  -- love.audio.setVolume(0.5)

  -- Receive values sent via thread:start
  local min = 0
  local max = 1000

  for i = min, max do
      -- The Channel is used to handle communication between our main thread and
      -- this thread. On each iteration of the loop will push a message to it which
      -- we can then pop / receive in the main thread.
      love.thread.getChannel( 'info' ):push( i )


      -- scary bouncing ufo noise
      -- local sine = denver.get({waveform='sinus', frequency=(i), length=1})
      -- love.audio.play(sine)
  end
]]

local thread -- Our thread object.
local timer  -- A timer used to animate our circle.

function orbital:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER orbital STATE - %s \n", os.date()))
  end

  createBox = require "tools/createbox"

    -- r4 = createBox:create(196,196)
  r4 = createBox:createRandom()

  r4:load()
    -- self:popState('orbital')

  thread = love.thread.newThread( threadCode )
  thread:start( 99, 1000 )

  self.solarCycle = 0
  self.yearCycle = 0

end

function orbital:exitedState()
  -- destroy buttons, menus, etc
    local info = love.thread:set("control", "kill")
end

function orbital:update(dt)
    timer = timer and timer + dt or 0

    -- print('update')

    -- Make sure no errors occured.
    local error = thread:getError()
    if error then print('--------ERROR: '..error) end
    assert( not error, error )

    local info = love.thread.getChannel( 'info' ):pop()
    -- print(info or 'raint')
end

function orbital:draw(dt)
  -- draw this to a canvas to put on screen

    -- Get the info channel and pop the next message from it.
    local info = love.thread.getChannel( 'info' ):pop()
      -- print(info or 'raint')
    if info then
      love.graphics.setColor(205, 205, 195, 255)
      love.graphics.rectangle("fill", 0, 0, 200, 250)
      love.graphics.setColor(205, 5, 5, 255)
      love.graphics.circle( 'line', 100 + math.sin( timer ) * 20, 100 + math.cos( timer ) * 20, 20 )
      love.graphics.circle( 'line', 100, 100, 2 )
      love.graphics.print( 'info', 10, 10 )
      love.graphics.print( info, 80, 10 )
      love.graphics.print( 'sol', 10, 40 )
      love.graphics.print( self.solarCycle, 80, 40 )
      love.graphics.print( 'earth', 10, 90 )
      love.graphics.print( self.solarCycle, 180, 90 )
    end

    -- print('draw')

    -- We smoothly animate a circle to show that the thread isn't blocking our main thread.
    love.graphics.circle( 'line', 100 + math.sin( timer ) * 20, 100 + math.cos( timer ) * 20, 20 )
end

function orbital:keypressed(key, code)
  if key == 'escape' then self:popState('orbital') end
end



