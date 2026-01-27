--[[
  EquipmentSlot.lua

  Equipment slot component for character creation.
  Displays an empty slot with label, ready for future item assignment.

  Usage:
    local EquipmentSlot = require('src/ui/EquipmentSlot')

    local slot = EquipmentSlot:new({
      x = 100,
      y = 200,
      id = "head",
      label = "Head",
    })

    -- In draw loop:
    slot:draw()
]]

local Theme = require('src/ui/theme')

local EquipmentSlot = {}
EquipmentSlot.__index = EquipmentSlot

--- Create a new EquipmentSlot instance
-- @param options table Configuration options
--   - x (number): X position
--   - y (number): Y position
--   - id (string): Slot identifier (e.g., "head", "chest")
--   - label (string): Display label
--   - item (table, optional): Equipped item (nil = empty)
--   - size (number, optional): Slot size (default from theme)
-- @return EquipmentSlot The new slot instance
function EquipmentSlot:new(options)
  options = options or {}

  local instance = {
    x = options.x or 0,
    y = options.y or 0,
    id = options.id or "slot",
    label = options.label or "Slot",
    item = options.item or nil,  -- nil = empty slot
    size = options.size or Theme.equipmentSlot.size,
    visible = options.visible ~= false,

    -- State
    isHovered = false,

    -- Colors
    colors = Theme.equipmentSlot.colors,
    borderWidth = Theme.equipmentSlot.borderWidth,
  }

  setmetatable(instance, self)
  return instance
end

--- Get total height including label
-- @return number Total height
function EquipmentSlot:getTotalHeight()
  local font = Theme.fonts.getByName('sm')
  return self.size + Theme.spacing.xs + font:getHeight()
end

--- Update slot state
-- @param dt number Delta time
function EquipmentSlot:update(dt)
  if not self.visible then return end

  local mx, my = love.mouse.getPosition()
  self.isHovered = self:containsPoint(mx, my)
end

--- Draw the equipment slot
function EquipmentSlot:draw()
  if not self.visible then return end

  local lg = love.graphics

  -- Draw slot background
  lg.setColor(self.colors.background)
  lg.rectangle('fill', self.x, self.y, self.size, self.size)

  -- Draw border
  local borderColor = self.isHovered and self.colors.borderHover or self.colors.border
  lg.setColor(borderColor)
  lg.setLineWidth(self.borderWidth)
  lg.rectangle('line', self.x, self.y, self.size, self.size)

  -- Draw content (item or empty indicator)
  if self.item then
    -- Future: draw item icon
    -- For now, draw item name centered
    lg.setColor(Theme.colors.text.primary)
    local font = Theme.fonts.getByName('sm')
    lg.setFont(font)
    local text = self.item.name or "Item"
    local textWidth = font:getWidth(text)
    local textX = self.x + (self.size - textWidth) / 2
    local textY = self.y + (self.size - font:getHeight()) / 2
    lg.print(text, textX, textY)
  else
    -- Draw empty state (X indicator)
    lg.setColor(self.colors.empty)
    local font = Theme.fonts.getByName('lg')
    lg.setFont(font)
    local text = "×"
    local textWidth = font:getWidth(text)
    local textX = self.x + (self.size - textWidth) / 2
    local textY = self.y + (self.size - font:getHeight()) / 2
    lg.print(text, textX, textY)
  end

  -- Draw label below slot
  lg.setColor(self.colors.label)
  local labelFont = Theme.fonts.getByName('sm')
  lg.setFont(labelFont)
  local labelWidth = labelFont:getWidth(self.label)
  local labelX = self.x + (self.size - labelWidth) / 2
  local labelY = self.y + self.size + Theme.spacing.xs
  lg.print(self.label, labelX, labelY)
end

--- Check if a point is within the slot bounds
-- @param px number X coordinate
-- @param py number Y coordinate
-- @return boolean True if point is inside slot
function EquipmentSlot:containsPoint(px, py)
  return px >= self.x and px <= self.x + self.size
     and py >= self.y and py <= self.y + self.size
end

--- Set slot position
-- @param x number X position
-- @param y number Y position
function EquipmentSlot:setPosition(x, y)
  self.x = x
  self.y = y
end

--- Set equipped item
-- @param item table Item to equip (nil to clear)
function EquipmentSlot:setItem(item)
  self.item = item
end

--- Get equipped item
-- @return table The equipped item, or nil
function EquipmentSlot:getItem()
  return self.item
end

--- Check if slot is empty
-- @return boolean True if no item equipped
function EquipmentSlot:isEmpty()
  return self.item == nil
end

--- Show or hide the slot
-- @param visible boolean Whether slot should be visible
function EquipmentSlot:setVisible(visible)
  self.visible = visible
end

--- Handle mouse press event (for future item interaction)
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the event was consumed
function EquipmentSlot:mousepressed(x, y, button)
  if not self.visible then return false end
  if button ~= 1 then return false end

  if self:containsPoint(x, y) then
    -- Future: handle item interaction
    return true
  end

  return false
end

--- Handle mouse release event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the event was consumed
function EquipmentSlot:mousereleased(x, y, button)
  return false
end

return EquipmentSlot
