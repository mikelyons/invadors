--@TODO - make multiple logos possible

local Splash = Game:addState('Splash')


local function drawSplash()
  love.graphics.setBackgroundColor(0, 0, 0, 255)--BG_COLOR)
  love.graphics.setColor(255, 255, 255, fade_timer*(255/fade_time))
  love.graphics.draw(hamster, 50, 50, 0, .35, .35)

end


function Splash:enteredState()
  print('ENTER Splash STATE')
  renderer:addRenderer(self, 1)
  -- if you just want to wait and no fade
  -- waiting = true
  -- waitingtimer = 0

  fade_time = 1
  fade_timer = 1

  -- the logo for the splash 
  hamster = love.graphics.newImage("assets/images/Doom_1.png")

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
end

function Splash:keypressed(key, code)
  if key == ('space' or 'return') then self:pushState('Menu') end
  if key == ('q') then love.event.push('quit') end
end