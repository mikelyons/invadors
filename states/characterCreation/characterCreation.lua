--[[
  characterCreation.lua
  menu 8

  Three-panel character creation screen:
  - Left Panel: Physical stats (Strength, Agility, Constitution, Height, Weight)
  - Center Panel: Real-time character body preview
  - Right Panel: Equipment slots mockup (Head, Chest, Hands, Legs, Feet)
]]
print('characterCreation.lua -> ')

-- Dependencies
local Theme = require('src/ui/theme')
local UIManager = require('src/ui/UIManager')
local Panel = require('src/ui/Panel')
local StatSlider = require('src/ui/StatSlider')
local EquipmentSlot = require('src/ui/EquipmentSlot')
local Button = require('src/ui/Button')
local CharacterStats = require('states/characterCreation/CharacterStats')
local BodyRenderer = require('states/characterCreation/BodyRenderer')

-- Optional: fanfic text input library
local fanfic = nil
local success, result = pcall(require, 'lib/fanfic')
if success then
  fanfic = result
end

-- Register the gamestate
local characterSheet = Game:addState('characterCreation')
print("CharacterCreation: Gamestate registered")

-- Local state variables
local ui = nil
local leftPanel = nil
local centerPanel = nil
local rightPanel = nil
local sliders = {}
local equipmentSlots = {}
local bodyRenderer = nil
local nameInput = nil
local confirmButton = nil
local resetButton = nil

-- Equipment slot definitions
local EQUIPMENT_SLOTS = {
  {id = "head", label = "Head"},
  {id = "chest", label = "Chest"},
  {id = "hands", label = "Hands"},
  {id = "legs", label = "Legs"},
  {id = "feet", label = "Feet"},
}

--- Calculate panel dimensions based on screen size
local function calculateLayout()
  local screenW = love.graphics.getWidth()
  local screenH = love.graphics.getHeight()

  local headerHeight = Theme.characterCreation.headerHeight
  local panelGap = Theme.characterCreation.panelGap
  local ratios = Theme.characterCreation.panelRatios

  local contentY = headerHeight
  local contentH = screenH - headerHeight

  -- Calculate panel widths
  local totalGaps = panelGap * 2
  local availableW = screenW - totalGaps
  local leftW = availableW * ratios[1]
  local centerW = availableW * ratios[2]
  local rightW = availableW * ratios[3]

  return {
    screen = {w = screenW, h = screenH},
    header = {y = 0, h = headerHeight},
    left = {x = 0, y = contentY, w = leftW, h = contentH},
    center = {x = leftW + panelGap, y = contentY, w = centerW, h = contentH},
    right = {x = leftW + centerW + (panelGap * 2), y = contentY, w = rightW, h = contentH},
  }
end

--- Create stat sliders in the left panel
local function createSliders(panel)
  local cx, cy, cw, ch = panel:getContentArea()
  local statOrder = CharacterStats:getStatOrder()
  local sliderHeight = 50  -- Approximate height per slider
  local spacing = Theme.spacing.md

  sliders = {}

  for i, statKey in ipairs(statOrder) do
    local def = CharacterStats.DEFINITIONS[statKey]
    local y = cy + ((i - 1) * (sliderHeight + spacing))

    local slider = StatSlider:new({
      x = cx,
      y = y,
      width = cw,
      label = def.label,
      min = def.min,
      max = def.max,
      value = _G.character.stats[statKey],
      step = 1,
      onChange = function(value)
        _G.character.stats[statKey] = value
      end,
    })

    sliders[statKey] = slider
    ui:add('slider_' .. statKey, slider)
  end
end

--- Create equipment slots in the right panel
local function createEquipmentSlots(panel)
  local cx, cy, cw, ch = panel:getContentArea()
  local slotSize = Theme.equipmentSlot.size
  local spacing = Theme.equipmentSlot.spacing

  -- Center slots horizontally in panel
  local slotX = cx + (cw - slotSize) / 2

  equipmentSlots = {}

  for i, slotDef in ipairs(EQUIPMENT_SLOTS) do
    local slotHeight = slotSize + spacing + Theme.fonts.getByName('sm'):getHeight()
    local y = cy + ((i - 1) * (slotHeight + spacing))

    local slot = EquipmentSlot:new({
      x = slotX,
      y = y,
      id = slotDef.id,
      label = slotDef.label,
    })

    equipmentSlots[slotDef.id] = slot
    ui:add('slot_' .. slotDef.id, slot)
  end
end

--- Create buttons (Confirm and Reset)
local function createButtons(layout)
  local screenW = layout.screen.w
  local buttonWidth = 120
  local buttonHeight = 40
  local buttonY = layout.header.h / 2 - buttonHeight / 2
  local buttonSpacing = Theme.spacing.md

  -- Confirm button (right side of header)
  confirmButton = Button:new({
    text = "Confirm",
    x = screenW - buttonWidth - Theme.spacing.lg,
    y = buttonY,
    width = buttonWidth,
    height = buttonHeight,
    onClick = function()
      -- Save character and proceed
      print("Character created:", _G.character.name)
      Game:gotoState('generate')
    end,
  })
  ui:add('confirmButton', confirmButton)

  -- Reset button (left of confirm)
  resetButton = Button:new({
    text = "Reset",
    x = screenW - (buttonWidth * 2) - Theme.spacing.lg - buttonSpacing,
    y = buttonY,
    width = buttonWidth,
    height = buttonHeight,
    onClick = function()
      -- Reset stats to defaults
      _G.character.stats = CharacterStats:new()
      -- Update sliders
      for statKey, slider in pairs(sliders) do
        slider:setValue(_G.character.stats[statKey])
      end
    end,
  })
  ui:add('resetButton', resetButton)
end

function characterSheet:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER characterCreation STATE - %s", os.date()))
  end

  -- Initialize global character data
  _G.character = {
    name = '',
    stats = CharacterStats:new(),
    avatar = {},
    equipment = {},
  }

  -- Initialize equipment slots
  for _, slotDef in ipairs(EQUIPMENT_SLOTS) do
    _G.character.equipment[slotDef.id] = nil
  end

  -- Create UI manager
  ui = UIManager:new()

  -- Calculate layout
  local layout = calculateLayout()

  -- Create panels
  leftPanel = Panel:new({
    x = layout.left.x,
    y = layout.left.y,
    width = layout.left.w,
    height = layout.left.h,
    title = "Stats",
  })
  ui:add('leftPanel', leftPanel)

  centerPanel = Panel:new({
    x = layout.center.x,
    y = layout.center.y,
    width = layout.center.w,
    height = layout.center.h,
    title = "Preview",
  })
  ui:add('centerPanel', centerPanel)

  rightPanel = Panel:new({
    x = layout.right.x,
    y = layout.right.y,
    width = layout.right.w,
    height = layout.right.h,
    title = "Equipment",
  })
  ui:add('rightPanel', rightPanel)

  -- Create sliders
  createSliders(leftPanel)

  -- Create equipment slots
  createEquipmentSlots(rightPanel)

  -- Create body renderer
  bodyRenderer = BodyRenderer:new()

  -- Create buttons
  createButtons(layout)

  -- Initialize name input if fanfic is available
  if fanfic then
    local inputX = Theme.spacing.lg + 200
    local inputY = layout.header.h / 2 - 10
    nameInput = fanfic.new(inputX, inputY, "Name:", false, nil, 20)
  end

  print("CharacterCreation: State entered successfully")
end

function characterSheet:update(dt)
  -- Update UI elements
  ui:update(dt)

  -- Update name input
  if nameInput and nameInput.update then
    nameInput:update(dt)
    local data = nameInput:enteredText()
    if data then
      _G.character.name = data
    end
  end

  -- Update body renderer with current stats
  bodyRenderer:updateParams(_G.character.stats)
end

function characterSheet:draw()
  local lg = love.graphics

  -- Draw background
  lg.setColor(Theme.colors.background.dark)
  lg.rectangle('fill', 0, 0, lg.getWidth(), lg.getHeight())

  -- Draw header background
  lg.setColor(Theme.colors.panel.header)
  lg.rectangle('fill', 0, 0, lg.getWidth(), Theme.characterCreation.headerHeight)

  -- Draw title
  lg.setColor(Theme.colors.text.primary)
  local titleFont = Theme.fonts.getByName('xl')
  lg.setFont(titleFont)
  lg.print("Create Your Character", Theme.spacing.lg, (Theme.characterCreation.headerHeight - titleFont:getHeight()) / 2)

  -- Draw character name if entered
  if _G.character.name and _G.character.name ~= '' then
    lg.setColor(Theme.colors.accent)
    local nameFont = Theme.fonts.getByName('lg')
    lg.setFont(nameFont)
    local nameX = Theme.spacing.lg + 250
    local nameY = (Theme.characterCreation.headerHeight - nameFont:getHeight()) / 2
    lg.print(_G.character.name, nameX, nameY)
  end

  -- Draw all UI elements (panels, sliders, slots, buttons)
  ui:draw()

  -- Draw body preview in center panel
  bodyRenderer:drawInPanel(centerPanel)

  -- Draw name input
  if nameInput and nameInput.draw then
    nameInput:draw()
  end
end

function characterSheet:exitedState()
  -- Clean up
  ui:clear()
  ui = nil
  leftPanel = nil
  centerPanel = nil
  rightPanel = nil
  sliders = {}
  equipmentSlots = {}
  bodyRenderer = nil
  nameInput = nil

  print("CharacterCreation: State exited")
end

-- Input handlers
function characterSheet:mousepressed(x, y, button, istouch)
  if ui then
    ui:mousepressed(x, y, button)
  end
end

function characterSheet:mousereleased(x, y, button)
  if ui then
    ui:mousereleased(x, y, button)
  end
end

function characterSheet:keypressed(key, code)
  -- Forward to name input
  if nameInput and nameInput.keypressed then
    nameInput:keypressed(key, code)
  end

  -- ESC to go back
  if key == 'escape' then
    self:popState()
  end
end

function characterSheet:resize(w, h)
  -- Recalculate layout on window resize
  if ui then
    local layout = calculateLayout()

    -- Update panel positions
    if leftPanel then
      leftPanel:setPosition(layout.left.x, layout.left.y)
      leftPanel:setSize(layout.left.w, layout.left.h)
    end

    if centerPanel then
      centerPanel:setPosition(layout.center.x, layout.center.y)
      centerPanel:setSize(layout.center.w, layout.center.h)
    end

    if rightPanel then
      rightPanel:setPosition(layout.right.x, layout.right.y)
      rightPanel:setSize(layout.right.w, layout.right.h)
    end

    -- Recreate sliders and equipment slots with new positions
    -- (simplified - just update panel refs, sliders stay in old positions)
    -- For full responsiveness, would need to recreate sliders here
  end
end
