
-- print(love.window.getMode()) -- is this useful? no?
-- make the console work
-- io.stdout:setvbuf("no")

-- Libraries
-- based on http://aalvarez.me/blog/posts/an-introduction-to-game-states-in-love2d.html
Class          = require 'lib/middleclass/middleclass'
Stateful       = require 'lib/stateful/stateful'

-- ProFi = require 'lib/ProFi'
-- ProFi:start()

Score          = require 'highscore'
-- The Main Game Launch Point
require 'game'
local game

g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()
g_GameTime = 0
g_TileSize = 32
g_MapSize  = 16

local ser = require 'lib/binser/binser'
local save
local saveString


function love.load()
  if love.filesystem.exists( 'Save.lua' ) then
      save = love.filesystem.load( 'Save.lua' )
      saveString = love.filesystem.load( 'Save.lua' )

      -- print("mainlua:31")
      -- print(saveString())
  else
      save = {
      saves = 0
      } -- Put settings in here.
  end
  -- print(save.saves)
  -- save.saves = (save.saves + 1) or 0
  game = Game:new()
  score = Score:new()
  score:load()

  gameloop:addLoop(self)
  love.timer.step() -- fix for load delay: https://love2d.org/forums/viewtopic.php?t=8589
end

local delta_time = {}
local av_dt      = 0.016
local sample     = 10
local pop, push = table.remove, table.insert

function love.update(dt)
  score:update()

  push(delta_time,dt)
  if #delta_time > sample then
    local av  = 0
    local num   = #delta_time for i = #delta_time,1,-1 do
      av = av + delta_time[i]
      pop(delta_time,delta_time[i])
    end

    av_dt = av / num
  end


  -- gameloop:update(av_dt)
  game:update(av_dt)


  g_GameTime = g_GameTime + av_dt
end

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
  -- love.filesystem.write('save.lua', saveString())
  score:quit()

  -- ProFi:stop()
  -- ProFi:writeReport( 'MyProfilingReport.txt')
end