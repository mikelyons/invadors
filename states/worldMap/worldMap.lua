--[[
  worldMap.lua

  World Map State - level select, travel the world

  @TODO -
  [X] basic map rendering
  [X] basic player controller
  [ ] advanced map rendering
  [ ] collisions
  [ ] advanced player
  [ ] progression data driven
  [ ] collisions, boundaries, environmental effects
  [ ] interactable environmental fixtures
  - https://github.com/karai17/Simple-Tiled-Implementation - are we on the latest?
]]

if DEBUG_LOGGING_LOADING then
  print('worldMap.lua -> ')
end
-- dependencies
local success1, sti = pcall(require, 'lib/sti')
if not success1 then
  print("Error loading sti:", sti)
  sti = nil
end

local success2, poi = pcall(require, 'states/worldMap/pois')
if not success2 then
  print("Error loading poi:", poi)
  poi = nil
end

local WM = Game:addState('worldMap') -- registering the gamestate

function WM:enteredState()
  if DEBUG_LOGGING_ON then
    print('WM -> ')
    print('WM:enteredState() ====================================')
  end
  -- Load the world map
  self.map = nil
  if sti then
    -- self.map = sti("assets/maps/worldMap/worldMap.lua")
    -- self.map = sti("assets/maps/bedroom/house3.lua") -- this wont draw!? flicker
    -- self.map = sti("assets/maps/bedroom/house3.lua")
    local success, map = pcall(sti, "assets/maps/bedroom/house2.lua")
    if success then
      self.map = map
    else
      print("Error loading map:", map)
    end
  end
  -- if poi and poi.load then poi.load(self.map) end


  -- Create player
  self.player = {
    x = 400,  -- Starting position
    y = 300,
    speed = 200,
    width = 32,
    height = 32
  }
end

function WM:exitedState() end

function WM:update(dt)
  -- Update map animations if any
  -- self.map:update(dt)
  -- Handle player movement
  local speed = self.player.speed * dt

  if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    self.player.x = self.player.x + speed
  end
  if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
    self.player.x = self.player.x - speed
  end
  if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
    self.player.y = self.player.y + speed
  end
  if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
    self.player.y = self.player.y - speed
  end
end

function WM:draw()
  -- Draw the map
  love.graphics.setColor(255, 255, 255, 255)
  -- self.map:draw() -- house3 map not drawing
  -- Draw player rectangle
  love.graphics.setColor(0, 255, 0, 255)  -- Green color for player
  love.graphics.rectangle("fill", 
    self.player.x - self.player.width/2, 
    self.player.y - self.player.height/2, 
    self.player.width, 
    self.player.height
  )

  if DEBUG_SHOW_FPS then
    love.graphics.print(
      'FPS '..tostring(love.timer.getFPS()),
      -- camera.pos.x + (windowWidth - 128),
      -- camera.pos.y + (windowHeight - 128)
      32, 32
    )
  end
end

-- Input handling
function WM:keypressed(key)
  if key == 'escape' then
    -- self:gotoState('menu')
    self:popState('worldMap')
  end
end
