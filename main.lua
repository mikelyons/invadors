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

  -- effect = love.graphics.newShader(love.filesystem.read("shader.fs"))

--   myShader = love.graphics.newShader[[
--     vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
--   ]]

  --   local pixelcode = [[
  --     vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
  --     {
  --       vec4 texcolor = Texel(texture, texture_coords);
  --       return texcolor * color;
  --     }
  --   ]]
 
  --   local vertexcode = [[
  --     vec4 position( mat4 transform_projection, vec4 vertex_position )
  --     {
  --       return transform_projection * vertex_position;
  --     }
  --   ]]
 
  -- -- shader = love.graphics.newShader(shader3.fs)
  -- shader = love.graphics.newShader(love.filesystem.read("shader.fs"))

  -- myShader = love.graphics.newShader[[
  --   extern number factor = 0;
  --   vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  --     vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color 
              
  --     number average = (pixel.r+pixel.b+pixel.g)/3.0;

  --     pixel.r = pixel.r + (average-pixel.r) * factor;
  --     pixel.g = pixel.g + (average-pixel.g) * factor;
  --     pixel.b = pixel.b + (average-pixel.b) * factor; 


  --     return pixel; 
  --   }
  -- ]]
  myShader = love.graphics.newShader[[vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    return vec4(1.0,0.0,0.0,1.0);
  }]]
  time = 0;


end

function love.update(dt)

  time = time + dt;
  local factor = math.abs(math.cos(time)); --so it keeps going/repeating
  -- myShader:send("factor",factor)
  -- myShader:send('factor', 800)


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
  love.graphics.draw(background, bg_quad, 0, 0)
  love.graphics.print(string.format("%s, %s", player.x, player.y), player.x, player.y)
  love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)
  love.graphics.setColor(255,255,255);

  -- shader:send('screenWidth', love.window.getWidth())

  -- love.graphics.setShader(shader)
  love.graphics.setShader(myShader)
  --
    love.graphics.rectangle("fill", 300, 300, 60, 60)
    love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)


  love.graphics.setShader()


  camera:unset()
end