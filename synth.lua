-- local samples = math.floor(.2 * 44100)  --.2 seconds long
-- local data = love.sound.newSoundData(samples, 44100, 16, 1)
-- for i = 0,samples do 
--   data:setSample(i, .2)--(math.random()*2-1)*(1-i/samples)) 
-- end
-- staticBurst = love.audio.newSource(data)

local samples = 100000
local data = love.sound.newSoundData(samples)
local noteChange = 10000
local note = 200
local change = 50
local minimum = 100

for i = 0, samples * 2 - 1 do
  if i % noteChange == 0 then
    local factor = -2 + math.random(0, 4)
    if note <= minimum then factor = 1 end
    note = note + change * factor
  end
  
  data:setSample(i, math.sin(i % note / note / (math.pi * 2)))
end