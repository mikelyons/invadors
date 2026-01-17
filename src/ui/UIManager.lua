--[[
  UIManager.lua

  Manages a collection of UI elements, handling updates, drawing,
  and input event distribution.

  Usage:
    local UIManager = require('src/ui/UIManager')
    local Button = require('src/ui/Button')

    local ui = UIManager:new()

    ui:add('playButton', Button:new({text = 'Play', onClick = startGame}))
    ui:add('optionsButton', Button:new({text = 'Options', onClick = showOptions}))

    -- In update loop:
    ui:update(dt)

    -- In draw loop:
    ui:draw()

    -- In input handlers:
    ui:mousepressed(x, y, button)
    ui:mousereleased(x, y, button)
    ui:keypressed(key)
]]

local UIManager = {}
UIManager.__index = UIManager

--- Create a new UIManager instance
-- @return UIManager The new manager instance
function UIManager:new()
  local instance = {
    elements = {},         -- Named elements table
    order = {},            -- Draw order (array of names)
    focusedElement = nil,  -- Currently focused element (for keyboard nav)
    enabled = true,        -- Whether the manager processes input
    visible = true,        -- Whether elements are drawn
  }

  setmetatable(instance, self)
  return instance
end

--- Add a UI element
-- @param name string Unique identifier for the element
-- @param element table The UI element (must have update/draw methods)
-- @return table The added element
function UIManager:add(name, element)
  if self.elements[name] then
    -- Remove existing element with same name
    self:remove(name)
  end

  self.elements[name] = element
  table.insert(self.order, name)

  return element
end

--- Remove a UI element
-- @param name string The element identifier
function UIManager:remove(name)
  self.elements[name] = nil

  for i, n in ipairs(self.order) do
    if n == name then
      table.remove(self.order, i)
      break
    end
  end

  if self.focusedElement == name then
    self.focusedElement = nil
  end
end

--- Get a UI element by name
-- @param name string The element identifier
-- @return table The element, or nil if not found
function UIManager:get(name)
  return self.elements[name]
end

--- Check if an element exists
-- @param name string The element identifier
-- @return boolean True if element exists
function UIManager:has(name)
  return self.elements[name] ~= nil
end

--- Clear all UI elements
function UIManager:clear()
  self.elements = {}
  self.order = {}
  self.focusedElement = nil
end

--- Update all UI elements
-- @param dt number Delta time
function UIManager:update(dt)
  if not self.enabled then return end

  for _, name in ipairs(self.order) do
    local element = self.elements[name]
    if element and element.update then
      element:update(dt)
    end
  end
end

--- Draw all UI elements
function UIManager:draw()
  if not self.visible then return end

  for _, name in ipairs(self.order) do
    local element = self.elements[name]
    if element and element.draw then
      element:draw()
    end
  end
end

--- Handle mouse press event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if an element consumed the event
function UIManager:mousepressed(x, y, button)
  if not self.enabled then return false end

  -- Iterate in reverse order (top elements first)
  for i = #self.order, 1, -1 do
    local name = self.order[i]
    local element = self.elements[name]

    if element and element.mousepressed then
      if element:mousepressed(x, y, button) then
        return true
      end
    end
  end

  return false
end

--- Handle mouse release event
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if an element consumed the event
function UIManager:mousereleased(x, y, button)
  if not self.enabled then return false end

  -- Check all elements (any might have been pressed)
  for i = #self.order, 1, -1 do
    local name = self.order[i]
    local element = self.elements[name]

    if element and element.mousereleased then
      if element:mousereleased(x, y, button) then
        return true
      end
    end
  end

  return false
end

--- Handle key press event
-- @param key string The key that was pressed
-- @param scancode string The scancode
-- @param isrepeat boolean Whether this is a key repeat
-- @return boolean True if an element consumed the event
function UIManager:keypressed(key, scancode, isrepeat)
  if not self.enabled then return false end

  -- Handle focus navigation
  if key == 'tab' then
    self:focusNext()
    return true
  end

  -- Send to focused element
  if self.focusedElement then
    local element = self.elements[self.focusedElement]
    if element and element.keypressed then
      if element:keypressed(key, scancode, isrepeat) then
        return true
      end
    end
  end

  return false
end

--- Handle key release event
-- @param key string The key that was released
-- @param scancode string The scancode
-- @return boolean True if an element consumed the event
function UIManager:keyreleased(key, scancode)
  if not self.enabled then return false end

  if self.focusedElement then
    local element = self.elements[self.focusedElement]
    if element and element.keyreleased then
      if element:keyreleased(key, scancode) then
        return true
      end
    end
  end

  return false
end

--- Focus the next element in the order
function UIManager:focusNext()
  if #self.order == 0 then return end

  local currentIndex = 0
  if self.focusedElement then
    for i, name in ipairs(self.order) do
      if name == self.focusedElement then
        currentIndex = i
        break
      end
    end
  end

  local nextIndex = (currentIndex % #self.order) + 1
  self:setFocus(self.order[nextIndex])
end

--- Focus the previous element in the order
function UIManager:focusPrevious()
  if #self.order == 0 then return end

  local currentIndex = #self.order + 1
  if self.focusedElement then
    for i, name in ipairs(self.order) do
      if name == self.focusedElement then
        currentIndex = i
        break
      end
    end
  end

  local prevIndex = ((currentIndex - 2) % #self.order) + 1
  self:setFocus(self.order[prevIndex])
end

--- Set focus to a specific element
-- @param name string The element identifier
function UIManager:setFocus(name)
  -- Blur previous element
  if self.focusedElement and self.focusedElement ~= name then
    local prevElement = self.elements[self.focusedElement]
    if prevElement and prevElement.onBlur then
      prevElement:onBlur()
    end
  end

  self.focusedElement = name

  -- Focus new element
  if name then
    local element = self.elements[name]
    if element and element.onFocus then
      element:onFocus()
    end
  end
end

--- Clear focus
function UIManager:clearFocus()
  self:setFocus(nil)
end

--- Enable or disable the manager
-- @param enabled boolean Whether to enable input processing
function UIManager:setEnabled(enabled)
  self.enabled = enabled
end

--- Show or hide all elements
-- @param visible boolean Whether elements should be drawn
function UIManager:setVisible(visible)
  self.visible = visible
end

--- Bring an element to the front (drawn last, receives input first)
-- @param name string The element identifier
function UIManager:bringToFront(name)
  for i, n in ipairs(self.order) do
    if n == name then
      table.remove(self.order, i)
      table.insert(self.order, name)
      break
    end
  end
end

--- Send an element to the back (drawn first, receives input last)
-- @param name string The element identifier
function UIManager:sendToBack(name)
  for i, n in ipairs(self.order) do
    if n == name then
      table.remove(self.order, i)
      table.insert(self.order, 1, name)
      break
    end
  end
end

--- Get the number of elements
-- @return number Element count
function UIManager:count()
  return #self.order
end

--- Iterate over all elements
-- @return function Iterator function
function UIManager:iterate()
  local i = 0
  return function()
    i = i + 1
    if i <= #self.order then
      local name = self.order[i]
      return name, self.elements[name]
    end
  end
end

return UIManager
