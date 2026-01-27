--[[
  Panel.lua

  Reusable panel container with optional title, background, and border.
  Used for organizing UI sections in the character creation screen.

  Usage:
    local Panel = require('src/ui/Panel')

    local panel = Panel:new({
      x = 0,
      y = 80,
      width = 300,
      height = 600,
      title = "Stats",
    })

    -- In draw loop:
    panel:draw()

    -- Get content area (inner bounds with padding):
    local cx, cy, cw, ch = panel:getContentArea()
]]

local Theme = require('src/ui/theme')

local Panel = {}
Panel.__index = Panel

--- Create a new Panel instance
-- @param options table Configuration options
--   - x (number): X position
--   - y (number): Y position
--   - width (number): Panel width
--   - height (number): Panel height
--   - title (string, optional): Panel title text
--   - padding (number, optional): Inner padding (default from theme)
--   - visible (boolean, optional): Whether panel is visible (default true)
-- @return Panel The new panel instance
function Panel:new(options)
  options = options or {}

  local instance = {
    x = options.x or 0,
    y = options.y or 0,
    width = options.width or 200,
    height = options.height or 300,
    title = options.title or nil,
    padding = options.padding or Theme.panel.padding,
    visible = options.visible ~= false,

    -- Styling
    colors = options.colors or Theme.colors.panel,
    titleHeight = options.titleHeight or 32,
    cornerRadius = options.cornerRadius or Theme.panel.cornerRadius,
    borderWidth = options.borderWidth or Theme.panel.borderWidth,
  }

  setmetatable(instance, self)
  return instance
end

--- Draw the panel
function Panel:draw()
  if not self.visible then return end

  local lg = love.graphics

  -- Draw background
  lg.setColor(self.colors.background)
  if self.cornerRadius > 0 then
    lg.rectangle('fill', self.x, self.y, self.width, self.height, self.cornerRadius, self.cornerRadius)
  else
    lg.rectangle('fill', self.x, self.y, self.width, self.height)
  end

  -- Draw border
  lg.setColor(self.colors.border)
  lg.setLineWidth(self.borderWidth)
  if self.cornerRadius > 0 then
    lg.rectangle('line', self.x, self.y, self.width, self.height, self.cornerRadius, self.cornerRadius)
  else
    lg.rectangle('line', self.x, self.y, self.width, self.height)
  end

  -- Draw title if present
  if self.title then
    -- Title background
    lg.setColor(self.colors.header)
    if self.cornerRadius > 0 then
      -- Draw header with rounded top corners only
      lg.rectangle('fill', self.x, self.y, self.width, self.titleHeight, self.cornerRadius, self.cornerRadius)
      -- Cover bottom rounded corners
      lg.rectangle('fill', self.x, self.y + self.cornerRadius, self.width, self.titleHeight - self.cornerRadius)
    else
      lg.rectangle('fill', self.x, self.y, self.width, self.titleHeight)
    end

    -- Title text
    lg.setColor(Theme.colors.text.primary)
    local font = Theme.fonts.getByName('md')
    lg.setFont(font)
    local textWidth = font:getWidth(self.title)
    local textX = self.x + (self.width - textWidth) / 2
    local textY = self.y + (self.titleHeight - font:getHeight()) / 2
    lg.print(self.title, textX, textY)
  end
end

--- Get the content area bounds (inner area with padding, excluding title)
-- @return number, number, number, number x, y, width, height
function Panel:getContentArea()
  local titleOffset = self.title and self.titleHeight or 0
  return
    self.x + self.padding,
    self.y + titleOffset + self.padding,
    self.width - (self.padding * 2),
    self.height - titleOffset - (self.padding * 2)
end

--- Set panel position
-- @param x number X position
-- @param y number Y position
function Panel:setPosition(x, y)
  self.x = x
  self.y = y
end

--- Set panel size
-- @param width number Panel width
-- @param height number Panel height
function Panel:setSize(width, height)
  self.width = width
  self.height = height
end

--- Check if a point is within the panel bounds
-- @param px number X coordinate
-- @param py number Y coordinate
-- @return boolean True if point is inside panel
function Panel:containsPoint(px, py)
  return px >= self.x and px <= self.x + self.width
     and py >= self.y and py <= self.y + self.height
end

--- Show or hide the panel
-- @param visible boolean Whether panel should be visible
function Panel:setVisible(visible)
  self.visible = visible
end

--- Update method (for consistency with other UI elements)
-- @param dt number Delta time
function Panel:update(dt)
  -- Panels don't need updates, but method exists for UIManager compatibility
end

return Panel
