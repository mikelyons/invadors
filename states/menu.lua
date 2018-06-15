
local Menu = Game:addState('Menu')

function Menu:enteredState()
  print('ENTER MENU STATE')
end


function Menu:update(dt)
end

function Menu:draw()
  love.graphics.setBackgroundColor(11, 29, 39, 100)--BG_COLOR)

  love.graphics.setColor(0,0,51,100)
  love.graphics.rectangle('fill', 150, 150, 350, 350)

  love.graphics.setColor(255, 223, 0)
  love.graphics.printf('Press a key to Continue', 150, 220, 200, 'center')
  love.graphics.printf([[if key == (1 or return) then self:gotoState(Training) end
     if key == (2 or space) then self:gotoState(bizzaro) end
    if key == (3 or q) then self:gotoState(SPACE) end
    if key == ('4' or 'w') then self:gotoState('Earth2') end
    END OF TRANSMISSION]]
    , 50, 20, 620, 'center')
end

function Menu:keypressed(key, code)
  if key == ('1' or 'return') then self:pushState('Training') end
  if key == ('2' or 'space') then self:pushState('Bizzaro') end
  if key == ('3' or 'q') then self:pushState('Space1') end
  if key == ('4' or 'w') then self:pushState('Earth2') end
end