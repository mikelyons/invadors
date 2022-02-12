require 'love.timer'

function whitenoise(denver)
  -- local sine = denver.get({waveform='sinus', frequency=740, length=1})
  -- love.audio.play(sine)

  love.audio.setVolume(0.1)
  -- local noise = denver.get({waveform='whitenoise', frequency=740, length=1})
  local noise = denver.get({waveform='whitenoise', frequency=0})
  -- noise:setLooping(true)
  love.audio.play(noise)
  love.timer.sleep(1)
  love.audio.play(noise)

  -- local noise = denver.get('whitenoise', 6) -- 6sec of white noise (you can also use pinknoise and brownnoise)
  -- noise:setLooping(true)
  -- love.audio.play(noise)
end

return whitenoise