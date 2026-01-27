-- Simple test to verify dinner state can be loaded
print("Testing dinner state loading...")

-- Mock the Game object for testing
Game = {
  addState = function(name)
    print("Adding state: " .. name)
    return {}
  end
}

-- Mock love.graphics for testing
love = {
  graphics = {
    newImage = function(path)
      print("Loading image: " .. path)
      return { setFilter = function() end }
    end,
    getWidth = function() return 800 end,
    getHeight = function() return 600 end,
    setColor = function() end,
    rectangle = function() end,
    draw = function() end,
    print = function() end,
    printf = function() end
  },
  mouse = {
    getPosition = function() return 400, 300 end
  },
  math = {
    random = function() return 0.5 end
  }
}

-- Mock the evilNote dependency
package.loaded['ui objects/evilNote'] = {
  new = function(x, y, text)
    return {
      update = function() end,
      draw = function() end,
      mousepressed = function() end,
      mousereleased = function() end
    }
  end
}

-- Try to load the dinner state
local success, err = pcall(function()
  require('states/dinner/dinner')
end)

if success then
  print("✓ Dinner state loaded successfully!")
else
  print("✗ Dinner state failed to load: " .. tostring(err))
end



