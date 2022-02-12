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


-- Example gamestate directory main file
local generate = Game:addState('generate')

-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer
-- Libraries

entity_factory =  require 'entity_factory' 

-- World Creation
local instructions = [[You have gravity, 
jump with space
left right aarow keys to move]]

local function generateLighteningVertecies()

end

-- background = love.graphics.newImage("yourbackgroundfile.png")
  -- asm:add(love.graphics.newImage("assets"), 'tiles')
background = love.graphics.newImage("assets/galaxy.png")
local function drawBackground()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
end

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

function generate:enteredState()
  print('ENTERED generate directory STATE!')


  renderer:addRenderer(self, 2)
  -- gameloop:addLoop(self)

  -- -- is canvas available?
  -- local canvas = love.graphics.getSupported()
  -- for k, v in pairs(canvas) do
  --   print(k, v)
  -- end

  -- camera.scale.x = 0.6 -- 3 --1
  -- camera.scale.y = 0.6 -- 3 --1

  camera.scale.x = 1
  camera.scale.y = 1
  -- PrintTable(camera, 3)


  asm:load() -- load asset manager
  asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')
  -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')

  tlm:load() -- load tile manager
  obm:load() -- load object manager

  -- load the map from file
  -- tlm:loadMap('test/test')
  -- tlm:loadMap('generator/template')
  -- tlm:loadMap('test2/test2')
  tlm:loadMap('test2/test')
  -- tlm:loadMap('testMap')

  -- generate map from template
  -- tlm:generateMap()

  love.timer.sleep(0.25)


  -- spawn 2 players
  -- obm:add(require('objects/player'):new(32,170))
  obm:add(require('objects/player'):new(64,-270))

  -- spawn an enemy
  obm:add(require('objects/zombie'):new(320,180))

  -- spawn an item
  obm:add(require( 'objects/item' ):new(320,280))

  -- spawn in coins
  Coin.new(200, 200)
  Coin.new(400, 300)
  Coin.new(500, 250)

  local rect = entity_factory:new_rectangle(-128, 128, 128, 128)
  rect:init()
end

function generate:exitedState()

  -- figure out why mouse gets off when we pause
  -- camera:goToPoint({x=0,y=0})

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
  -- testing camera movement transformation
  -- g_GameTime = g_GameTime + dt
  -- camera.pos.x = camera.pos.x + math.cos(g_GameTime) 
  -- camera.pos.x = camera.pos.x + math.cos(g_GameTime) -- jiggle the camera
  gameloop:update(dt)
  Coin.updateAll(dt)
end

function generate:draw(dt)
  -- camera not necessary here because camera is set around renderer and game draw, does game draw nee to be passed in love.draw in root main?

  -- tlm:drawMinimap()
  -- drawPacman()
  -- drawBackground()

  --all drawing should be done

  -- camera:unset()
  Coin.drawAll(dt)
	local mx, my = love.mouse.getPosition()

	local windowWidth, windowHeight = love.graphics.getDimensions()

	love.graphics.line(windowWidth/2, windowHeight/2, mx, my)
end

function generate:keypressed(key, code)
  -- this should go to menu
  if key == 'escape' then self:popState('generate') end --then love.event.push('quit') end

  if key == 'e' then self:pushState('inventory') end --then love.event.push('quit') end

  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end

  if key == 't' then 
    PrintTable(camera, 3)
  end

  -- if key == 'o' and DEBUG_CONSOLE_FUNCTION then
  if key == 'o' then -- does this work at all?
    debug.debug() -- how do we inspect variables with this?
  end

  -- if key == 'q' then love.event.push('quit') end -- remove if quitting is in a menu
  -- if key == 'escape' then love.event.push('quit') end -- remove if quitting is in a menu

end
