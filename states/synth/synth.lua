-- require '../../lib/denver'

local Synth = Game:addState('synth')

local denver = require '../../lib/denver'

local FX = require('states/synth/effects')

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

  -- FX.loop1()
  -- FX.loop2()
  -- FX.loop3()
  -- FX.loop4()
  FX.loop5()




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
    local space = denver.get({waveform='sinus',frequency=440, length=0.1})
    love.audio.play(space)
  end

  print('=== NOISE 1 === ')
  if key == ('2' or 'b') then self:pushState('bizzaro') end
  -- if key == ('escape') then self:popState() end
  if key == ('escape') then love.event.push('quit') end
  if key == ('q') then love.event.push('quit') end
end