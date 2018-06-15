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
-- Class          = require 'lib/hump/class'
-- Gamestate      = require 'lib/hump/gamestate'
-- based on http://aalvarez.me/blog/posts/an-introduction-to-game-states-in-love2d.html
Class          = require 'lib/middleclass/middleclass'
Stateful       = require 'lib/stateful/stateful'

-- The Main Game Launch Point
require 'game'
local game

-- BASED ON: https://www.youtube.com/watch?v=UFE94uJodVs&list=PLKpDO_ZkjZ7TBYWcV2n632Z6iRJJlX2oM&index=2
Renderer       = require "tools/renderer"
GameLoop       = require "tools/gameloop"
-- beeper         = require "tools/beeper"
-- local Vec2     = require "tools/vec2"

local rect     = require "objects/rect"   -- base class
local entity   = require "objects/entity" -- inherits from rect
tlm      = require 'tiles/tlm' -- this module is unfinished
obm            = require 'tools/obm' -- opion manager
asm            = require 'tools/asm' -- asset manager

renderer = Renderer:create()
gameloop = GameLoop:create()

g_Width  = love.graphics.getWidth()
g_Height = love.graphics.getHeight()
g_GameTime = 0

-- local obj
local ent = entity:new(32, 32, 64, 64, "player")

function ent:load()
  gameloop:addLoop(self)
end
function ent:tick()
  print(self.id)
end

function love.load()
  game = Game:new()

  gameloop:addLoop(self)
  -- asm:load()
  -- asm:add()
  obm:load()

  -- obm:add(require('objects/player'):new(128,64))

  -- ent:load()

  -- obj = rect:new(128,32,64,64)


  -- local randBox = createBox()
  -- randBox:load()

end


function love.update(dt)
  if _debug == true then
    lovebird.update()
  end

  -- GAMETIME = GAMETIME + dt
  -- g_GameTime = g_GameTime + dt

  gameloop:update(dt)

  game:update(dt)
end

function love.draw(dt)

  -- love.graphics.rectangle("line", obj.pos.x, obj.pos.y, obj.size.x, obj.size.y)
  game:draw()
  renderer:draw()
end

function love.keypressed(key)
  game:keypressed(key, code)
end

function love.mousepressed(x, y, button, istouch)
  game:mousepressed(x, y, button, istouch)
end