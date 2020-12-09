require 'src/dependencies'

local game

-- @TODO - move these to src/constants.lua
g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()
g_GameTime = 0
g_TileSize = 32
g_MapSize  = 16

function love.load()
  -- @TODO need to make world state save and load

  -- The initialization of the main game launch point with splash and menu maby?
  game = Game:new()

  -- initialize score tracking
  score = Score:new()
  -- load the score file and read last launch date
  score:load()

  -- find out what this does
  gameloop:addLoop(self)

  love.timer.step() -- fix for load delay: https://love2d.org/forums/viewtopic.php?t=8589
end

-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
local delta_time = {}
local av_dt      = 0.016
local sample     = 10
local pop, push = table.remove, table.insert
function love.update(dt)
  -- score:update() -- why were we updating this here?

  -- what is push?
  push(delta_time,dt)
  if #delta_time > sample then
    local av  = 0
    local num   = #delta_time for i = #delta_time,1,-1 do
      av = av + delta_time[i]
      pop(delta_time,delta_time[i])
    end

    av_dt = av / num
  end

  -- gameloop:update(av_dt) -- why isn't this happening?
  game:update(av_dt)

  g_GameTime = g_GameTime + av_dt
end

-- @todo figure out renerer layers
function love.draw(dt)
  -- game camera
  camera:set()
  --   --wrapping these in camera set/unset allows camera to follow player but its weird
    renderer:draw()
  -- camera:unset()
  -- camera:set()
    game:draw()
  camera:unset()
  score:draw()
  collectgarbage()
end

function love.keypressed(key)
  game:keypressed(key, code)
  if key == '=' then score:add(100) end --then love.event.push('quit') end
end
function love.mousepressed(x, y, button, istouch)
  game:mousepressed(x, y, button, istouch)
end
function love.mousereleased(x, y, button)
  game:mousereleased(x, y, button)
end

function love.quit()
  score:quit()
end
