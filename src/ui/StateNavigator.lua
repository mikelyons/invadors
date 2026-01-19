--[[
  StateNavigator.lua

  A global debug menu for navigating between game states.
  Toggle with F2 key from anywhere in the game.

  Usage:
    -- In main.lua after Game is initialized:
    local StateNavigator = require('src/ui/StateNavigator')
    StateNavigator:init(Game)

    -- In love.keypressed (before game:keypressed):
    if StateNavigator:keypressed(key) then return end

    -- In love.draw (after everything else):
    StateNavigator:draw()

    -- In love.update:
    StateNavigator:update(dt)

    -- In love.mousepressed:
    StateNavigator:mousepressed(x, y, button)
]]

local DebugMenu = require('src/ui/debug_menu')

local StateNavigator = {}

-- Internal state
StateNavigator.menu = nil
StateNavigator.game = nil
StateNavigator.initialized = false
StateNavigator.toggleKey = "f2"

--- Initialize the StateNavigator with the Game class
-- @param gameClass The Game class (with states)
function StateNavigator:init(gameClass)
  if self.initialized then return end

  self.game = gameClass

  -- Create the debug menu
  self.menu = DebugMenu:new({
    title = "State Navigator (F2)",
    x = 20,
    y = 100,
    width = 280,
    itemHeight = 26,
  })

  -- Customize colors slightly
  self.menu.colors.title = {0.3, 1, 0.5, 1}
  self.menu.colors.selectedText = {1, 1, 0.3, 1}

  -- Populate with states
  self:refreshStates()

  self.initialized = true
  print("StateNavigator: Initialized")
end

--- Refresh the list of available states
function StateNavigator:refreshStates()
  if not self.menu then return end

  self.menu:clear()

  -- Get all registered states from the Game class
  local states = {}

  if self.game and self.game.states then
    for stateName, _ in pairs(self.game.states) do
      table.insert(states, stateName)
    end
  end

  -- Sort alphabetically
  table.sort(states)

  -- Add current state indicator at top
  self.menu:addSeparator("Current State")
  local currentStateName = self:getCurrentStateName()
  self.menu:addItem(">> " .. (currentStateName or "unknown"), function()
    -- Do nothing, just shows current state
  end)

  self.menu:addSeparator("All States (" .. #states .. ")")

  -- Add all states as menu items
  for _, stateName in ipairs(states) do
    local displayName = stateName
    if stateName == currentStateName then
      displayName = stateName .. " *"
    end

    self.menu:addItem(displayName, function()
      self:gotoState(stateName)
    end, stateName)
  end

  -- Add utility options at bottom
  self.menu:addSeparator("Actions")
  self.menu:addItem("Refresh List", function()
    self:refreshStates()
  end)
  self.menu:addItem("Close Menu", function()
    self.menu:hide()
  end)
end

--- Get the name of the current state
-- @return string|nil The current state name
function StateNavigator:getCurrentStateName()
  if not self.game then return nil end

  -- Try to find current state name
  -- The Stateful library stores the current state differently
  -- We need to check the __stateStack or current state reference

  if self.game.states and game then
    -- Check the state stack
    if game.__stateStack then
      for i = #game.__stateStack, 1, -1 do
        local state = game.__stateStack[i]
        -- Find the name of this state
        for name, stateClass in pairs(self.game.states) do
          if state == stateClass or (state and state.class == stateClass) then
            return name
          end
        end
      end
    end

    -- Fallback: check currentState
    if game.currentState then
      for name, stateClass in pairs(self.game.states) do
        if game.currentState == stateClass then
          return name
        end
      end
    end
  end

  return nil
end

--- Navigate to a specific state
-- @param stateName string The name of the state to navigate to
function StateNavigator:gotoState(stateName)
  if not game then
    print("StateNavigator: No game instance available")
    return
  end

  print("StateNavigator: Going to state:", stateName)

  local success, err = pcall(function()
    game:gotoState(stateName)
  end)

  if success then
    print("StateNavigator: Successfully changed to state:", stateName)
    self:refreshStates()  -- Update the current state indicator
  else
    print("StateNavigator: Failed to change state:", err)
  end

  -- Optionally close the menu after navigation
  -- self.menu:hide()
end

--- Toggle the menu visibility
function StateNavigator:toggle()
  if not self.menu then return end
  self.menu:toggle()
  if self.menu:isVisible() then
    self:refreshStates()  -- Refresh when opening
  end
end

--- Show the menu
function StateNavigator:show()
  if not self.menu then return end
  self:refreshStates()
  self.menu:show()
end

--- Hide the menu
function StateNavigator:hide()
  if not self.menu then return end
  self.menu:hide()
end

--- Check if menu is visible
-- @return boolean
function StateNavigator:isVisible()
  return self.menu and self.menu:isVisible()
end

--- Update the menu
-- @param dt number Delta time
function StateNavigator:update(dt)
  if not self.menu then return end
  self.menu:update(dt)
end

--- Draw the menu
function StateNavigator:draw()
  if not self.menu then return end
  self.menu:draw()
end

--- Handle key press
-- @param key string The key pressed
-- @return boolean True if the key was handled
function StateNavigator:keypressed(key)
  -- Toggle key
  if key == self.toggleKey then
    self:toggle()
    return true
  end

  -- If menu is visible, handle navigation keys
  if self.menu and self.menu:isVisible() then
    return self.menu:keypressed(key)
  end

  return false
end

--- Handle mouse press
-- @param x number Mouse X position
-- @param y number Mouse Y position
-- @param button number Mouse button
-- @return boolean True if the click was handled
function StateNavigator:mousepressed(x, y, button)
  if not self.menu then return false end
  return self.menu:mousepressed(x, y, button)
end

return StateNavigator
