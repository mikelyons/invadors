--[[
  generate.lua

  The side-scroller game scene
  
  Uses tiled maps, collisions, generation and chunks

  This game mode was meant to be an infinite generating world
  hence the name "generate", this is still in the WIPs, but for
  now will load custom maps made in the Tiled map editor

  @TODO
  - fix cameras and stuff, everything seems pretty busted ugh
  - http://higherorderfun.com/blog/2012/05/20/the-guide-to-implementing-2d-platformers/
]]

-- require '/lib/fanfic'
-- text = fanfic.new(200,300, "New textbox", false, 16)
-- function test()
--   text = fanfic.new(200,300, "New textbox", false, 16)
-- end
-- function test()

-- print(pcall(test, nil))

require("../../objects/coin")
local floor = math.floor
local DebugMenu = require('src/ui/debug_menu')

-- Example gamestate directory main file
-- registering the gamestate
local generate = Game:addState('generate')

-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer
-- Libraries

-- WIP
entity_factory =  require 'entity_factory'

-- Video background system extracted to: src/experimental/video_slideshow.lua
-- See that file for documentation on the image assets to remove

-- Stub function (original implementation moved to src/experimental/video_slideshow.lua)
local function drawBackground(draw)
  -- no-op: video slideshow disabled
end

-- Available maps for debug menu
local availableMaps = {
    {name = "Bedroom - House 1", path = "bedroom/house1"},
    {name = "Bedroom - House 2", path = "bedroom/house2"},
    {name = "Bedroom - House 3", path = "bedroom/house3"},
    {name = "Bedroom - Underground", path = "bedroom/underground"},
    {name = "Test - Stonebox", path = "test/stonebox"},
    {name = "Test - Basic", path = "test/test"},
    {name = "Test 2", path = "test2/test"},
    {name = "Test 2 (alt)", path = "test2/test2"},
    {name = "Generator Template", path = "generator/template"},
    {name = "Infinite", path = "infinite/infinite"},
}

-- Debug menu instance (created in enteredState)
local debugMenu = nil
local currentMapPath = "bedroom/house1"
local isChunkGenerated = false  -- Track if we're using chunk generation vs custom map

-- Function to switch to chunk-generated world
local function switchToChunkGeneration()
    print("DEBUG MENU: Switching to chunk-generated world")
    currentMapPath = "[Chunk Generated]"
    isChunkGenerated = true

    -- Clear existing entities
    if ActiveCoins then
        for i = #ActiveCoins, 1, -1 do
            table.remove(ActiveCoins, i)
        end
    end

    -- Reinitialize tile manager in chunk mode
    tlm.customMap = false
    tlm.map = nil
    tlm.tiles = {}
    tlm.chunks = {}
    tlm.chunksByStrKey = {}

    -- Reload TLM in chunk generation mode
    local success, err = pcall(function()
        tlm:load(false)  -- false = chunk generation mode
    end)

    if success then
        print("DEBUG MENU: Chunk generation initialized")
    else
        print("DEBUG MENU: Failed to initialize chunks - " .. tostring(err))
    end

    -- Respawn player at center of first chunk
    local player = obm:get_closest_by_id(nil, "player")
    if player then
        player.pos.x = 256  -- Center of chunk
        player.pos.y = 256
        player.vel.x = 0
        player.vel.y = 0
    end

    -- Respawn some coins
    Coin.new(300, 200)
    Coin.new(400, 300)
    Coin.new(500, 250)

    -- Hide the debug menu after loading
    if debugMenu then
        debugMenu:hide()
    end
end

-- Function to reload the level with a new map
local function reloadWithMap(mapPath)
    print("DEBUG MENU: Loading map: " .. mapPath)
    currentMapPath = mapPath

    -- Clear existing entities
    if ActiveCoins then
        for i = #ActiveCoins, 1, -1 do
            table.remove(ActiveCoins, i)
        end
    end

    -- Reload tile manager with new map
    tlm.customMap = true
    tlm.map = nil
    tlm.tiles = {}

    -- Clear the package cache for the old map so it reloads fresh
    local mapModule = "assets/maps/" .. mapPath
    package.loaded[mapModule] = nil

    -- Load the new map
    local success, err = pcall(function()
        tlm:loadMap(mapPath)
    end)

    if success then
        print("DEBUG MENU: Map loaded successfully")
    else
        print("DEBUG MENU: Failed to load map - " .. tostring(err))
    end

    -- Respawn player at start position
    local player = obm:get_closest_by_id(nil, "player")
    if player then
        player.pos.x = 32
        player.pos.y = 32
        player.vel.x = 0
        player.vel.y = 0
    end

    -- Respawn some coins
    Coin.new(200, 200)
    Coin.new(400, 300)
    Coin.new(500, 250)

    -- Hide the debug menu after loading
    if debugMenu then
        debugMenu:hide()
    end
end

-- Initialize the debug menu with map options
local function initDebugMenu()
    debugMenu = DebugMenu:new({
        title = "Debug Menu (F1 to toggle)",
        x = 20,
        y = 60,
        width = 300,
    })

    -- World generation mode
    debugMenu:addSeparator("-- World Mode --")

    local chunkLabel = "Procedural Chunks (Infinite)"
    if isChunkGenerated then
        chunkLabel = "> " .. chunkLabel .. " (current)"
    end
    debugMenu:addItem(chunkLabel, function()
        switchToChunkGeneration()
        -- Reinitialize menu to update current marker
        initDebugMenu()
        debugMenu:show()
    end)

    -- Tiled maps
    debugMenu:addSeparator("-- Tiled Maps --")

    for _, mapInfo in ipairs(availableMaps) do
        local label = mapInfo.name
        if mapInfo.path == currentMapPath and not isChunkGenerated then
            label = "> " .. label .. " (current)"
        end
        debugMenu:addItem(label, function()
            isChunkGenerated = false
            reloadWithMap(mapInfo.path)
            -- Reinitialize menu to update current marker
            initDebugMenu()
            debugMenu:show()
        end, mapInfo.path)
    end

    -- Utility functions
    debugMenu:addSeparator("-- Utilities --")

    debugMenu:addItem("Respawn Player", function()
        local player = obm:get_closest_by_id(nil, "player")
        if player then
            player.pos.x = 32
            player.pos.y = 32
            player.vel.x = 0
            player.vel.y = 0
        end
        debugMenu:hide()
    end)

    debugMenu:addItem("Reset Camera", function()
        camera.pos.x = 0
        camera.pos.y = 0
        camera.scale.x = 1
        camera.scale.y = 1
        debugMenu:hide()
    end)

    debugMenu:addItem("Toggle Grid (DEBUG_GRID_ON)", function()
        DEBUG_GRID_ON = not DEBUG_GRID_ON
        print("DEBUG_GRID_ON = " .. tostring(DEBUG_GRID_ON))
        debugMenu:hide()
    end)

    debugMenu:addItem("Toggle Hitboxes (DEBUG_HITBOX_VIS)", function()
        DEBUG_HITBOX_VIS = not DEBUG_HITBOX_VIS
        print("DEBUG_HITBOX_VIS = " .. tostring(DEBUG_HITBOX_VIS))
        debugMenu:hide()
    end)
end

-- -----------------------------------------
--
--
-- ENTERED STATE
--
--
-- -----------------------------------------

function generate:enteredState()
  print('ENTERED generate directory STATE!')
  -- generate.editmode = false
  generate.editmode = true

  print("=================================")
  print("=================================")
  print("=================================")
  print("===       GENERATE            ===")
  if generate.editmode then
    print("===     EDITOR  MODE          ===")
  end
  print("flags:".."")
  print("=================================")
  print("=================================")
  print("=================================")

  -- why doesn't this work? (should I use this to render more efficiently?)
  -- renderer:addRenderer(self, 2)
  -- gameloop:addLoop(self)

  camera.scale.x = 1
  camera.scale.y = 1

  asm:load() -- load asset manager

  -- switch for loading custom map vs generating
  local customMap = true
  -- local customMap = false

  tlm:load(customMap) -- load tile manager
  obm:load() -- load object manager

  -- what are these used for?
  self.chunks = {}
  self.chunks.x = {}

  -- menu of custom maps
  if customMap then -- load the custom map
    print("custom map")
    -- broken
    -- tlm:loadMap('test/stonebox')
    -- broken (sorta)
    -- tlm:loadMap('test/test-simplify')

  -- load the map from file
  -- tlm:loadMap('test/test') -- broken
  -- tlm:loadMap('generator/template') -- broken
  -- tlm:loadMap('test2/test2')
  -- tlm:loadMap('test2/test')
  -- tlm:loadMap('testMap')

    -- renders multiple layers WITHOUT collisions
    -- ACUTALLY some collision code works here but all others are broken
    -- character doesn't render tho
    tlm:loadMap('bedroom/house1')

    -- newest version of Tiled doesn't work :(
    -- tlm:loadMap('bedroom/house2')

    -- renders with collisions
    -- tlm:loadMap('test2/test')
    -- tlm:loadMap('generator/template')


  else
    print("generating map")
    -- load
    -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')
  end

  -- does this prevent spawning
  -- a player before some race condition?
  love.timer.sleep(0.25)

  obm:add(require('objects/player'):new(32, 32))
  obm:add(require('objects/zombie'):new(320,180))
  obm:add(require( 'objects/item' ):new(320,280))

  Coin.new(200, 200)
  Coin.new(400, 300)
  Coin.new(500, 250)

  -- Initialize debug menu
  initDebugMenu()

  print(" -> GENERATE STATE ENTERED -> ")
end

function generate:exitedState()

  -- figure out why mouse gets off when we pause
  -- camera:goToPoint({x=0,y=0})
  -- player.pos.move(0,0)

  -- love.graphics.clear()
  -- destroy buttons, menus, etc
  -- world:remove(player)
  -- for _,block in ipairs(blocks) do
  --   --mark blocks for removal
  --   world:remove(block)
  -- end
  -- blocks = {} --zero out the array?

  -- erase this state on exit
  -- love.graphics.clear()
end


function generate:update(dt)
  -- Update debug menu (handles mouse hover)
  if debugMenu then
    debugMenu:update(dt)
  end

  -- Skip game updates if debug menu is open
  if debugMenu and debugMenu:isVisible() then
    return
  end

  -- @todo -  this is busted
    -- testing camera movement transformation
    -- g_GameTime = g_GameTime + dt
    -- camera.pos.x = camera.pos.x + math.cos(g_GameTime)
    -- camera.pos.x = camera.pos.x + math.cos(g_GameTime) -- jiggle the camera
  gameloop:update(dt)
  Coin.updateAll(dt) -- use the gameloop to update coins and other objects
end

function generate:draw(dt)
  -- background image behind tiles? (skybox? Parallax?)
  local willDraw = false -- day night cycle?
  drawBackground(willDraw)
  -- camera not necessary here because camera is set around renderer and game draw, does game draw nee to be passed in love.draw in root main?

  -- tlm:drawMinimap()
  -- drawPacman()

  -- if DEBUG_GRID_ON or generate.editmode then
  if DEBUG_GRID_ON then
    -- -- starbust line pattern
    -- for i = -16, 16 do
    --   for j = -16, 16 do
    --     -- love.graphics.line(i, j, i+256, j+256)
    --     love.graphics.line(i, j, i*10, j*10)
    --     -- chunk lines (OLD)
    --     love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
    --     love.graphics.line(i*32*16, j-500, i*32*16, j+1000)
    --     -- tile grid lines (OLD)
    --     love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
    --     love.graphics.line(i*32*16, j-500, i*32*16, j+1000)
    --     love.graphics.line(i, j*32, i+1000, j*32)

    --     -- thick lines
    --     love.graphics.line(i*16*32, j, i+256, j)
    --     love.graphics.line(i, j*16*32, i, j+256)
    --   end
    -- end
  end

  -- camera:unset()
  Coin.drawAll(dt)
	local mx, my = love.mouse.getPosition()

	local windowWidth, windowHeight = love.graphics.getDimensions()

	-- love.graphics.line(windowWidth/2, windowHeight/2, mx, my)
	-- love.graphics.line(0, 0, mx, my)

	-- love.graphics.line(camera.pos.x, camera.pos.y, mx, my)

  -- line to mouse
  -- from camera pos (upper left corner)
	love.graphics.line(
    camera.pos.x + camera.size.x,
    camera.pos.y + camera.size.y,
    mx + camera.pos.x,
    my + camera.pos.y
  )
	-- love.graphics.line(
  --   camera.pos.x + camera.size.x,
  --   camera.pos.y + camera.size.y,
  --   mx + camera.pos.x,
  --   my + camera.pos.y
  -- )
	-- love.graphics.line(0, 0, mx, my)

  if DEBUG_SHOW_FPS then
    love.graphics.print(
      'FPS '..tostring(love.timer.getFPS()),
      -- camera.pos.x + (windowWidth - 128),
      -- camera.pos.y + (windowHeight - 128)
      32, 32
    )
  end

  -- Draw debug menu hint and menu itself (outside camera transform)
  love.graphics.setColor(0.7, 0.7, 0.7, 0.8)
  local modeStr = isChunkGenerated and "Procedural Chunks" or ("Map: " .. currentMapPath)
  love.graphics.print("[F1] Debug Menu | " .. modeStr, 10, 10)
  love.graphics.setColor(1, 1, 1, 1)

  if debugMenu then
    debugMenu:draw()
  end
end

function coordToChunkCoord(x, y)
  local p = obm:get_closest_by_id(nil, 'player')
  -- local px = obm:get_closest_by_id(nil, 'player').pos.x
  -- local py = obm:get_closest_by_id(nil, 'player').pos.y
  local cx = (p.pos.x / 32) / 16
  local cy = (p.pos.y / 32) / 16

  cx = floor(cx)
  cy = floor(cy)

  -- print(cx, cy)
  -- PrintTable(tlm.chunksByStrKey[tostring(cx)..tostring(cy)].tiles, 4)
  -- PrintTable(tlm.chunksByStrKey, 2)
  -- PrintTable(tlm.chunks, 1)
end


function generate:keypressed(key, code)
  -- Toggle debug menu with F1
  if key == 'f1' then
    if debugMenu then
      debugMenu:toggle()
    end
    return
  end

  -- Handle debug menu input when visible
  if debugMenu and debugMenu:isVisible() then
    if debugMenu:keypressed(key) then
      return -- Input was consumed by debug menu
    end
  end

  -- this should go to menu
  if key == 'escape' then
    -- Close debug menu first, then exit to menu
    if debugMenu and debugMenu:isVisible() then
      debugMenu:hide()
      return
    end
    self:gotoState('menu')
  end

  if key == 'e' then self:pushState('inventory') end
  if key == 'l' then self:pushState('dialogue') end --then love.event.push('quit') end
  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end
  if key == 'k' then self:pushState('synth') end -- experimental @TODO do something
  if key == 'm' then self:pushState('mts') end -- experimental @TODO do something

  if key == 't' then
    print('=======================')
    print('=======================')
    print('=======================')
    print('======CAMERA===========')
    print('=======================')
    print('=======================')
    print('=======================')
    PrintTable(camera, 3)
    print('=======================')
    print('=======================')
    print('=======================')
  end
  if key == '-' then
    -- while (love.keyboard.isDown('='))
    -- do
      local csx = camera.scale.x
      local csy = camera.scale.y
      camera.scale.x = csx+0.2
      camera.scale.y = csy+0.2
    -- end
  end 
  if key == '=' then
    -- while (love.keyboard.isDown('='))
    -- do
      local csx = camera.scale.x
      local csy = camera.scale.y
      camera.scale.x = csx-0.2
      camera.scale.y = csy-0.2
    -- end
  end 

  -- let's generate a chunk next to the player
  if key == 'g' then
    -- print('adding chunk at ')
    -- print(obm:get_closest_by_id(nil, 'player').pos.x, obm:get_closest_by_id(nil, 'player').pos.y)
    -- coordToChunkCoord()
  end

  -- if key == 'o' and DEBUG_CONSOLE_FUNCTION then
  if key == 'o' then -- does this work at all?
    -- debug.debug() -- how do we inspect variables with this: https://www.tutorialspoint.com/lua/lua_debugging.htm#
    -- print(debug)
    -- PrintTable(debug)
    -- PrintTable(debug.debug())
  end

  -- if key == 'q' then love.event.push('quit') end -- remove if quitting is in a menu
  -- if key == 'escape' then love.event.push('quit') end -- remove if quitting is in a menu

end

function generate:mousepressed(x, y, button)
  -- Handle debug menu mouse clicks
  if debugMenu and debugMenu:isVisible() then
    if debugMenu:mousepressed(x, y, button) then
      return -- Input was consumed by debug menu
    end
  end
end
