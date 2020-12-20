--@TODO - make multiple logos possible

local Splash = Game:addState('Splash')

local function drawSplash()
  love.graphics.setBackgroundColor(0, 0, 0, 255)--BG_COLOR)
  love.graphics.setColor(255, 255, 255, fade_timer*(255/fade_time))
  love.graphics.draw(hamster, 50, 50, 0, .35, .35)
end

-- master switch variable turns off splash screen delay
-- local nosplash = true
local nosplash = false

function Splash:enteredState()
  if DEBUG_NOSPLASH then
    self:gotoState('Menu')
  else
    if DEBUG_LOGGING_ON then
      print(string.format("ENTER Splash STATE - %s \n", os.date()))
    end

    -- fanfare for splash logo
    music = love.audio.newSource("assets/sounds/Capcom_Intro_Sound_Effect.mp3", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
    music:play()

    renderer:addRenderer(self, 1)
    -- if you just want to wait and no fade
    -- waiting = true
    -- waitingtimer = 0
    fade_time = 1
    fade_timer = 1

    -- the logo for the splash 
    hamster = asm:get('hamster') 
  end
end

function Splash:update(dt)
  -- from:https://love2d.org/forums/viewtopic.php?t=33291
  if fade_timer > 0 then fade_timer = fade_timer - dt end
  if fade_timer < .3 then
    self:gotoState('Menu')
  end

  -- if you just want to wait and no fade
  -- waitingtimer = waitingtimer + dt
  -- if waitingtimer > 1 then
  --      waiting = false
  --      self:gotoState('Menu')
  -- end
end

function Splash:draw()
  drawSplash()
end

function Splash:exitedState()
  -- if we skip the splash, stop the fanfare
  music:stop()
end

function Splash:keypressed(key, code)
  if key == ('space' or 'return') then self:pushState('Menu') end
  if key == ('q') then love.event.push('quit') end
end