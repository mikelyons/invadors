
require 'love.timer'

function noise(denver, waveform)
  -- local sine = denver.get({waveform='sinus', frequency=740, length=1})
  -- love.audio.play(sine)

  love.audio.setVolume(0.5)
  -- local noise = denver.get({waveform='whitenoise', frequency=740, length=1})
  local noise = denver.get({waveform=waveform, frequency=1})
  noise:setLooping(true)
  love.audio.play(noise)
  -- love.timer.sleep(1)
  -- love.audio.play(noise)

  -- local noise = denver.get('whitenoise', 6) -- 6sec of white noise (you can also use pinknoise and brownnoise)
  -- noise:setLooping(true)
  -- love.audio.play(noise)
end

return noise