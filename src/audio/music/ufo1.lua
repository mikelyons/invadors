require 'love.timer'

function songUfo(denver)
  local sine = denver.get({waveform='sinus', frequency=740, length=1})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=840, length=1})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=840, length=1})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=890, length=1})
  love.audio.play(sine)

    love.timer.sleep(1)

  local sine = denver.get({waveform='sinus', frequency=340, length=0.25})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=540, length=0.25})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=840, length=0.25})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=990, length=0.25})
  love.audio.play(sine)
  local sine = denver.get({waveform='sinus', frequency=190, length=0.25})
  love.audio.play(sine)
end

return songUfo