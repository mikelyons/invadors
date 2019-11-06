return{
  new = function(self)
    return{
      image = asm:get('hamster'),
      drawButton = function(x, y, w, h, text)
        --shadow
        love.graphics.setColor(30,30,51,100)
        love.graphics.rectangle('fill', x+10, y+10, w, h, 30, 30)
        -- blue button yellow text red highlight
        love.graphics.setColor(0,0,51,255)
        love.graphics.rectangle('fill', x, y, w, h, 30, 30)
        love.graphics.setColor(250,30,51,100)
        love.graphics.rectangle('line', x, y, w, h, 30, 30)
        love.graphics.setColor(255, 223, 0)
        love.graphics.printf(text, x, y+10, 200, 'center')
      end,

      drawMenu = function(self)
        -- Logo
        love.graphics.draw(self.image, 50, 50, 0, .2, .2)

        love.graphics.setBackgroundColor(60, 29, 19, 100)--BG_COLOR)
        local startButton = self.drawButton(150, 250, 200, 35, 'Start Game')

        love.graphics.printf(
          [[if key == (1 or return) then self:gotoState(Training) end
          if key == (2 or space) then self:gotoState(bizzaro) end
          if key == (3 or q) then self:gotoState(SPACE) end
          if key == ('4' or 'w') then self:gotoState('Earth2') end
          END OF TRANSMISSION]]
          , 50, 320, 620, 'left')
      end,
    }
  end,
}

