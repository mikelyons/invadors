player_scratch.lua


-- Set up player and add to BUMP world
local player = { 
  x=50,y=50,w=20,h=20, 
  speed = 300,
  y_velocity = 0,        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
  jump_height = -300,    -- Whenever the character jumps, he can reach this height.
  gravity = -500,        -- Whenever the character falls, he will descend at this rate.
  ground =  800,    -- This makes the character land on the plaform.
  falling = true
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
  -- if love.keyboard.isDown('space') then 
  --   player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
  --   if player.y_velocity == 0 then
  --     player.y_velocity = player.jump_height    -- The player's Y-Axis Velocity is set to it's Jump Height.
  --   end
  -- end
  -- if player.y_velocity ~= 0 then  -- The game checks if player has "jumped" and left the ground.
  --   dy = player.y_velocity * dt
  --   player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
  -- end
  -- if player.y_velocity == 0 then
  --   player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
  -- end

  -- if love.keyboard.isDown('right' or 'd') then
  --   dx = speed * dt
  -- elseif love.keyboard.isDown('left' or 'a') then
  --   dx = -speed * dt
  -- end

  if dx ~= 0 or dy ~= 0 then
    local cols
    player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy)

    if cols_len ~= 0 then
      for i=1, cols_len do
        local col = cols[i]
        if col.normal.y == 1 then
          consolePrint('bonk') 
          player.y_velocity = 0
          player.dy = 0
        elseif col.normal.y == -1 then
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
    else
      if player.y_velocity > 0 then
        consolePrint('falling') 
      end

      dy = player.y_velocity * dt
      player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
    end
  end
end


  -- world:add(player, player.x, player.y, player.w, player.h)
