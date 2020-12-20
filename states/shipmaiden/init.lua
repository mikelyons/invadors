local maid64 = require 'lib.maid64.maid64'

require 'synth'

require 'camera'
--Gamestate = require "lib.gamestate"
-- Camera = require "hump.camera"

local menu = {}
local game = {}
local shine = require 'shine'

text = ""

function love.wheelmoved(x, y)
    if y > 0 then
        text = "Mouse wheel moved up"
        -- scale = -0.001 --scale - 0.0002
        camera:scale(0.95)
    elseif y < 0 then
        text = "Mouse wheel moved down"
        -- scale = 0.001 --scale + 0.0002
        camera:scale(1.05)
    end
end

function maid64_draw()
  
end


function love.load()

  -- optional settings for the window - emulates fullscreen
  love.window.setMode(1280, 800, {resizable=true, vsync=false, minwidth=200, minheight=200})

  -- maid64(64)
  -- maid64.setup(1280, 800)
  maid64.setup(1280, 800)



  -- create test sprite - maidenhead
  maid = maid64.newImage("/assets/maid64.png")
  maid:setFilter("nearest","nearest")
  rotate = 0

  -- Cat Head
  cathead = maid64.newImage("/assets/images/cathead.png")
  cathead:setFilter("nearest","nearest")

  -- Cat Head white
  catheadwhite = maid64.newImage("/assets/images/cat-head-white.png")
  catheadwhite:setFilter("nearest","nearest")


  pixelfont = love.graphics.newImageFont("/assets/images/lowfontA.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")


  -- The initialization of the main game launch point with splash and menu maby?
  game = Game:new()

  --Gamestate.registerEvents()
  --Gamestate.switch(menu)
  --@TODO: divide out the menu state and the game state
  --       so that you can press a key to start the game
  ---------and it runs the game part
  --http://hump.readthedocs.io/en/latest/gamestate.html#function-reference

  player = {}
  player.x = 1908--(love.graphics.getWidth() / 2)
  player.y = 528--(love.graphics.getHeight() / 2)

  player.image = love.graphics.newImage('/assets/ufo2.png')
  player.image:setFilter('nearest', 'nearest', 1)

  ship2 = {}
  ship2.image = love.graphics.newImage('/assets/images/ship2.png')
  ship2.image:setFilter('nearest', 'nearest', 1)
  ship2.x = 2000
  ship2.y = 1.1000

  ship3 = {}
  ship3.image = love.graphics.newImage('/assets/images/skullface.jpg')
  ship3.image:setFilter('nearest', 'nearest', 1)
  ship3.x = 2000
  ship3.y = 1.1000

  background = love.graphics.newImage('/assets/galaxy.png')
  background:setFilter('nearest', 'nearest', 1)
  background:setWrap("mirroredrepeat", "mirroredrepeat")
  -- background:setWrap("clamp", "clamp")

  bg_quad = love.graphics.newQuad(0, 0, 1800, 1800, background:getWidth(), background:getHeight())


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

  -- TODO https://love2d.org/wiki/Shader_Variables
  -- TODO https://love2d.org/wiki/Shader
  -- share a shader https://love2d.org/forums/viewtopic.php?f=4&t=3733
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

  -- SHINE effects: https://github.com/vrld/shine/wiki
  -- load the effects you want
    local grain = shine.filmgrain()
    -- many effects can be parametrized
    grain.opacity = 0.2
    -- multiple parameters can be set at once
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.7}
    -- you can also provide parameters on effect construction
    local desaturate = shine.desaturate{strength = 0.6, tint = {255,250,200}}
    -- you can chain multiple effects
    post_effect = desaturate:chain(grain):chain(vignette)
    -- warning - setting parameters affects all chained effects:
    post_effect.opacity = 0.5 -- affects both vignette and film grain

    local blur = shine.gaussianblur()
    blur.sigma = 10

    -- you can chain multiple effects
    background_effect = blur

  myShader = love.graphics.newShader[[vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    if(screen_coords.x > 400) {
      return vec4(1.0,0.0,0.0,1.0);
    }
    else
    {
      return vec4(0.0,1.0,0.0,1.0);
    }
  }]]
  time = 0;

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
  rotate = rotate + dt


  -- require("lib/lovebird").update() - browser based debug console - is this useful?

  -- TODO: add two handed controlls for speed or arm movement
  if love.keyboard.isDown("right") then
    player.x = player.x + 40
  elseif love.keyboard.isDown("left") then
    player.x = player.x - 40
  end

  if love.keyboard.isDown("up") then
    player.y = player.y - 40
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 40
  end

  if love.keyboard.isDown("d") then
    player.x = player.x + 8
  elseif love.keyboard.isDown("a") then
    player.x = player.x - 8
  end

  if love.keyboard.isDown("w") then
    player.y = player.y - 8
  elseif love.keyboard.isDown("s") then
    player.y = player.y + 8
  end

  -- if player.x > (love.graphics.getWidth() / 4)*3 then
  --   camera.x = player.x - (love.graphics.getWidth()-40 / 4)*3
  -- end

  camera.x = player.x - ((love.graphics.getWidth() / 2) - (player.image:getWidth()/2))

  camera.y = player.y - ((love.graphics.getHeight() / 2) - (player.image:getHeight()/2))

  -- if text == ""
  -- camera:scale(1.002,1.002)




  -- if player.y > love.graphics.getWidth() / 4 then
  --   camera.y = player.y - love.graphics.getWidth() / 4 
  -- end
  -- if player.y < 10 then
  --   camera.y = player.y - 10
  -- end

  -- local dx,dy = player.x - camera.x, player.y - camera.y
  -- camera:move(dx/2, dy/2)
end

background = love.graphics.newImage("assets/galaxy.png")
local function drawBackground()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
end
-- @todo figure out renerer layers
function love.draw(dt)
  drawBackground()
  -- game camera
  camera:set()
  --   --wrapping these in camera set/unset allows camera to follow player but its weird
    renderer:draw()
  -- camera:unset()
  -- camera:set()
    -- game:draw()



  background_effect.sigma = math.abs(math.cos(player.x + player.y)) * 5;

  -- background_effect:draw(function()
    love.graphics.draw(background, bg_quad, 0, 0)
    -- love.graphics.print(string.format("%s, %s", player.x, player.y), player.x, player.y)
  -- end)

  --skullface
  love.graphics.draw(ship3.image, ship3.x, ship3.y, 0, 20, 20)
  love.graphics.draw(ship2.image, ship2.x, ship2.y, 0, 4, 4)

  love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)
  love.graphics.setColor(255,255,255);

  -- shader:send('screenWidth', love.window.getWidth())

-- wrap what you want to be post-processed in a function:
    -- post_effect:draw(function()
    --   love.graphics.rectangle("fill", 300, 300, 60, 60)
    --   love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)
    -- end)
    
    -- alternative syntax:
    -- post_effect(function()
    --     draw()
    --     my()
    --     stuff()
    -- end)
    
    -- everything you draw here will not be affected by the effect
  -- love.graphics.setShader(shader)
  -- love.graphics.setShader(myShader)
  --
    -- love.graphics.rectangle("fill", 300, 300, 60, 60)
    -- love.graphics.draw(player.image, player.x, player.y, 0, 4, 4)

  -- draws the static positioned HUD text
  -- score:draw()

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



  -- Mouse Wheel test
  love.graphics.print(text, 10, 10)
  -- Mouse Wheel test

  love.graphics.print(string.format( "%s, %s", love.getVersion() ), 20,20)
  local x, y, display = love.window.getPosition( )
  love.graphics.print(string.format( "%s, %s", x, y), 20, 40)
  love.graphics.print(string.format( "%s, %s", camera.x, camera.y), (camera.x +20), (camera.y + 20))

  -- render outside the camera to get UI effect
  camera:unset()

  maid64.start()
    love.graphics.draw(maid,92,32,rotate,1,1,38,38)
    love.graphics.draw(cathead,390,390,rotate,0.15,0.15,200,200)
    love.graphics.draw(catheadwhite,300,300,rotate*2,0.15,0.15,32,32)
  maid64.finish()

  -- render outside the camera to get UI effect
  -- camera:unset()


end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
end

function love.resize(w, h)
    -- this is used to resize the screen correctly
    maid64.resize(w, h)
end

