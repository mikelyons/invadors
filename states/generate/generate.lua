--[[
  generate.lua

  The side-scroller game scene
  
  Uses tiled maps, collisions, generation and chunks

  This game mode was meant to be an infinite generating world
  hence the name "generate", this is still in the WIPs, but for
  now will load custom maps made in the Tiled map editor
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

-- Example gamestate directory main file
-- registering the gamestate
local generate = Game:addState('generate')

-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer
-- Libraries

entity_factory =  require 'entity_factory'

-- BEGIN video backgrounds
  -- plays a series of video frames for a video intro
  if false then
  -- if true then
    default_background = love.graphics.newImage("assets/galaxy.png")
    background = default_background
    video_length = 748
    -- video_length = 1
    vl = video_length
    images = {}
    imgno = 1
    images[imgno] = love.graphics.newImage("assets/imageSequence/scene00001.png")

    -- load in video_length in frames
    for i = 1, vl do
      local filename = 'scene'..string.format("%05d", i)
      print('loading video frame: '..filename..'.png')

      images[i] = love.graphics.newImage('assets/imageSequence/'..filename..'.png')
    end
  end

  local function drawBackground(draw)
    if not draw then
      -- no op
    else
      love.graphics.draw(
        images[imgno],
        camera.pos.x,
        camera.pos.y
      )
      if imgno == vl then imgno = 1 else imgno = imgno + 1 end
    end
  end
-- END video backgrounds

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
    -- broken
    -- tlm:loadMap('test/test-simplify')

  -- load the map from file
  -- tlm:loadMap('test/test')
  -- tlm:loadMap('generator/template')
  -- tlm:loadMap('test2/test2')
  -- tlm:loadMap('test2/test')
  -- tlm:loadMap('testMap')

    -- renders multiple layers WITHOUT collisions
    tlm:loadMap('bedroom/house1')

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
  love.graphics.clear()
end


function generate:update(dt)
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
	-- love.graphics.line(0, 0, mx, my)

  if DEBUG_SHOW_FPS then
    love.graphics.print(
      love.timer.getFPS(),
      camera.pos.x + (windowWidth - 64),
      camera.pos.y + (windowHeight - 64)
    )
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
  -- this should go to menu
  if key == 'escape' then
    -- self:popState('generate')
    self:gotoState('menu')
    -- self:gotoState('PressStart')
  end --then love.event.push('quit') end

  if key == 'e' then self:pushState('inventory') end --then love.event.push('quit') end
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
    debug.debug() -- how do we inspect variables with this: https://www.tutorialspoint.com/lua/lua_debugging.htm#
    print(debug)
    -- PrintTable(debug)
    -- PrintTable(debug.debug())
  end

  -- if key == 'q' then love.event.push('quit') end -- remove if quitting is in a menu
  -- if key == 'escape' then love.event.push('quit') end -- remove if quitting is in a menu

end
