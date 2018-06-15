-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer

local bump       = Bump
local bump_debug = require 'bump_debug'

local Earth2 = Game:addState('Earth2')


-- World Creation
local instructions = [[You have gravity, 
jump with space
left right aarow keys to move]]
local world = bump.newWorld()
player = {}

local cols_len = 0 -- how many collisions are happening

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
  world:add(block, x,y,w,h) -- Add the block of your choice to the world
end

local function drawBlocks()
  for _,block in ipairs(blocks) do
    drawBox(block, 255,0,0)
  end
end

-- Set up player and add to BUMP world
local player = { 
  x=50,y=50,w=20,h=20, 
  speed = 300,
  y_velocity = 0,        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
  jump_height = -300,    -- Whenever the character jumps, he can reach this height.
  gravity = -500,        -- Whenever the character falls, he will descend at this rate.
  ground =  800    -- This makes the character land on the plaform.
}
local function updatePlayer(dt)
  local speed = player.speed

  if player.y > 600 then
    world:remove(player)
    player.y = 50
    player.x = 50
    player.dy = 0
    player.y_velocity = 0
    world:add(player, player.x, player.y, player.w, player.h)
  end

  local dx, dy = 0, 0
  -- This is in charge of player jumping.
  if love.keyboard.isDown('space') then 
    player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
    if player.y_velocity == 0 then
      player.y_velocity = player.jump_height    -- The player's Y-Axis Velocity is set to it's Jump Height.
    end
  end
  if player.y_velocity ~= 0 then                        -- The game checks if player has "jumped" and left the ground.
    dy = player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
  end
  if player.y_velocity == 0 then
    player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
  end

  if love.keyboard.isDown('right' or 'd') then
    dx = speed * dt
  elseif love.keyboard.isDown('left' or 'a') then
    dx = -speed * dt
  end

  if dx ~= 0 or dy ~= 0 then
    local cols
    player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy)
    if cols_len == 0 then
      consolePrint('flying') 
      dy = player.y_velocity * dt
      player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
    else
      for i=1, cols_len do
        local col = cols[i]
        if col.normal.y == -1 then
          consolePrint('walking') 
          player.y_velocity = 0
          player.dy = 0
        else
          consolePrint(("col.other = %s, col.type = %s, col.normal = %d,%d"):format(col.other, col.type, col.normal.x, col.normal.y))
        end

        -- consolePrint(("col.normal = %d,%d"):format(col.other, col.type, col.normal.x, col.normal.y))
        -- if col.normal.y == 0 and player.y_velocity == 0 then 
        --   consolePrint(("col.other = %s, col.type = %s, col.normal = %d,%d"):format(col.other, col.type, col.normal.x, col.normal.y))
        -- else
        --   consolePrint('RAINT') 
        -- end
      end
    end
  end
end
local function drawPlayer()
  drawBox(player, 0, 255, 0)
end



function Earth2:enteredState()
  print('ENTERED Earth2 STATE!')
  print(os.date())
  print(os.getenv('PATH')) -- get environmental variable


  -- BUMP load actions
  world:add(player, player.x, player.y, player.w, player.h)
  addBlock(0,       0,     800, 32)
  addBlock(0,      32,      32, 600-32*2)
  -- addBlock(800-32, 32,      32, 600-32*2)
  addBlock(0,      600-32, 800, 32)

  for i=1,3 do
    addBlock( math.random(100, 600),
              math.random(100, 400),
              math.random(10, 100),
              math.random(10, 100)
    )
  end


end

function Earth2:exitedState()
  -- destroy buttons, menus, etc
  world:remove(player)
  for _,block in ipairs(blocks) do
    world:remove(block)
  end
  blocks = {}
end


function Earth2:update(dt)
  updatePlayer(dt)

end

function Earth2:draw(dt)
  -- bump actions
  drawBlocks()
  drawPlayer()
  if shouldDrawDebug then
    drawDebug()
    drawConsole()
  end
  drawMessage()
end

function Earth2:keypressed(key, code)
  if key == 'escape' then self:popState('Earth2') end --then love.event.push('quit') end
  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end

  -- Bump actions
  if key == "tab"    then shouldDrawDebug = not shouldDrawDebug end
  if key == "delete" then collectgarbage("collect") end
end
