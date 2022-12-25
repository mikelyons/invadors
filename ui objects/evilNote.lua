--[[
  evilNote.lua

  A first attempt to break out the sticky note object so that it
  can be used in other game states than the menu
  it is currently part of the menu and not broken into it's own
  object module
  this is an attempt to do that
  currently the scoping is incorrect causing it's mousepressed func
  to printTable of the object itself, not sure what needs to change
  or if I need to go back to the other non-closure based 
  object definition style where functions are defined on a returned
  object like Object:mousepressed() instead of
  mousepressed = function()
]]


return {
  new = function(self, x, y, text) 
    return {
      text = text,
      rect = {
        x = 700,
        y = 500,
        width = 232,
        height = 232,
        dragging = { active = false, diffX = 0, diffY = 0 }
      },
      
      mousepressed = function(x,y, button)
        -- print('Mouse '..button)
        -- print('Mouse '..x)
        PrintTable(x)
        -- print('Mouse '..button)
        -- if love.mouse.isDown(1) then Blood:emit() end
        -- Start Dragging
        if button == 1 then
          if x>rect.x then
            if x<rect.x+rect.width then
              if y>rect.y then
                if y<rect.y+rect.height then
                  rect.dragging.active = true
                  rect.dragging.diffX = x - rect.x
                  rect.dragging.diffY = y - rect.y
                end
              end
            end
          end
        end
      end,
      mousereleased = function(x, y, button)
        -- Stop dragging
        if button == 1 then 
          rect.dragging.active = false 
        end
      end,

      add_fingerprint = function(self) end,
      new = function(self) end,
      load = function(self) end,

      update= function(self)
        if rect.dragging.active then
          rect.x = love.mouse.getX() - rect.dragging.diffX
          rect.y = love.mouse.getY() - rect.dragging.diffY
        end
      end,

      draw = function(self)
        -- draggable rect
        love.graphics.setColor(25, 25, 195, 255)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
        love.graphics.setColor(205, 5, 5, 255)
        love.graphics.printf(
          text--SplashText:getText()
          ,rect.x+20,rect.y+20,220)
        love.graphics.setColor(255, 255, 255, 255)
      end,
    }
  end,
}