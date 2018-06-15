
local Play = Game:addState('Play')

function Play:enteredState()
  -- create buttons, menus, etc
end

function Play:exitedState()
  -- destroy buttons, menus, etc
end

function Menu:update(dt)
end

function Play:draw(dt)
  -- draw the menus
end

function Menu:keypressed(key, code)
end
