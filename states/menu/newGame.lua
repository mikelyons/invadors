print('newGame.lua -> ')

print('New Game -> ')

local NewGame = Game:addState('newGame')

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false,
  }
end

-- States to skip (system files, templates, problematic states)
local SKIP_STATES = {
  ['.DS_Store'] = true,
  ['.DS_store'] = true,
  ['.git'] = true,
  ['_template'] = true,
  ['ai found note'] = true,
}

function NewGame:loadButtons()
  self.buttons = {}

  local lfs = love.filesystem
  local filesTable = lfs.getDirectoryItems('/states')

  -- Sort alphabetically
  table.sort(filesTable)

  self.buttons = self:buildSavesButtonTable(self.buttons, filesTable)

  print("Loaded " .. #self.buttons .. " state buttons")
end

function NewGame:buildSavesButtonTable(buttonsTable, states)
  local buttons = {}

  for i = 1, #states do
    local stateName = states[i]

    -- Skip system files and problematic states
    if SKIP_STATES[stateName] then
      goto skip_state
    end

    -- For files with extensions, extract the state name (without .lua)
    local displayName = stateName
    local actualStateName = stateName

    if stateName:match("%.lua$") then
      -- It's a .lua file - extract name without extension
      actualStateName = stateName:gsub("%.lua$", "")
      displayName = actualStateName
    elseif stateName:match("%.") then
      -- Skip other file types
      goto skip_state
    end

    -- Insert the state into the buttons table
    table.insert(buttons, newButton(
      displayName,
      function()
        print('Selected state: ' .. actualStateName)
        -- Try to push the state, but handle errors gracefully
        local success, err = pcall(function()
          self:pushState(actualStateName)
        end)
        if not success then
          print("Failed to push state:", actualStateName, "Error:", err)
          -- Try gotoState as fallback
          local success2, err2 = pcall(function()
            self:gotoState(actualStateName)
          end)
          if not success2 then
            print("Also failed gotoState:", actualStateName, "Error:", err2)
          end
        end
      end
    ))
    ::skip_state::
  end
  return buttons
end

function NewGame:drawButtons()
  if not love.mouse.isDown(1) then
    can_fire = true
  end

  local buttons = self.buttons
  if not buttons or #buttons == 0 then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("No states found", 100, 100)
    return
  end

  local _r, _g, _b, _a = love.graphics.getColor()

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  -- Grid layout configuration
  local margin = 8
  local headerHeight = 60
  local padding = 16

  -- Calculate button dimensions based on screen size
  -- Aim for 4-6 columns depending on screen width
  local targetColumns = math.max(3, math.min(6, math.floor(ww / 200)))
  local availableWidth = ww - (padding * 2) - (margin * (targetColumns - 1))
  local button_width = math.floor(availableWidth / targetColumns)
  local button_height = 36

  -- Calculate grid dimensions
  local columns = targetColumns
  local rows = math.ceil(#buttons / columns)

  -- Calculate starting position (centered horizontally)
  local totalGridWidth = (button_width * columns) + (margin * (columns - 1))
  local startX = (ww - totalGridWidth) / 2
  local startY = headerHeight + padding

  -- Draw header
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(self.titleFont or self.font)
  love.graphics.print("Select a State", padding, 20)

  love.graphics.setColor(0.5, 0.5, 0.5, 1)
  love.graphics.setFont(self.smallFont or self.font)
  love.graphics.print("(" .. #buttons .. " states available)", padding + 200, 25)

  -- Draw scroll indicator if content exceeds screen
  local totalGridHeight = (button_height + margin) * rows
  local maxVisibleHeight = wh - headerHeight - (padding * 2)

  -- Scrolling support
  if not self.scrollY then self.scrollY = 0 end
  local maxScroll = math.max(0, totalGridHeight - maxVisibleHeight)

  -- Draw buttons in grid
  love.graphics.setFont(self.font)

  for i, button in ipairs(buttons) do
    if not button then
      goto continue
    end

    button.last = button.now

    -- Calculate grid position
    local col = (i - 1) % columns
    local row = math.floor((i - 1) / columns)

    local bx = startX + (col * (button_width + margin))
    local by = startY + (row * (button_height + margin)) - self.scrollY

    -- Skip buttons outside visible area
    if by + button_height < headerHeight or by > wh then
      goto continue
    end

    local mx, my = love.mouse.getPosition()
    local hovered = mx > bx and mx < bx + button_width and
                    my > by and my < by + button_height and
                    my > headerHeight  -- Don't hover over header area

    -- Button colors
    local bgColor = {60/255, 60/255, 80/255, 1}
    local textColor = {0.8, 0.8, 0.8, 1}
    local borderColor = {80/255, 80/255, 100/255, 1}

    if hovered then
      bgColor = {100/255, 100/255, 140/255, 1}
      textColor = {1, 1, 1, 1}
      borderColor = {140/255, 140/255, 180/255, 1}
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hovered and can_fire then
      button.fn(self)
      can_fire = false
    end

    -- Draw button background
    love.graphics.setColor(unpack(bgColor))
    love.graphics.rectangle('fill', bx, by, button_width, button_height, 4, 4)

    -- Draw button border
    love.graphics.setColor(unpack(borderColor))
    love.graphics.rectangle('line', bx, by, button_width, button_height, 4, 4)

    -- Draw button text (truncate if too long)
    local displayText = button.text
    local maxTextWidth = button_width - 12
    while self.font:getWidth(displayText) > maxTextWidth and #displayText > 3 do
      displayText = displayText:sub(1, -2)
    end
    if displayText ~= button.text then
      displayText = displayText:sub(1, -2) .. "…"
    end

    local textW = self.font:getWidth(displayText)
    local textH = self.font:getHeight()
    local textX = bx + (button_width - textW) / 2
    local textY = by + (button_height - textH) / 2

    love.graphics.setColor(unpack(textColor))
    love.graphics.print(displayText, textX, textY)

    ::continue::
  end

  -- Draw scroll indicator if needed
  if maxScroll > 0 then
    love.graphics.setColor(0.5, 0.5, 0.5, 0.8)
    local scrollBarHeight = 100
    local scrollBarY = headerHeight + (self.scrollY / maxScroll) * (wh - headerHeight - scrollBarHeight - 20)
    love.graphics.rectangle('fill', ww - 12, scrollBarY, 8, scrollBarHeight, 4, 4)

    -- Draw scroll hint
    love.graphics.setColor(0.6, 0.6, 0.6, 1)
    love.graphics.setFont(self.smallFont or self.font)
    love.graphics.print("Scroll: Mouse wheel / Up/Down arrows", ww - 280, wh - 25)
  end

  love.graphics.setColor(_r, _g, _b, _a)
end

function NewGame:enteredState()
  can_fire = false
  fire_tick = 0
  fire_wait = 0.2

  love.graphics.clear(0.1, 0.1, 0.15, 1)

  -- Set up fonts
  self.font = love.graphics.newFont(14)
  self.titleFont = love.graphics.newFont(24)
  self.smallFont = love.graphics.newFont(11)

  -- Reset scroll position
  self.scrollY = 0

  if DEBUG_LOGGING_ON then
    print(string.format("ENTER NewGame STATE - %s \n", os.date()))
  end

  self:loadButtons()
end

function NewGame:update(dt)
  if not can_fire then
    fire_tick = fire_tick + dt
    if fire_tick > fire_wait then
      can_fire = true
      fire_tick = 0
    end
  end

  if Blood and Blood.update then
    Blood:update(dt)
  end
end

function NewGame:draw(dt)
  -- Draw dark background
  love.graphics.setColor(0.1, 0.1, 0.15, 1)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  self:drawButtons()

  -- Draw particles if available
  if Particle and Particle.draw then
    Particle:draw()
  end
  if Blood and Blood.draw then
    local mx, my = love.mouse.getPosition()
    Blood:draw(mx, my)
  end

  -- Draw cursor if available
  local mx, my = love.mouse.getPosition()
  love.mouse.setVisible(true)
  if brian then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(brian, mx, my)
  end
end

function NewGame:exitedState()
  self.buttons = nil
  self.scrollY = 0
  love.graphics.clear()
end

function NewGame:mousepressed(x, y, button, istouch)
  -- Handle scrolling with mouse wheel is done in wheelmoved
end

function NewGame:mousereleased(x, y, button) end

function NewGame:wheelmoved(x, y)
  if not self.buttons then return end

  local wh = love.graphics.getHeight()
  local headerHeight = 60
  local padding = 16
  local margin = 8
  local button_height = 36
  local columns = math.max(3, math.min(6, math.floor(love.graphics.getWidth() / 200)))
  local rows = math.ceil(#self.buttons / columns)
  local totalGridHeight = (button_height + margin) * rows
  local maxVisibleHeight = wh - headerHeight - (padding * 2)
  local maxScroll = math.max(0, totalGridHeight - maxVisibleHeight)

  -- Scroll speed
  local scrollSpeed = 40

  self.scrollY = self.scrollY - (y * scrollSpeed)
  self.scrollY = math.max(0, math.min(maxScroll, self.scrollY))
end

function NewGame:keypressed(key, code)
  if key == 'escape' then
    self:popState('newGame')
    return
  end

  -- Scrolling with arrow keys
  if key == 'up' or key == 'pageup' then
    self:wheelmoved(0, 3)
  elseif key == 'down' or key == 'pagedown' then
    self:wheelmoved(0, -3)
  elseif key == 'home' then
    self.scrollY = 0
  elseif key == 'end' then
    -- Scroll to bottom
    self:wheelmoved(0, -1000)
  end
end

function NewGame:pushedState()
  print('')
  print('newgame pushed')
  PrintTable(self:getStateStackDebugInfo())
end

function NewGame:poppedState()
  print('\n')
  print('newgame popped')
  PrintTable(self:getStateStackDebugInfo())
end
