--[[
  This is a basic example and can be modified to your needs.
The above code defines an enemy manager object with functions to add and remove enemies, update and draw all enemies on the screen, and create a new instance of the enemy manager. The example usage shows how to create a new enemy manager object, add enemies to it, update and draw them on the screen.

It's a basic example, you can add more functionality like for example a way to check if an enemy is alive or not, a way to check if the player is in range of the enemy, or a way to check if the enemy has reached a target point. You can also create an Enemy class with some properties and methods that you can use in the manager, like an ID, name, health, attack, and so on.

Keep in mind that this is just a basic example and can be further modified and optimized to suit your needs.
]]

-- Create the enemy manager table
local enemyManager = {}

-- Add an enemy to the manager
function enemyManager:addEnemy(enemy)
  table.insert(self.enemies, enemy)
end

-- Remove an enemy from the manager
function enemyManager:removeEnemy(enemy)
  for i, e in ipairs(self.enemies) do
    if e == enemy then
      table.remove(self.enemies, i)
      break
    end
  end
end

-- Update all enemies
function enemyManager:update(dt)
  for i, enemy in ipairs(self.enemies) do
    enemy:update(dt)
  end
end

-- Draw all enemies on the screen
function enemyManager:draw()
  for i, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

-- Create a new instance of the enemy manager
function enemyManager:new()
  local obj = { enemies = {} }
  setmetatable(obj, { __index = enemyManager })
  return obj
end

-- Example usage
local myEnemyManager = enemyManager:new()
myEnemyManager:addEnemy({ image = love.graphics.newImage("enemy1.png"), x = 100, y = 200, update = function(self, dt) self.x = self.x + 50 * dt end, draw = function(self) love.graphics.draw(self.image, self.x, self.y) end })
myEnemyManager:addEnemy({ image = love.graphics.newImage("enemy2.png"), x = 300, y = 100, update = function(self, dt) self.y = self.y + 50 * dt end, draw = function(self) love.graphics.draw(self.image, self.x, self.y) end })

function love.update(dt)
  myEnemyManager:update(dt)
end

function love.draw()
  myEnemyManager:draw()
end
