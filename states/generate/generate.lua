-- COINT
-- print(pcall(require("../objects/coin.lua")))
-- require '/lib/fanfic'
-- text = fanfic.new(200,300, "New textbox", false, 16)
-- function test()
--   text = fanfic.new(200,300, "New textbox", false, 16)
-- end
-- function test()
-- require("../../objects/coin")
-- -- print(pcall(require("../objects/coin.lua")))
-- end


-- print(pcall(test, nil))

require("../../objects/coin")
local floor = math.floor


-- Example gamestate directory main file
local generate = Game:addState('generate')

-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer
-- Libraries

entity_factory =  require 'entity_factory'


-- force lightening
-- local function generateLighteningVertecies() end

  -- asm:add(love.graphics.newImage("assets"), 'tiles')

-- BEGIN video backgrounds
  if false then
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

local function drawPacman()
  -- drawBox(player, 0, 255, 0)
  pacwidth = math.pi / 6 -- size of his mouth
  -- love.graphics.setColor( 255, 255, 0 ) -- pacman needs to be yellow
  -- love.graphics.arc( "fill", 400, 100, 100, pacwidth, (math.pi * 2) - pacwidth )
  
  -- draw trees
  local vertices = {0, 0, -100, -100, -100, 0}
  love.graphics.setColor( 0, 155, 55, 1000 ) -- pacman needs to be yellow
  love.graphics.polygon('fill', vertices)

  -- draw clouds
  love.graphics.setColor( 255, 255, 255, 30 ) -- pacman needs to be yellow

  -- https://love2d.org/wiki/love.graphics.arc
  -- love.graphics.arc( drawmode, x, y, radius, angle1, angle2, segments )
  love.graphics.arc( "fill", 400, 200, 200, pacwidth, (math.pi * 2) - pacwidth )

  -- draw lightening
  sometable = {
    100, 100,
    200, 200,
    300, 100,
    400, 200,
  }
  love.graphics.line(sometable)

  -- @TODO - implement the generation 
  anotherTable = generateLighteningVertecies()
  
  -- shoot lightening
  love.graphics.setColor( 255, 255, 255, 80 )

  -- love.graphics.setLine(2, "smooth") -- removed
  local width = 2
  -- local style = 'smooth'
  local style = 'rough'
  love.graphics.setLineStyle( style )
  love.graphics.setLineWidth( width )

  -- why is this not aligned with the camera?
  w = love.graphics.getWidth() --/ 2   -- half the window width
  h = love.graphics.getHeight() --/ 2   -- half the window height
  local mx, my = love.mouse.getPosition()  -- current position of the mouse
  love.graphics.line(w, h, mx, my)

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
  -- why doesn't this work? (should I use this to render more efficiently?)
  -- renderer:addRenderer(self, 2)
  -- gameloop:addLoop(self)

  -- is canvas available?
  local canvas = love.graphics.getSupported()
  for k, v in pairs(canvas) do
    print("IS CANVAS SUPPORTED?")
    print(k, v)
  end

  -- camera.scale.x = 0.6 -- 3 --1
  -- camera.scale.y = 0.6 -- 3 --1
  camera.scale.x = 1
  camera.scale.y = 1
  -- PrintTable(camera, 3)


  asm:load() -- load asset manager
  -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')
  -- asm:add(love.graphics.newImage("assets/images/terrain_32x32_by_sonicrumpets-d7vj9k7.png"),
  --   'tiles'
  -- )
  -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')

  -- local customMap = true
  local customMap = false

  tlm:load(customMap) -- load tile manager
  obm:load() -- load object manager


  self.chunks = {}
  self.chunks.x = {}

  -- menu of custom maps
  if customMap then -- load the custom map
    -- tlm:loadMap('test/test')
    -- tlm:loadMap('bedroom/house1')
  else
    -- load
    -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')
  end

  -- load the map from file
  -- tlm:loadMap('test/test')
  -- tlm:loadMap('generator/template')
  -- tlm:loadMap('test2/test2')
  -- tlm:loadMap('test2/test')
  -- tlm:loadMap('testMap')

  -- generate map from template
  -- tlm:generateMap()

  -- local chunkCoords = vec2:new(1,1)
  -- PrintTable(chunkCoords)
  -- self.chunk = tlm:generateChunk(chunkCoords)
  -- PrintTable(self.chunk)
  -- local fn = tlm['generateChunk']
  -- print(pcall(fn, chunkCoords))

  -- PrintTable(self.chunk)

  love.timer.sleep(0.25)
  -- spawn 2 players
  -- obm:add(require('objects/player'):new(32,170))
  obm:add(require('objects/player'):new(32, 32))

  -- spawn an enemy
  obm:add(require('objects/zombie'):new(320,180))

  -- spawn an item
  obm:add(require( 'objects/item' ):new(320,280))

  -- add lots of players
  -- for i = 0, 16 do
  --   obm:add(
  --     require( 'objects/player' ):new(32 * i, 280)
  --   )
  -- end

  -- spawn in coins
  Coin.new(200, 200)
  Coin.new(400, 300)
  Coin.new(500, 250)

  local rect = entity_factory:new_rectangle(-128, 128, 128, 128)
  rect:init()

  print(" -> GENERATE STATE ENTERED -> ")
end

function generate:exitedState()

  -- figure out why mouse gets off when we pause
  camera:goToPoint({x=0,y=0})
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
  Coin.updateAll(dt)
end

function generate:draw(dt)
  local willDraw = false
  drawBackground(willDraw)
  -- camera not necessary here because camera is set around renderer and game draw, does game draw nee to be passed in love.draw in root main?

  -- tlm:drawMinimap()
  -- drawPacman()

  if DEBUG_GRID_ON then
    -- thick line?
    for i = -16, 16 do
      for j = -16, 16 do
        -- love.graphics.line(i, j, i+256, j+256)
        love.graphics.line(i, j, i*10, j*10)
      end
    end

    -- love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
    -- love.graphics.line(i*32*16, j-500, i*32*16, j+1000)

    for i = -16, 16 do
      for j = -16, 16 do
        love.graphics.line(i-500, j*32*16, i+1000, j*32*16)
        love.graphics.line(i*32*16, j-500, i*32*16, j+1000)
        love.graphics.line(i, j*32, i+1000, j*32)
        -- love.graphics.line(i*16*32, j, i+256, j)
        -- love.graphics.line(i, j*16*32, i, j+256)
      end
    end
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

      raint = 1
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
    self:popState('generate')
    self:gotoState('PressStart')
  end --then love.event.push('quit') end

  if key == 'e' then self:pushState('inventory') end --then love.event.push('quit') end
  if key == 'l' then self:pushState('dialogue') end --then love.event.push('quit') end
  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end

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
    debug.debug() -- how do we inspect variables with this?
    print(debug)
    -- PrintTable(debug)
    -- PrintTable(debug.debug())
  end

  -- if key == 'q' then love.event.push('quit') end -- remove if quitting is in a menu
  -- if key == 'escape' then love.event.push('quit') end -- remove if quitting is in a menu

end
