--[[
  StatSlider.lua

  A slider component for adjusting numeric stat values.
  Displays label above, current value, and a draggable track/handle.

  Usage:
    local StatSlider = require('src/ui/StatSlider')

    local slider = StatSlider:new({
      x = 50,
      y = 100,
      width = 200,
      label = "Strength",
      min = 1,
      max = 20,
      value = 10,
      onChange = function(value) print("New value:", value) end,
    })

    -- In update/draw loops:
    slider:update(dt)
    slider:draw()

    -- Handle mouse events:
    slider:mousepressed(x, y, button)
    slider:mousereleased(x, y, button)
]]

local Theme = require('src/ui/theme')

local StatSlider = {}
StatSlider.__index = StatSlider

--- Create a new StatSlider instance
-- @param options table Configuration options
--   - x (number): X position
--   - y (number): Y position
--   - width (number): Slider width
--   - label (string): Stat label text
--   - min (number): Minimum value
--   - max (number): Maximum value
--   - value (number): Initial value
--   - step (number, optional): Value step increment (default 1)
--   - onChange (function, optional): Callback when value changes
--   - enabled (boolean, optional): Whether slider is interactive (default true)
--   - visible (boolean, optional): Whether slider is visible (default true)
-- @return StatSlider The new slider instance
function StatSlider:new(options)
  options = options or {}

  local instance = {
    x = options.x or 0,
    y = options.y or 0,
    width = options.width or 200,
    label = options.label or "Stat",
    min = options.min or 0,
    max = options.max or 100,
    value = options.value or options.min or 0,
    step = options.step or 1,
    onChange = options.onChange,
    enabled = options.enabled ~= false,
    visible = options.visible ~= false,

    -- State
    isDragging = false,
    isHovered = false,

    -- Dimensions from theme
    height = Theme.slider.height,
    trackHeight = Theme.slider.trackHeight,
    handleWidth = Theme.slider.handleWidth,
    handleHeight = Theme.slider.handleHeight,
    labelSpacing = Theme.slider.labelSpacing,
  }

  -- Clamp initial value
  instance.value = math.max(instance.min, math.min(instance.max, instance.value))

  setmetatable(instance, self)
  return instance
end

--- Get the total height of the slider including label
-- @return number Total height
function StatSlider:getTotalHeight()
  local font = Theme.fonts.getByName('sm')
  return font:getHeight() + self.labelSpacing + self.height
end

--- Get the track Y position (below label)
-- @return number Track Y position
function StatSlider:getTrackY()
  local font = Theme.fonts.getByName('sm')
  return self.y + font:getHeight() + self.labelSpacing
end

--- Get the handle X position based on current value
-- @return number Handle X position
function StatSlider:getHandleX()
  local range = self.max - self.min
  if range == 0 then return self.x end
  local trackWidth = self.width - self.handleWidth
  local ratio = (self.value - self.min) / range
  return self.x + (ratio * trackWidth)
end

--- Update slider state
-- @param dt number Delta time
function StatSlider:update(dt)
  if not self.visible or not self.enabled then return end

  local mx, my = love.mouse.getPosition()

  -- Handle dragging
  if self.isDragging then
    if love.mouse.isDown(1) then
      self:updateValueFromMouse(mx)
    else
      self.isDragging = false
    end
  end

  -- Check hover state
  local trackY = self:getTrackY()
  self.isHovered = mx >= self.x and mx <= self.x + self.width
                and my >= trackY and my <= trackY + self.height
end

--- Update value based on mouse X position
-- @param mx number Mouse X position
function StatSlider:updateValueFromMouse(mx)
  local trackWidth = self.width - self.handleWidth
  local relativeX = mx - self.x - (self.handleWidth / 2)
  local ratio = math.max(0, math.min(1, relativeX / trackWidth))

  local range = self.max - self.min
  local rawValue = self.min + (ratio * range)

  -- Apply step
  local newValue = math.floor(rawValue / self.step + 0.5) * self.step
  newValue = math.max(self.min, math.min(self.max, newValue))

  if newValue ~= self.value then
    self.value = newValue
    if self.onChange then
      self.onChange(self.value)
    end
  end
end

--- Draw the slider
function StatSlider:draw()
  if not self.visible then return end

  local lg = love.graphics
  local colors = Theme.slider.colors
  local font = Theme.fonts.getByName('sm')

  -- Draw label
  lg.setColor(colors.label)
  lg.setFont(font)
  lg.print(self.label, self.x, self.y)

  -- Draw value on right side
  lg.setColor(colors.value)
  local valueText = tostring(math.floor(self.value))
  local valueWidth = font:getWidth(valueText)
  lg.print(valueText, self.x + self.width - valueWidth, self.y)

  -- Track position
  local trackY = self:getTrackY()
  local trackCenterY = trackY + (self.height - self.trackHeight) / 2

  -- Draw track background
  lg.setColor(colors.track)
  lg.rectangle('fill', self.x, trackCenterY, self.width, self.trackHeight, 4, 4)

  -- Draw filled portion of track
  local handleX = self:getHandleX()
  local filledWidth = handleX - self.x + (self.handleWidth / 2)
  lg.setColor(colors.trackFilled)
  lg.rectangle('fill', self.x, trackCenterY, filledWidth, self.trackHeight, 4, 4)

  -- Draw handle
  local handleColor = colors.handle
  if self.isDragging then
    handleColor = colors.handleActive
  elseif self.isHovered then
    handleColor = colors.handleHover
  end

  lg.setColor(handleColor)
  local handleY = trackY + (self.height - self.handleHeight) / 2
  lg.rectangle('fill', handleX, handleY, self.handleWidth, self.handleHeight, 4, 4)
end

--- Handle mouse press event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the event was consumed
function StatSlider:mousepressed(x, y, button)
  if not self.visible or not self.enabled then return false end
  if button ~= 1 then return false end

  local trackY = self:getTrackY()

  -- Check if click is on slider track/handle area
  if x >= self.x and x <= self.x + self.width
     and y >= trackY and y <= trackY + self.height then
    self.isDragging = true
    self:updateValueFromMouse(x)
    return true
  end

  return false
end

--- Handle mouse release event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the event was consumed
function StatSlider:mousereleased(x, y, button)
  if button ~= 1 then return false end

  local wasDragging = self.isDragging
  self.isDragging = false

  return wasDragging
end

--- Set slider value programmatically
-- @param value number New value
function StatSlider:setValue(value)
  local newValue = math.max(self.min, math.min(self.max, value))
  if newValue ~= self.value then
    self.value = newValue
    if self.onChange then
      self.onChange(self.value)
    end
  end
end

--- Get current value
-- @return number Current value
function StatSlider:getValue()
  return self.value
end

--- Set slider position
-- @param x number X position
-- @param y number Y position
function StatSlider:setPosition(x, y)
  self.x = x
  self.y = y
end

--- Enable or disable the slider
-- @param enabled boolean Whether slider should be enabled
function StatSlider:setEnabled(enabled)
  self.enabled = enabled
  if not enabled then
    self.isDragging = false
    self.isHovered = false
  end
end

--- Show or hide the slider
-- @param visible boolean Whether slider should be visible
function StatSlider:setVisible(visible)
  self.visible = visible
  if not visible then
    self.isDragging = false
    self.isHovered = false
  end
end

return StatSlider
