-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer

local bump       = require 'lib/bump/bump' 
local bump_debug = require 'bump_debug'

local Space1 = Game:addState('Space1')

platform = {}
player = {}


local instructions = [[
  bump.lua simple demo

    arrows: move
    tab: toggle debug info
    delete: run garbage collector
]]
local cols_len = 0 -- how many collisions are happening

-- World Creation
local world = bump.newWorld()

-- Message/debug functions
local function drawMessage()
  local msg = instructions:format(tostring(shouldDrawDebug))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(msg, 550, 10)
end
local function drawDebug()
  bump_debug.draw(world)

  local statistics = ("fps: %d, mem: %dKB, collisions: %d, items: %d"):format(love.timer.getFPS(), collectgarbage("count"), cols_len, world:countItems())
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(statistics, 0, 580, 790, 'right')
end

local consoleBuffer = {}
local consoleBufferSize = 15
for i=1,consoleBufferSize do consoleBuffer[i] = "" end
local function consolePrint(msg)
  table.remove(consoleBuffer,1)
  consoleBuffer[consoleBufferSize] = msg
end

local function drawConsole()
  local str = table.concat(consoleBuffer, "\n")
  for i=1,consoleBufferSize do
    love.graphics.setColor(255,255,255, i*255/consoleBufferSize)
    love.graphics.printf(consoleBuffer[i], 10, 580-(consoleBufferSize - i)*12, 790, "left")
  end
end

-- helper function
local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

-- Block functions

local blocks = {}

local function addBlock(x,y,w,h)
  local block = {x=x,y=y,w=w,h=h}
  blocks[#blocks+1] = block
  world:add(block, x,y,w,h)
end

local function drawBlocks()
  for _,block in ipairs(blocks) do
    drawBox(block, 255,0,0)
  end
end

-- BUMP Player functions
local player = { x=50,y=50,w=20,h=20, speed = 800 }

local function updatePlayer(dt)
  local speed = player.speed

  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -speed * dt
  end
  if love.keyboard.isDown('down') then
    dy = speed * dt
  elseif love.keyboard.isDown('up') then
    dy = -speed * dt
  end

  if dx ~= 0 or dy ~= 0 then
    local cols
    player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy)
    for i=1, cols_len do
      local col = cols[i]
      consolePrint(("col.other = %s, col.type = %s, col.normal = %d,%d"):format(col.other, col.type, col.normal.x, col.normal.y))
    end
  end
end
local function drawPlayer()
  drawBox(player, 0, 255, 0)
end



function Space1:enteredState()
  print('ENTERED Space1 STATE!')
  print(os.date())
  -- print(os.getenv('PATH')) -- get environmental variable

  -- platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
  -- platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
  -- platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
  -- platform.y = platform.height / 2             -- This starts drawing the platform at the very middle of the game window

  -- player.x = love.graphics.getWidth() / 2   -- This sets the player at the middle of the screen based on the width of the game window. 
  -- player.y = love.graphics.getHeight() / 2  -- This sets the player at the middle of the screen based on the height of the game window. 
  -- player.w = 50
  -- player.h = 50
  -- player.speed = 300    -- This is the player's speed. This value can be change based on your liking.

  -- player.ground = player.y     -- This makes the character land on the plaform.
 
  -- player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
 
  -- player.jump_height = -300    -- Whenever the character jumps, he can reach this height.
  -- player.gravity = -500        -- Whenever the character falls, he will descend at this rate.


  -- BUMP load actions
  world:add(player, player.x, player.y, player.w, player.h)
  addBlock(0,       0,     800, 32)
  addBlock(0,      32,      32, 600-32*2)
  addBlock(800-32, 32,      32, 600-32*2)
  addBlock(0,      600-32, 800, 32)

  for i=1,30 do
    addBlock( math.random(100, 600),
              math.random(100, 400),
              math.random(10, 100),
              math.random(10, 100)
    )
  end


end

function Space1:exitedState()
  -- destroy buttons, menus, etc
end


function Space1:update(dt)
  updatePlayer(dt)

  -- if love.keyboard.isDown('d') then
  --   -- This makes sure that the character doesn't go pass the game window's right edge.
  --   if player.x < (love.graphics.getWidth() - 32) then
  --     player.x = player.x + (player.speed * dt)
  --   end
  -- elseif love.keyboard.isDown('a') then
  --   -- This makes sure that the character doesn't go pass the game window's left edge.
  --   if player.x > 0 then 
  --     player.x = player.x - (player.speed * dt)
  --   end
  -- end

  -- -- This is in charge of player jumping.
  -- if love.keyboard.isDown('space') then                     -- Whenever the player presses or holds down the Spacebar:
  --               -- The game checks if the player is on the ground. Remember that when the player is on the ground, Y-Axis Velocity = 0.
  --   if player.y_velocity == 0 then
  --     player.y_velocity = player.jump_height    -- The player's Y-Axis Velocity is set to it's Jump Height.
  --   end
  -- end
  -- if player.y_velocity ~= 0 then                                      -- The game checks if player has "jumped" and left the ground.
  --   player.y = player.y + player.y_velocity * dt                -- This makes the character ascend/jump.
  --   player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
  -- end
 
  --       -- This is in charge of collision, making sure that the character lands on the ground.
  -- if player.y > player.ground then    -- The game checks if the player has jumped.
  --   player.y_velocity = 0       -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
  --   player.y = player.ground    -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
  -- end

end

function Space1:draw(dt)
  -- love.graphics.setColor(205, 205, 255)        -- This sets the platform color to white. (The parameters are in RGB Color format).
  -- -- The platform will now be drawn as a white rectangle while taking in the variables we declared above.
  -- -- love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

  -- love.graphics.setColor(05, 205, 55)        -- bright green player color
  -- love.graphics.rectangle('fill',player.x, player.y-32, 32, 32) 

  -- bump actions
  drawBlocks()
  drawPlayer()
  if shouldDrawDebug then
    drawDebug()
    drawConsole()
  end
  drawMessage()
end

function Space1:keypressed(key, code)
  if key == ('escape' or 'p') then self:pushState('Pause') end --then love.event.push('quit') end

  -- Bump actions
  if key == "tab"    then shouldDrawDebug = not shouldDrawDebug end
  if key == "delete" then collectgarbage("collect") end
end
