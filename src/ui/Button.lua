--[[
  Button.lua

  Reusable button UI component with hover, click, and disabled states.
  Uses the theme system for consistent styling.

  Usage:
    local Button = require('src/ui/Button')

    local myButton = Button:new({
      text = "Click Me",
      x = 100,
      y = 200,
      onClick = function(self) print("Button clicked!") end,
    })

    -- In update loop:
    myButton:update(dt)

    -- In draw loop:
    myButton:draw()

    -- Handle mouse events:
    myButton:mousepressed(x, y, button)
    myButton:mousereleased(x, y, button)
]]

local Theme = require('src/ui/theme')

local Button = {}
Button.__index = Button

--- Create a new Button instance
-- @param options table Configuration options
--   - text (string): Button label text
--   - x (number): X position
--   - y (number): Y position
--   - width (number, optional): Button width (default from theme)
--   - height (number, optional): Button height (default from theme)
--   - onClick (function, optional): Callback when clicked
--   - onHover (function, optional): Callback when hovered
--   - enabled (boolean, optional): Whether button is interactive (default true)
--   - visible (boolean, optional): Whether button is visible (default true)
-- @return Button The new button instance
function Button:new(options)
  options = options or {}

  local instance = {
    text = options.text or "Button",
    x = options.x or 0,
    y = options.y or 0,
    width = options.width or Theme.button.width,
    height = options.height or Theme.button.height,
    onClick = options.onClick,
    onHover = options.onHover,
    enabled = options.enabled ~= false,
    visible = options.visible ~= false,

    -- State
    isHovered = false,
    isPressed = false,
    wasPressed = false,

    -- Animation
    hoverProgress = 0,
    pressProgress = 0,

    -- Optional styling overrides
    colors = options.colors or nil,
    font = options.font or nil,
    cornerRadius = options.cornerRadius or Theme.button.cornerRadius,
  }

  setmetatable(instance, self)
  return instance
end

--- Update button state
-- @param dt number Delta time
function Button:update(dt)
  if not self.visible or not self.enabled then
    self.hoverProgress = 0
    self.pressProgress = 0
    return
  end

  -- Get mouse position
  local mx, my = love.mouse.getPosition()

  -- Check if mouse is over button
  local wasHovered = self.isHovered
  self.isHovered = self:containsPoint(mx, my)

  -- Trigger hover callback on enter
  if self.isHovered and not wasHovered and self.onHover then
    self.onHover(self)
  end

  -- Animate hover
  local targetHover = self.isHovered and 1 or 0
  self.hoverProgress = self:lerp(self.hoverProgress, targetHover, dt / Theme.animation.hover)

  -- Animate press
  local targetPress = self.isPressed and 1 or 0
  self.pressProgress = self:lerp(self.pressProgress, targetPress, dt / Theme.animation.fast)
end

--- Draw the button
function Button:draw()
  if not self.visible then return end

  local colors = self.colors or Theme.colors.button
  local lg = love.graphics

  -- Determine current color based on state
  local bgColor
  if not self.enabled then
    bgColor = colors.disabled
  elseif self.isPressed then
    bgColor = colors.pressed
  elseif self.isHovered then
    bgColor = colors.hover
  else
    bgColor = colors.normal
  end

  -- Apply hover animation blend
  if self.enabled and self.hoverProgress > 0 then
    bgColor = self:lerpColor(colors.normal, colors.hover, self.hoverProgress)
  end

  -- Draw button background
  lg.setColor(bgColor)
  if self.cornerRadius > 0 then
    lg.rectangle('fill', self.x, self.y, self.width, self.height, self.cornerRadius, self.cornerRadius)
  else
    lg.rectangle('fill', self.x, self.y, self.width, self.height)
  end

  -- Draw button text
  local textColor = self.enabled and colors.text or colors.textDisabled
  lg.setColor(textColor)

  local font = self.font or Theme.fonts.getByName('md')
  lg.setFont(font)

  local textWidth = font:getWidth(self.text)
  local textHeight = font:getHeight()
  local textX = self.x + (self.width - textWidth) / 2
  local textY = self.y + (self.height - textHeight) / 2

  -- Apply press offset
  if self.pressProgress > 0 then
    textY = textY + (2 * self.pressProgress)
  end

  lg.print(self.text, textX, textY)
end

--- Handle mouse press event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button (1 = left, 2 = right)
-- @return boolean True if the event was consumed
function Button:mousepressed(x, y, button)
  if not self.visible or not self.enabled then return false end
  if button ~= 1 then return false end -- Only handle left click

  if self:containsPoint(x, y) then
    self.isPressed = true
    self.wasPressed = true
    return true
  end

  return false
end

--- Handle mouse release event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the event was consumed
function Button:mousereleased(x, y, button)
  if not self.visible or not self.enabled then return false end
  if button ~= 1 then return false end

  local wasPressed = self.isPressed
  self.isPressed = false

  -- Trigger click if released over button
  if wasPressed and self:containsPoint(x, y) then
    if self.onClick then
      self.onClick(self)
    end
    return true
  end

  return false
end

--- Check if a point is within the button bounds
-- @param px number X coordinate
-- @param py number Y coordinate
-- @return boolean True if point is inside button
function Button:containsPoint(px, py)
  return px >= self.x and px <= self.x + self.width
     and py >= self.y and py <= self.y + self.height
end

--- Set button position
-- @param x number X position
-- @param y number Y position
function Button:setPosition(x, y)
  self.x = x
  self.y = y
end

--- Set button size
-- @param width number Button width
-- @param height number Button height
function Button:setSize(width, height)
  self.width = width
  self.height = height or self.height
end

--- Enable or disable the button
-- @param enabled boolean Whether button should be enabled
function Button:setEnabled(enabled)
  self.enabled = enabled
  if not enabled then
    self.isHovered = false
    self.isPressed = false
  end
end

--- Show or hide the button
-- @param visible boolean Whether button should be visible
function Button:setVisible(visible)
  self.visible = visible
  if not visible then
    self.isHovered = false
    self.isPressed = false
  end
end

--- Linear interpolation helper
-- @param a number Start value
-- @param b number End value
-- @param t number Interpolation factor (0-1)
-- @return number Interpolated value
function Button:lerp(a, b, t)
  t = math.max(0, math.min(1, t))
  return a + (b - a) * t
end

--- Color interpolation helper
-- @param c1 table Start color
-- @param c2 table End color
-- @param t number Interpolation factor (0-1)
-- @return table Interpolated color
function Button:lerpColor(c1, c2, t)
  return {
    self:lerp(c1[1], c2[1], t),
    self:lerp(c1[2], c2[2], t),
    self:lerp(c1[3], c2[3], t),
    self:lerp(c1[4] or 1, c2[4] or 1, t),
  }
end

--- Get button bounds for layout purposes
-- @return number, number, number, number x, y, width, height
function Button:getBounds()
  return self.x, self.y, self.width, self.height
end

--- Get center position of the button
-- @return number, number centerX, centerY
function Button:getCenter()
  return self.x + self.width / 2, self.y + self.height / 2
end

return Button
