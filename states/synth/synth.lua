-- require '../../lib/denver'

local Synth = Game:addState('synth')

local denver = require '../../lib/denver'


sheet = {'B4', 'E5'}

-- image version of this
-- https://www.reddit.com/r/gamedev/comments/7ylvt9/pixelator_a_gamedev_tool_i_wrote_to_convert_any/
function Synth:enteredState()
  love.audio.setVolume(0.5)

  -- for i=4,1,-1 do print(i)
  --   local sine = denver.get({waveform='sinus', frequency=540, length=1})
  --   love.audio.play(sine)
  --   love.timer.sleep(1)
  --   local sine = denver.get({waveform='sinus', frequency=040, length=1})
  --   love.audio.play(sine)
  --   love.timer.sleep(1)
  --   local sine = denver.get({waveform='sinus', frequency=140, length=1})
  --   love.audio.play(sine)
  --   love.timer.sleep(1)
  --   local sine = denver.get({waveform='sinus', frequency=240, length=1})
  --   love.audio.play(sine)
  --   love.timer.sleep(1)
  --   local sine = denver.get({waveform='sinus', frequency=940, length=1})
  --   love.audio.play(sine)
  -- end

  local sine = denver.get({waveform='sinus', frequency=740, length=1})
  love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=840, length=1})
  -- love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=840, length=1})
  -- love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=890, length=1})
  -- love.audio.play(sine)
    love.timer.sleep(1)
  local sine = denver.get({waveform='sinus', frequency=340, length=0.25})
  love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=540, length=0.25})
  -- love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=840, length=0.25})
  -- love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=990, length=0.25})
  -- love.audio.play(sine)
  -- local sine = denver.get({waveform='sinus', frequency=190, length=0.25})
  -- love.audio.play(sine)

  -- for i=7,1,-1 do print(i)
  --   love.timer.sleep(1)
  --   local sine = denver.get({waveform='sinus', frequency=70*i, length=2})
  --   local saw  = denver.get({waveform='sawtooth', frequency=700*i, length=2})
  --   local saw  = denver.get({waveform='sawtooth', frequency=70*i, length=2})
  --   local saw2  = denver.get({waveform='sawtooth', frequency=50*i, length=2})
  --   local saw3  = denver.get({waveform='sawtooth', frequency=30*i, length=2})
  --   love.audio.play(sine)
  --   love.audio.play(saw)
  --   love.audio.play(saw2)
  --   love.audio.play(saw3)
  --   local sine = denver.get({waveform='sinus', frequency=340, length=0.15})
  --   love.audio.play(sine)
  --   love.timer.sleep(0.1)
  --   local sine = denver.get({waveform='sinus', frequency=540, length=0.35})
  --   love.audio.play(sine)
  --   love.timer.sleep(0.2)
  --   local sine = denver.get({waveform='sinus', frequency=840, length=0.45})
  --   love.audio.play(sine)
  --   love.timer.sleep(0.3)
  --   local sine = denver.get({waveform='sinus', frequency=990, length=0.15})
  --   love.audio.play(sine)
  --   love.timer.sleep(0.5)
  --   local sine = denver.get({waveform='sinus', frequency=190, length=0.15})
  --   love.audio.play(sine)
  --   love.timer.sleep(0.3)
  --   local sine = denver.get({waveform='sinus', frequency=1290, length=0.05})
  --   love.audio.play(sine)
  -- end

  -- play a sinus of 1sec at 440Hz
  local sine = denver.get({waveform='sinus', frequency=440, length=1})
  love.audio.play(sine)

  -- play a F#2 (available os)
  --low base note
  local square = denver.get({waveform='square', frequency='F#2', length=1})
  love.audio.play(square)

  -- to loop the wave, don't specify a length (generates one period-sample)
  -- local saw = denver.get({waveform='sawtooth', frequency=440})
  -- saw:setLooping(true)
  -- love.audio.play(saw)

  -- play noise
  -- local noise = denver.get({waveform='whitenoise', length=6})
  -- love.audio.play(noise)
end

function Synth:keypressed(key, code)
  if key == ('space' or 'return') then self:pushState('menu') end
  if key == ('2' or 'b') then self:pushState('bizzaro') end
  if key == ('escape') then self:popState() end
  if key == ('q') then love.event.push('quit') end
end