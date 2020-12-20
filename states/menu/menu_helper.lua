
local MenuHelper = {}

function MenuHelper:new(menuStateMachine)
  local menuHelper = {}

  image = asm:get('hamster')
  -- font = love.graphics.newImageFont("assets/newer/Imagefont.png",
  --   " abcdefghijklmnopqrstuvwxyz" ..
  --   "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
  --   "123456789.,!?-+/():;%&`'*#=[]\""),
  font = love.graphics.newFont(32)
  menuHelper.msm = menuStateMachine

  -- menuStateMachine:gotoState('generate')
  -- print('raint')
  -- PrintTable(menuStateMachine.static.states)
  -- print('raint')
  


  function menuHelper:load()
    -- PrintTable(menuHelper.msm)
    self:loadButtons(menuHelper.msm)
  end

  function menuHelper.drawButton(self, x, y, w, h, text)
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
  end

  function menuHelper:drawMenu()
    -- Logo
    -- https://fontmeme.com/doom-font/
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(image, 50, 50, 0, 2.2, 2.2)

    -- love.graphics.setBackgroundColor(60, 29, 19, 100)--BG_COLOR)
    -- love.graphics.setBackgroundColor(255, 255, 255, 255)--BG_COLOR)

    local startButton = self:drawButton(150, 250, 200, 35, 'Start Game')

    -- love.graphics.printf(
    --   [[if key == (1 or return) then self:gotoState(Training) end
    --   if key == (2 or space) then self:gotoState(bizzaro) end
    --   if key == (3 or q) then self:gotoState(SPACE) end
    --   if key == ('4' or 'w') then self:gotoState('Earth2') end
    --   if key == ('5' or '') then self:gotoState('commando') end
    --   if key == ('6' or '') then self:gotoState('generate') end

    --   END OF TRANSMISSION]]
    --   , 50, 320, 620, 'left')
  end

  function menuHelper:loadButtons(msm)
    self.font = love.graphics.newFont(32)

    self.buttons = {}

    local buttons = self.buttons

    table.insert(buttons, self:newButton(
      'Start Game',
      function()
        -- Game:popState()--pushState('generate')
        msm()
        print('starting game')
      end
    ))
    table.insert(buttons, self:newButton(
      'Load Game',
      function()
        print('Load a save game')
      end
    ))
    table.insert(buttons, self:newButton(
      'Settings',
      function()
        print('Go to Settings Menu')
      end
    ))
    table.insert(buttons, self:newButton(
      'Quit',
      function()
        print('Goodbye')
        love.event.quit(0)
      end
    ))
    return self.buttons
  end

  function menuHelper:drawButtons()
    local buttons = self.buttons
    local _r, _g, _b, _a = love.graphics.getColor()

    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button_height = 64
    local button_width = ww * (1/3)
    local margin = 16
    local total_height = (button_height + margin) * #buttons
    local cursor_y = 0

    -- from tutorial:  https://www.youtube.com/watch?v=vMSjVuJ6wDs&t=303s
    for i, button in ipairs(buttons) do
      button.last = button.now

      local bx = (ww * 0.5) - (button_width * 0.5)
      local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

      local mx, my = love.mouse.getPosition()
      local hovered = mx > bx and mx < bx + button_width and
                      my > by and my < by + button_height
      local color = {80, 80, 100, 255}
      local textColor = {0, 0, 0, 255}
      if hovered then
        color = {160, 160, 200, 255}
        textColor = {255, 255, 255, 255}
      end

      button.now = love.mouse.isDown(1)
      if button.now and not button.last and hovered then
        button.fn()
      end 

      love.graphics.setColor(unpack(color))
      love.graphics.rectangle(
        'fill',
        bx,
        by,
        button_width,
        button_height
      )

      local textW = font:getWidth(button.text)
      local textH = font:getHeight(button.text)

      love.graphics.setColor(unpack(textColor))
      love.graphics.setFont(self.font)
      love.graphics.print(
        button.text,
        (ww * 0.4) - textW * 0.1, -- bx
        by + textW * 0.1 -- by
      )

      cursor_y = cursor_y + (button_height + margin)

      love.graphics.setColor(_r, _g, _b, _a)
    end
  end
  function menuHelper:newButton(text, fn)

    return {
      text = text,
      fn = fn,

      now = false,
      last = false,
    }
  end
  return menuHelper
end

return MenuHelper
