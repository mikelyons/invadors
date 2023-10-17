--[[
  This is a basic example and can be modified to your needs.
The above code defines a player inventory object with functions to add and remove items, draw the inventory on the screen, and create a new instance of the inventory. The example usage shows how to create a new inventory object, add items to it, and display the inventory on the screen.

It's a basic example, you can add more functionality like for example a limit for the amount of items you can carry, or a way to check if the player already has an item or not. You can also create an Item class with some properties and methods that you can use in the inventory, like an ID, name, description, and so on.

Keep in mind that this is just a basic example and can be further modified and optimized to suit your needs.
]]

-- Create the player inventory table
local playerInventory = {}

-- Add an item to the inventory
function playerInventory:addItem(item)
  table.insert(self.items, item)
end

-- Remove an item from the inventory
function playerInventory:removeItem(item)
  for i, invItem in ipairs(self.items) do
    if invItem == item then
      table.remove(self.items, i)
      break
    end
  end
end

-- Draw the inventory on the screen
function playerInventory:draw()
  for i, item in ipairs(self.items) do
    love.graphics.draw(item.image, (i - 1) * 32, 0)
  end
end

-- Create a new instance of the player inventory
function playerInventory:new()
  local obj = { items = {} }
  setmetatable(obj, { __index = playerInventory })
  return obj
end

-- Example usage
local myInventory = playerInventory:new()
myInventory:addItem({ image = love.graphics.newImage("sword.png") })
myInventory:addItem({ image = love.graphics.newImage("armor.png") })

function love.draw()
  myInventory:draw()
end
