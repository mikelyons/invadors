--[[
  main.lua

  The bootstrap loader file
  MASTER CONTROL PROGRAM
  @TODO use this - https://github.com/rxi/lovebird

  Boot Order:
  conf.lua
  |_ main.lua
    |_ src/dependencies.lua
      |_ colors.lua
      |_ src/constants.lua
      |_ src/logging.lua
    |_ game.lua
      |_ splash.lua
      |_ menu.lua
  https://popey.com/blog/2023/10/game-development-in-github-codespaces/
]]

if DEBUG_LOGGING_LOADING then
  print(' ')
  print('main.lua ->')
  print(' ')
end

-- not working on mac
-- this is from: https://sheepolution.com/learn/book/bonus/vscode
if arg[2] == "debug" then
  require("lldebugger").start()
end

require 'src/core/dependencies'

if not PrintColor('Color Available', 'green') then print('color not available') end

-- Load centralized version management
local Version = require('src/core/version')

-- this does not get added to the Game table below
local game = {
  _VERSION     = 'Invadors v' .. Version.GAME_VERSION,
  _DESCRIPTION = 'Invadors Game',
  _URL         = 'https://github.com/mikelyons/invadors',
  _LICENSE     = [[

  /*******************************************************
  * Copyright (C) 2015-2022 {Mike Lyons} <{lyons.mr@gmail.com}> - All Rights Reserved
  * 
  * ALL RIGHTS RESERVED
  * This file is part of {invadors}.
  * 
  * {invadors} can not be copied and/or distributed without the express
  * written permission of {Mike Lyons}
  * Unauthorized copying of this file, via any medium is strictly prohibited
  * Proprietary and confidential
  *******************************************************/


  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}
PrintColor(game._LICENSE, 'yellow')


function love.load(...)
  -- score = Score:new()
  -- score:load()
  -- print(arg[0])
  -- print("love.load("..arg[1]..")")
  -- print(arg[2])
  -- PrintTable(arg)

    -- t="rainty2"
    -- PrintDebug(t)


  -- PrintTable(debug.getinfo(1))
  -- PrintDebug()

  screen_height = 900
  screen_width = 1340
  -- required to make window resizable -- @TODO do we want this?
  love.window.setMode(screen_width, screen_height, {
    resizable=true,
    vsync=false,
    minwidth=400,
    minheight=300
  })
  -- display on monitor 2 -- also fixes the problem with rendering in generate gamestate (4.7.3)
  -- local width, height = love.window.getDesktopDimensions(2) -- Get the dimensions of the second monitor
  -- love.window.setMode(800, 600,
  --   {x = width - 820, y = 0 - 620}
  -- )  -- Adjust the x and y positions accordingly


  -- this is not necessary when the conf.lua is set properly for the platform requirements
  -- local mushroom = love.image.newImageData("assets/shroom.png")
  -- local rainty = love.window.setIcon( mushroom )

  -- @TODO need to make world state save and load
  -- The initialization of the main game launch point with splash and menu maby?
  print("Main: Creating Game instance...")
  if Game then
    print("Main: Game class exists")
    local success, result = pcall(function() return Game:new() end)
    if success then
      game = result
      print("Main: Game instance created successfully")
      print("Main: Game object type:", type(game))
    else
      print("Main: Game:new() failed with error:", result)
      game = nil
    end
  else
    print("Error: Game class is nil!")
    game = nil
  end


  -- PrintTable(score)

  -- find out what this does
  gameloop:addLoop(self)

  love.timer.step() -- fix for load delay: https://love2d.org/forums/viewtopic.php?t=8589
end

debug_ui = {
  draw = function(self)
    -- love.graphics.print('text',100,100,r,sx,sy,ox,oy)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    -- love.graphics.setColor(red,green,blue,alpha)
    love.graphics.setColor(100/255, 0, 0)
    love.graphics.rectangle('fill',100,-100,100,100)
    print('drawing debug_ui')
  end,

}

-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
local delta_time = {}
local av_dt      = 0.016
local sample     = 10
local pop, push = table.remove, table.insert

function love.update(dt)
  -- score:update() -- why were we updating this here?

  -- how do i use this
  -- require("lib/lovebird").update() -- browser based debug console - is this useful?

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

  if game and game.update then
    game:update(av_dt)
  end

  g_GameTime = g_GameTime + av_dt
end

-- need a better debug background
background = love.graphics.newImage("assets/galaxy.png")
local function drawBackground(willDraw)
  if not willDraw then return end

  love.graphics.setColor(1, 1, 1, 145/255)
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
end

-- @todo figure out renerer layers
function love.draw(dt)
  -- galaxy background defined above pre- renderer layers
  willDraw = true
  -- willDraw = false
  drawBackground(willDraw)
  


  -- game camera
  camera:set()

  -- Wrap in pcall to ensure camera:unset() is always called
  -- Prevents "Maximum stack depth" errors when draw fails
  local drawSuccess, drawErr = pcall(function()
    renderer:draw()
    if game and game.draw then
      game:draw()
    end
  end)

  -- everything here moves with the camera trail
  camera:unset()

  -- Report any draw errors after stack is balanced
  if not drawSuccess then
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("Draw error: " .. tostring(drawErr), 10, 10)
  end

  -- draws the static positioned HUD text
  -- why doesn't this work?
  -- score:draw()
  -- mts:draw()

  -- collectgarbage()

  if tiles == nil then
    tiles = 'tiles nil'
  end

-- Q. why does anything below not draw? drawing only seems to happen in
-- the menu state??
-- A. it draws once you enter the generate state, maybe menu hangs here?

  -- print(tiles[1])
  -- PrintTable(tiles[1][1]['occupied'], 1)
  -- print(tiles[1][1]['occupied'])
  falsey = tiles[1][1]['occupied']
  -- print(falsey)
  love.graphics.setFont(love.graphics.newFont(12))
  love.graphics.setColor(1, 0, 0)
  love.graphics.print("PRE-ALPHA", 0, 0, nil, 4, 4)
  love.graphics.print(
    "Debug Info:"..'\n' ..
    -- tiles[1][1]['occupied'] or 'nil' ..
    tostring(falsey),
    screen_width - 300, 0, nil, 4, 4
  )
  love.graphics.setFont(love.graphics.newFont(42))

  -- love.graphics.print({'rainty', screen_width - 300, 0, nil, 4, 4})

  -- hand, job = pcall(
  --   love.graphics.print,
  --   tostring(tiles),
  --   screen_width - 300, 0, nil, 4, 4
  -- )
  -- print(hand, job)
  -- debug_ui.draw()

  -- this is where we should draw debug ui, it will draw
  -- during all modes and on top of everything

  -- need global FPS text, this isn't working
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.print('hello', 100, 100)
  -- need global FPS text, this isn't working
  -- if DEBUG_SHOW_FPS then
  --   local _r, _g, _b, _a = love.graphics.getColor()
  --   love.graphics.setColor(255, 255, 255, 255)
  --   love.graphics.print(
  --     tostring(love.timer.getFPS()),
  --     -- camera.pos.x + (windowWidth - 64),
  --     -- camera.pos.y + (windowHeight - 64)
	-- 		64, 64
  --   )
  --   love.graphics.setColor(_r, _g, _b, _a)
  -- end
end

-- https://love2d.org/wiki/KeyConstant
function love.keypressed(key, code)
  if (DEBUG_LOGGING_ON and DEBUG_LOGGING_INPUT and key) then
    print('key pressed: '..key..' unicode: '..code)
  end

  if game and game.keypressed then
    -- PrintTable(game)
    game:keypressed(key, code)
    -- score:keypress(key)
  else
    if DEBUG_LOGGING_ON then
      print("Warning: game or game.keypressed is nil")
    end
  end

  -- plus button adds 100 to the score
  if key == '=' then
    -- score:add(100)
    -- print('SCORE + 100! = '..score:get())
  end
end
function love.keyreleased( key, scancode )
  -- if (DEBUG_LOGGING_ON and key) then print('key released: '..key) end
  -- score:keyrelease(key)
end
function love.mousepressed(x, y, button, istouch)
  if game and game.mousepressed then
    game:mousepressed(x, y, button, istouch)
  end
  -- score:mousepress()
end

function love.mousereleased(x, y, button)
  if game and game.mousereleased then
    game:mousereleased(x, y, button)
  end
  -- score:mouserelease()
end
function love.resize(w, h)
  print(("Window resized to width: %d and height: %d."):format(w, h))
  screen_width = w
  screen_height = h
end
function love.quit()
  -- score:quit()
end

-- also from: https://sheepolution.com/learn/book/bonus/vscode
-- also not working
local love_errorhandler = love.errhand
function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
