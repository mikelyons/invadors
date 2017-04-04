require 'camera'
--Gamestate = require "lib.gamestate"
-- Camera = require "hump.camera"

local menu = {}
local game = {}

function menu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
  if key == 'return' then
    Gamestate.switch(game)
  end
end

function game:enter()
    --Entities.clear()
    -- setup entities here
end

function game:update(dt)
    --Entities.update(dt)
end

function game:draw()
    --Entities.draw()
end


function love.load()



  --Gamestate.registerEvents()
  --Gamestate.switch(menu)
  --@TODO: divide out the menu state and the game state
  --       so that you can press a key to start the game
  ---------and it runs the game part
  --http://hump.readthedocs.io/en/latest/gamestate.html#function-reference

  player = {}
  player.x = 10
  player.y = 10
  player.image = love.graphics.newImage('/assets/ufo2.png')
  player.image:setFilter('nearest', 'nearest', 1)

  background = love.graphics.newImage('/assets/galaxy.png')
  background:setFilter('nearest', 'nearest', 1)
  background:setWrap("repeat", "repeat")

  bg_quad = love.graphics.newQuad(0, 0, 10000, 10000, background:getWidth(), background:getHeight())

  -- camera = Camera(player.x, player.y, 2)


end

function love.update()

  if love.keyboard.isDown("right") then
    player.x = player.x + 10
  elseif love.keyboard.isDown("left") then
    player.x = player.x - 10
  end

  if love.keyboard.isDown("up") then
    player.y = player.y - 10
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 10
  end

  if player.x > love.graphics.getWidth() / 4 then
    camera.x = player.x - love.graphics.getWidth() / 4 
  end
  if player.y > love.graphics.getWidth() / 4 then
    camera.y = player.y - love.graphics.getWidth() / 4 
  end
  if player.x < 10 then
    camera.x = player.x - 10
  end
  if player.y < 10 then
    camera.y = player.y - 10
  end

  -- local dx,dy = player.x - camera.x, player.y - camera.y
  -- camera:move(dx/2, dy/2)
end

function love.draw()

  camera:set()
  -- love.graphics.draw(background,0,0)
  love.graphics.draw(background, bg_quad, 0, 0)
  love.graphics.print(string.format("%s, %s", player.x, player.y), player.x, player.y)
  -- love.graphics.rectangle('fill', x, y, 100, 100)
  love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)
  --love.graphics.newImage('ufo.png')
  love.graphics.setColor(255,255,255)

  camera:unset()
end