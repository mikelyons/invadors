
-- require '../../lib/denver'

local Synth = Game:addState('synth')

local denver = require '../../lib/denver'

-- this gamestate will be the spooky computer view with ghosts

sheet = {'B4', 'E5'}

-- image version of this
-- https://www.reddit.com/r/gamedev/comments/7ylvt9/pixelator_a_gamedev_tool_i_wrote_to_convert_any/
function Synth:enteredState()
  love.audio.setVolume(0.1)

  for i=10,1,-1 do print(i)
    local sine = denver.get({waveform='sinus', frequency=540, length=1})
    love.audio.play(sine)
    love.timer.sleep(1)
    local sine = denver.get({waveform='sinus', frequency=040, length=1})
    love.audio.play(sine)
    love.timer.sleep(1)
    local sine = denver.get({waveform='sinus', frequency=140, length=1})
    love.audio.play(sine)
    love.timer.sleep(1)
    local sine = denver.get({waveform='sinus', frequency=240, length=1})
    love.audio.play(sine)
    love.timer.sleep(1)
    local sine = denver.get({waveform='sinus', frequency=940, length=1})
    love.audio.play(sine)
  end
  local sine = denver.get({waveform='sinus', frequency=740, length=1})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=840, length=1})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=840, length=1})
  love.audio.play(sine)

  -- play a sinus of 1sec at 440Hz
  local sine = denver.get({waveform='sinus', frequency=440, length=1})
  love.audio.play(sine)

  -- play a F#2 (available os)
  --low base note
  -- local square = denver.get({waveform='square', frequency='F#2', length=1})
  -- love.audio.play(square)

  -- to loop the wave, don't specify a length (generates one period-sample)
  -- local saw = denver.get({waveform='sawtooth', frequency=440})
  -- saw:setLooping(true)
  -- love.audio.play(saw)

  -- play noise
  -- local noise = denver.get({waveform='whitenoise', length=6})
  -- love.audio.play(noise)
end

function Synth:keypressed(key, code)
  if key == ('space' or 'return') then self:pushState('Menu') end
  if key == ('q') then love.event.push('quit') end
end