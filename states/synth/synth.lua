-- require '../../lib/denver'

local Synth = Game:addState('synth')

local denver = require '../../lib/denver'


sheet = {'B4', 'E5'}
sheet2 = {
  'B4', 'E5',
}
sheet3 = {
  'B4',
  'E5',
}

-- image version of this
-- https://www.reddit.com/r/gamedev/comments/7ylvt9/pixelator_a_gamedev_tool_i_wrote_to_convert_any/
function Synth:enteredState()
  print('=== SET VOLUME ===')
  love.audio.setVolume(0.5)


  print('=== first loop ===')
  for i=4,1,-1 do print(i)
    print('=== '..i..' loop ===')
    local sine = denver.get({waveform='sinus', frequency=540, length=0.1})
    love.audio.play(sine)
    love.timer.sleep(0.1)
    local sine = denver.get({waveform='sinus', frequency=040, length=0.1})
    love.audio.play(sine)
    love.timer.sleep(0.1)
    local sine = denver.get({waveform='sinus', frequency=140, length=0.1})
    love.audio.play(sine)
    love.timer.sleep(0.1)
    local sine = denver.get({waveform='sinus', frequency=240, length=0.1})
    love.audio.play(sine)
    love.timer.sleep(0.1)
    local sine = denver.get({waveform='sinus', frequency=940, length=0.1})
    love.audio.play(sine)
  end
  print('=== END LOOP 1 == ')

  print('=== SOME SHIT === ')
  local sine = denver.get({waveform='sinus', frequency=740, length=0.1})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=840, length=0.1})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=840, length=0.1})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=890, length=0.1})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=340, length=0.25})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=540, length=0.25})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=840, length=0.25})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=990, length=0.25})
  love.audio.play(sine)
    love.timer.sleep(0.1)
  local sine = denver.get({waveform='sinus', frequency=190, length=0.25})
  love.audio.play(sine)
    love.timer.sleep(0.1)

  print('=== LOOP 2 === ')
  -- for i=7,1,-1 do print(i)
  --   print('=== LOOP 2 AGAIN === ')
  --   love.timer.sleep(0.1)
  --   local sine = denver.get({waveform='sinus', frequency=70*i, length=0.2})
  --   local saw  = denver.get({waveform='sawtooth', frequency=700*i, length=0.2})
  --   local saw  = denver.get({waveform='sawtooth', frequency=70*i, length=0.2})
  --   local saw2  = denver.get({waveform='sawtooth', frequency=50*i, length=0.2})
  --   local saw3  = denver.get({waveform='sawtooth', frequency=30*i, length=0.2})
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
  print('=== SINUS 1 === ')
  local sine = denver.get({waveform='sinus', frequency=440, length=0.1})
  love.audio.play(sine)

  -- play a F#2 (available os)
  --low base note
  print('=== Square 1 === ')
  local square = denver.get({waveform='square', frequency='F#2', length=0.1})
  love.audio.play(square)

  -- to loop the wave, don't specify a length (generates one period-sample)
  print('=== SAW 1 === ')
  -- local saw = denver.get({waveform='sawtooth', frequency=440})
  -- saw:setLooping(true)
  -- love.audio.play(saw)

  -- play noise
  print('=== NOISE 1 === ')
  -- local noise = denver.get({waveform='whitenoise', length=1})
  -- love.audio.play(noise)
  -- local noise = denver.get({waveform='sinus',frequency=140, length=2})
  -- --low background like: https://www.youtube.com/watch?v=THM4fUdz8Mc
  -- love.audio.play(noise)
end

local notes = {}
notes.a4 = 440
notes.a4 = 440

function Synth:keypressed(key, code)
  -- if key == ('space' or 'return') then self:pushState('menu') end

  if key == ('space' or 'return') then
    local space = denver.get({waveform='sinus',frequency=440, length=1})
    love.audio.play(space)
  end

  print('=== NOISE 1 === ')
  if key == ('2' or 'b') then self:pushState('bizzaro') end
  if key == ('escape') then self:popState() end
  if key == ('q') then love.event.push('quit') end
end