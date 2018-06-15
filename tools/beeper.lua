-- function Oscillator(rate, freq)
--   local phase = 0
--   return function()
--     phase = phase + 2*math.pi/rate
--     if phase >= 2*math.pi then
--       phase = phase - 2*math.pi
--     end
--     local x = math.sin(freq * phase)
--     if x < 0 then return -1 else return 1 end
--   end
-- end

-- len = 0.5
-- rate = 44100
-- bits = 16
-- channel = 1

-- tone = {}
-- tone["z"] = 130.81
-- tone["s"] = 138.59
-- tone["x"] = 146.83
-- tone["d"] = 155.56
-- tone["c"] = 164.81
-- tone["v"] = 174.61
-- tone["g"] = 185.00
-- tone["b"] = 196.00
-- tone["h"] = 207.65
-- tone["n"] = 220.00
-- tone["j"] = 233.08
-- tone["m"] = 246.94
-- tone["q"] = 261.63
-- tone["2"] = 277.18
-- tone["w"] = 293.66
-- tone["3"] = 311.13
-- tone["e"] = 329.63
-- tone["r"] = 349.23
-- tone["5"] = 369.99
-- tone["t"] = 392.00
-- tone["6"] = 415.30
-- tone["y"] = 440.00
-- tone["7"] = 466.16
-- tone["u"] = 493.88
-- tone["i"] = 523.25
-- tone["9"] = 554.37
-- tone["o"] = 587.33
-- tone["0"] = 622.25
-- tone["p"] = 659.26

-- function playtone(freq)
--   if source then source:stop() end

--   soundData = love.sound.newSoundData(len*rate,rate,bits,channel)

--   local osc = Oscillator(rate, freq)
--   local amplitude = 0.08
--   local N = len * rate
--   local K = math.floor(N * 0.85)
--   for i = 1, K do
--     sample = osc() * amplitude
--     soundData:setSample(i, sample)
--   end
--   for i = K, N do
--     sample = osc() * amplitude * 0.25
--     soundData:setSample(i, sample)
--   end

--   source = love.audio.newSource(soundData)
--   love.audio.play(source)
-- end

-- function love.keypressed( k )
--   local freq = tone[tostring(k)]
--   if freq then playtone(freq) end
-- end

-- function love.update(dt)
--   if source and source:isStopped() then source = nil end
-- end

-- function love.draw()
--   love.graphics.print( string.format("%ik", collectgarbage("count")), 4, 4 )
-- end

-- local beeper = {}

-- function Oscillator(freq)
--     local phase = 0
--     return function()
--         phase = phase + 2*math.pi/rate            
--         if phase >= 2*math.pi then
--             phase = phase - 2*math.pi
--         end
--         return math.sin(freq*phase)
--     end
-- end


-- function love.load()
--     len = 2
--     rate = 44100
--     bits = 16
--     channel = 1

--     soundData = love.sound.newSoundData(len*rate,rate,bits,channel)

--     osc = Oscillator(440)
--     amplitude = 0.2

--     for i=0,len*rate-1 do
--         sample = osc() * amplitude
--         soundData:setSample(i, sample)
--     end

--     source = love.audio.newSource(soundData)
--     love.audio.play(source)
-- end


-- -- this is the working one!
-- local denver = require 'tools/denver'

-- -- play a sinus of 1sec at 440Hz
-- local sine = denver.get({waveform='sinus', frequency=440, length=1})
-- love.audio.play(sine)

-- -- play a F#2 (available os)
-- local square = denver.get({waveform='square', frequency='F#2', length=1})
-- love.audio.play(square)

-- -- to loop the wave, don't specify a length (generates one period-sample)
-- local saw = denver.get({waveform='sawtooth', frequency=440})
-- saw:setLooping(true)
-- love.audio.play(saw)

-- -- play noise
-- local noise = denver.get({waveform='whitenoise', length=6})
-- love.audio.play(noise)
