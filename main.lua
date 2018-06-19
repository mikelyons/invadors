-- @TODO : separate dev libs
local _debug = false
if _debug == true then
  lovebird = require "lib/lovebird/lovebird"
  lovebird.allowhtml = true
end

-- print(love.window.getMode()) -- is this useful? no?
-- make the console work
-- io.stdout:setvbuf("no")

-- Libraries
-- based on http://aalvarez.me/blog/posts/an-introduction-to-game-states-in-love2d.html
Class          = require 'lib/middleclass/middleclass'
Stateful       = require 'lib/stateful/stateful'

-- The Main Game Launch Point
require 'game'
local game

-- BASED ON: https://www.youtube.com/watch?v=UFE94uJodVs&list=PLKpDO_ZkjZ7TBYWcV2n632Z6iRJJlX2oM&index=2
Renderer = require "tools/renderer"
GameLoop = require "tools/gameloop"
renderer = Renderer:create()
gameloop = GameLoop:create()

-- beeper         = require "tools/beeper"

local rect     = require "objects/rect"   -- base class
local entity   = require "objects/entity" -- inherits from rect

g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()
g_GameTime = 0


function love.load()
  game = Game:new()

  gameloop:addLoop(self)
  love.timer.step() -- fix for load delay: https://love2d.org/forums/viewtopic.php?t=8589
end

function love.update(dt)
  if _debug == true then
    lovebird.update()
  end

  gameloop:update(dt)
  game:update(dt)
end

function love.draw(dt)
  camera:set()
    renderer:draw()
  -- camera:set()
  --   --wrapping these in camera set/unset allows camera to follow player but its weird
  -- camera:unset()
    game:draw()
  camera:unset()
end

function love.keypressed(key)
  game:keypressed(key, code)
end
function love.mousepressed(x, y, button, istouch)
  game:mousepressed(x, y, button, istouch)
end
function love.mousereleased(x, y, button)
  game:mousereleased(x, y, button)
end
