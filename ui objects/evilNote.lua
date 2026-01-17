--[[
  evilNote.lua

  Break out the sticky note object so that it
  can be used in other game states than the menu
  TODO - replace the main menu note with this
]]

if DEBUG_LOGGING_LOADING then
  print('evilNote.lua -> ')
end

return {
  new = function(x, y, text)
    return {
      text = text,
      rect = {
        x = x or 700,
        y = y or 500,
        width = 232,
        height = 232,
        dragging = { active = false, diffX = 0, diffY = 0 }
      },

      mousepressed = function(self, x,y, button, istouch, pressses)
        local rect = self.rect
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
      mousereleased = function(self, x,y, button, istouch, presses)
        local rect = self.rect
        -- Stop dragging
        if button == 1 then
          rect.dragging.active = false
        end
      end,

      add_fingerprint = function(self) end,
      new = function(self) end,
      load = function(self) end,

      update = function(self, dt)
        local rect = self.rect
        if rect.dragging.active then
          rect.x = love.mouse.getX() - rect.dragging.diffX
          rect.y = love.mouse.getY() - rect.dragging.diffY
        end
      end,

      draw = function(self, dt)
        local rect = self.rect
        -- draggable rect
        love.graphics.setColor(175, 225, 195, 255)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
        love.graphics.setColor(205, 255, 205, 255)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height/20)

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf(
          text, --SplashText:getText()
          rect.x+20,
          rect.y+20,
          220
        )
        love.graphics.setColor(255, 255, 255, 255)
      end,
    }
  end,
}