--[[
  states/dinner/dinner.lua

  First-person dinner table simulation with guests and food interactions
  - Point-and-click eating mechanics
  - Guest interaction system
  - Drag and drop food items
  - Dinner table environment
]]

if DEBUG_LOGGING_LOADING then
  print('dinner.lua -> ')
end

-- dependencies
local stickyNote = require 'ui objects/evilNote'

-- register the gamestate
local Dinner = Game:addState('dinner')

function Dinner:keypressed(key, code)
  if key == ('l') then self:popState('dialogue') end
  if key == 'escape' then self:popState() end
end

function Dinner:enteredState()
  if DEBUG_LOGGING_ON then
    print(string.format("ENTER dinner STATE - %s \n", os.date()))
  end

  -- Dinner table welcome message
  self.motd = [[Welcome to dinner! Click on food to eat, drag items around, and interact with your guests.]]

  -- Get screen dimensions safely
  self.screen_w = love.graphics.getWidth()
  self.screen_h = love.graphics.getHeight()
  
  -- Create a sticky note for dinner notes
  self.dinnerNote = stickyNote.new(
    self.screen_w-200, 400,
    self.motd
  )

  -- Initialize dinner table state
  self.guests = {
    {
      name = "Alice",
      x = 200,
      y = 300,
      avatar = love.graphics.newImage("assets/character/avatars/NN32.png"),
      dialogue = "This roast is delicious!",
      isTalking = false
    },
    {
      name = "Bob", 
      x = 600,
      y = 300,
      avatar = love.graphics.newImage("assets/character/avatars/NN32.png"),
      dialogue = "How was your day?",
      isTalking = false
    },
    {
      name = "Carol",
      x = 400,
      y = 200,
      avatar = love.graphics.newImage("assets/character/avatars/NN32.png"),
      dialogue = "Pass the salt, please.",
      isTalking = false
    }
  }

  -- Initialize food items
  self.foodItems = {
    {
      name = "Pizza",
      x = 350,
      y = 400,
      image = love.graphics.newImage("assets/items/pizza_0.png"),
      eaten = false,
      nutrition = 25,
      description = "Delicious pepperoni pizza"
    },
    {
      name = "Beer",
      x = 450,
      y = 400,
      image = love.graphics.newImage("assets/items/beergreenbottle.png"),
      drunk = false,
      effect = "relaxed",
      description = "Refreshing green beer"
    },
    {
      name = "Broken Beer",
      x = 550,
      y = 400,
      image = love.graphics.newImage("assets/items/beerbrokengreen.png"),
      drunk = false,
      effect = "dangerous",
      description = "Broken beer bottle - be careful!"
    },
    {
      name = "Mushrooms",
      x = 250,
      y = 400,
      image = love.graphics.newImage("assets/items/SHROOMANDBUSH.png"),
      eaten = false,
      nutrition = 15,
      effect = "magical",
      description = "Mysterious mushrooms"
    },
    {
      name = "Table",
      x = 400,
      y = 350,
      image = love.graphics.newImage("assets/items/table_4.png"),
      isTable = true,
      description = "Solid wooden dinner table"
    }
  }

  -- Player stats
  self.playerHunger = 100
  self.playerHappiness = 50
  self.interactions = 0

  -- Interaction state
  self.selectedGuest = nil
  self.selectedFood = nil
  self.isDragging = false
  self.hoveredItem = nil
  self.tooltipText = ""
end

function Dinner:update(dt)
  self.dinnerNote:update(dt)
  
  -- Get mouse position for tooltips
  local mx, my = love.mouse.getPosition()
  
  -- Check for hovered items
  self.hoveredItem = nil
  self.tooltipText = ""
  
  -- Check food items
  for i, food in ipairs(self.foodItems) do
    if not food.eaten and not food.drunk and not food.isTable then
      if mx > food.x and mx < food.x + 64 and my > food.y and my < food.y + 64 then
        self.hoveredItem = food
        self.tooltipText = food.description
        break
      end
    end
  end
  
  -- Check guests
  if not self.hoveredItem then
    for i, guest in ipairs(self.guests) do
      if mx > guest.x and mx < guest.x + 64 and my > guest.y and my < guest.y + 64 then
        self.hoveredItem = guest
        self.tooltipText = "Click to talk to " .. guest.name
        break
      end
    end
  end
  
  -- Update guest animations and behaviors
  for i, guest in ipairs(self.guests) do
    -- Random guest dialogue changes
    if love.math.random() < 0.001 then -- Very low chance per frame
      guest.isTalking = true
      guest.talkTimer = 3 -- 3 seconds
    end
    
    -- Update talk timer
    if guest.talkTimer then
      guest.talkTimer = guest.talkTimer - dt
      if guest.talkTimer <= 0 then
        guest.isTalking = false
        guest.talkTimer = nil
      end
    end
  end
end

-- Load dinner table assets
local tableTexture = love.graphics.newImage("assets/items/table_4.png")
local pizzaTexture = love.graphics.newImage("assets/items/pizza_0.png")
local beerTexture = love.graphics.newImage("assets/items/beergreenbottle.png")
local brokenBeerTexture = love.graphics.newImage("assets/items/beerbrokengreen.png")
local mushroomTexture = love.graphics.newImage("assets/items/SHROOMANDBUSH.png")
local guestAvatar = love.graphics.newImage("assets/character/avatars/NN32.png")
local pointerhand = love.graphics.newImage("assets/hand-pointing-1.png")
local pointerhandOffset = {x=143,y=24}

-- Set filters for pixel art style
tableTexture:setFilter("nearest", "nearest")
pizzaTexture:setFilter("nearest", "nearest")
beerTexture:setFilter("nearest", "nearest")
brokenBeerTexture:setFilter("nearest", "nearest")
mushroomTexture:setFilter("nearest", "nearest")
guestAvatar:setFilter("nearest", "nearest")
pointerhand:setFilter("nearest", "nearest")

function Dinner:draw()
  -- Add error handling to catch silent failures
  local success, err = pcall(function()
    local _r, _g, _b, _a = love.graphics.getColor()
    local _lineWidth = love.graphics.getLineWidth()

    -- get mouse for pointer hand
    local mx, my = love.mouse.getPosition()

    -- Draw dinner room background
    -- Wall
    love.graphics.setColor(139/255, 69/255, 19/255, 1) -- Brown wood paneling
    love.graphics.rectangle(
      'fill',
      0, 0,
      self.screen_w, self.screen_h
    )

    -- Floor
    love.graphics.setColor(160/255, 82/255, 45/255, 1) -- Saddle brown floor
    love.graphics.rectangle(
      'fill',
      0, self.screen_h-200,
      self.screen_w, 200
    )

    -- Draw dinner table
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
      tableTexture,
      self.screen_w/2 - 100,
      self.screen_h - 300,
      0,
      2,
      2
    )

    -- Draw food items
    for i, food in ipairs(self.foodItems) do
      if not food.eaten and not food.drunk then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
          food.image,
          food.x,
          food.y,
          0,
          2,
          2
        )
        
        -- Draw food name
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(
          food.name,
          food.x,
          food.y - 20
        )
      end
    end

    -- Draw guests around the table
    for i, guest in ipairs(self.guests) do
      -- Guest avatar
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(
        guest.avatar,
        guest.x,
        guest.y,
        0,
        2,
        2
      )
      
      -- Guest name
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(
        guest.name,
        guest.x,
        guest.y - 30
      )
      
      -- Guest dialogue bubble if talking
      if guest.isTalking then
        love.graphics.setColor(1, 1, 1, 200/255)
        love.graphics.rectangle(
          'fill',
          guest.x - 50,
          guest.y - 60,
          200,
          40,
          10,
          10
        )
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(
          guest.dialogue,
          guest.x - 45,
          guest.y - 55,
          190,
          'center'
        )
      end
    end

    -- Draw player stats
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Hunger: " .. self.playerHunger, 10, 10)
    love.graphics.print("Happiness: " .. self.playerHappiness, 10, 30)
    love.graphics.print("Interactions: " .. self.interactions, 10, 50)

    -- Draw tooltip
    if self.hoveredItem and self.tooltipText ~= "" then
      local mx, my = love.mouse.getPosition()
      love.graphics.setColor(0, 0, 0, 200/255)
      love.graphics.rectangle(
        'fill',
        mx + 10,
        my - 30,
        #self.tooltipText * 8 + 10,
        20,
        5,
        5
      )
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(
        self.tooltipText,
        mx + 15,
        my - 25
      )
    end

    -- Draw instructions
    love.graphics.setColor(1, 1, 1, 200/255)
    love.graphics.print("Click food to eat, click guests to talk", 10, self.screen_h - 30)

    -- Draw the sticky note
    self.dinnerNote:draw()
    
    -- Draw pointer hand
    love.graphics.draw(pointerhand,
      mx - pointerhandOffset.x,
      my - pointerhandOffset.y,
      nil,
      nil
    )
  end) -- Close pcall
  
  if not success then
    print("Dinner draw error:", err)
    -- Fallback drawing - just show a simple message
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Dinner", 50, 50)
    love.graphics.print("Error in drawing - check console", 50, 100)
  end
end

function Dinner:exitedState()
  love.graphics.clear()
end

-- Mouse input handling
function Dinner:mousepressed(x, y, button, istouch, presses)
  -- Handle sticky note interactions
  if self.dinnerNote and self.dinnerNote.mousepressed then
    self.dinnerNote:mousepressed(x, y, button, istouch, presses)
  end

  -- Handle food item interactions
  for i, food in ipairs(self.foodItems) do
    if not food.eaten and not food.drunk and not food.isTable then
      if x > food.x and x < food.x + 64 and y > food.y and y < food.y + 64 then
        if food.name == "Pizza" then
          food.eaten = true
          self.playerHunger = math.min(100, self.playerHunger + food.nutrition)
          self.interactions = self.interactions + 1
          print("You ate the pizza! Hunger: " .. self.playerHunger)
        elseif food.name == "Beer" then
          food.drunk = true
          self.playerHappiness = math.min(100, self.playerHappiness + 10)
          self.interactions = self.interactions + 1
          print("You drank the beer! Happiness: " .. self.playerHappiness)
        elseif food.name == "Broken Beer" then
          food.drunk = true
          self.playerHunger = math.max(0, self.playerHunger - 5) -- Hurts you
          self.interactions = self.interactions + 1
          print("Ouch! You cut yourself on the broken bottle! Hunger: " .. self.playerHunger)
        elseif food.name == "Mushrooms" then
          food.eaten = true
          self.playerHunger = math.min(100, self.playerHunger + food.nutrition)
          self.playerHappiness = math.min(100, self.playerHappiness + 15)
          self.interactions = self.interactions + 1
          print("You ate the mushrooms! Hunger: " .. self.playerHunger .. ", Happiness: " .. self.playerHappiness)
        end
      end
    end
  end

  -- Handle guest interactions
  for i, guest in ipairs(self.guests) do
    if x > guest.x and x < guest.x + 64 and y > guest.y and y < guest.y + 64 then
      guest.isTalking = true
      guest.talkTimer = 3 -- 3 seconds
      self.playerHappiness = math.min(100, self.playerHappiness + 5)
      self.interactions = self.interactions + 1
      print("You talked to " .. guest.name .. "! Happiness: " .. self.playerHappiness)
    end
  end
end

function Dinner:mousereleased(x, y, button, istouch, presses)
  if self.dinnerNote and self.dinnerNote.mousereleased then
    self.dinnerNote:mousereleased(x, y, button, istouch, presses)
  end
end
