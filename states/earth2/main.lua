-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer

tlm  = require 'tiles/tlm' -- tile manager 
obm  = require 'tools/obm' -- object manager
asm  = require 'tools/asm' -- asset manager
local camera = require 'tools/camera' -- using a camera for this gamemode

--finished loading libraries, load the gamestate
local Earth2 = Game:addState('Earth2')

-- World Creation
local instructions = [[You have gravity, 
jump with space
left right aarow keys to move]]



-- Block functions
local blocks = {}
local function addBlock(x,y,w,h)
  local block = {x=x,y=y,w=w,h=h}
  blocks[#blocks+1] = block
end
-- helper function
local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end
local function drawBlocks()
  for _,block in ipairs(blocks) do
    drawBox(block, 0,250,0)
  end
end
local function addBlocks( ... )
  --primitive ui
  addBlock(0,       0,     800, 32)
  addBlock(0,      32,      32, 600-32*2)
  -- addBlock(800-32, 32,      32, 600-32*2)
  addBlock(0,      600-32, 800, 32)

  for i=1,3 do
    addBlock( math.random(100, 600),
              math.random(100, 400),
              math.random(10, 100),
              math.random(10, 100)
    )
  end
end
local function drawPacman()
  -- drawBox(player, 0, 255, 0)
  pacwidth = math.pi / 6 -- size of his mouth
  love.graphics.setColor( 255, 255, 0 ) -- pacman needs to be yellow
  love.graphics.arc( "fill", 400, 300, 100, pacwidth, (math.pi * 2) - pacwidth )

end


function Earth2:enteredState()
  print('ENTERED Earth2 STATE!')
  renderer:addRenderer(self, 2)
  -- gameloop:addLoop(self)

  -- testing camera scale and positions
  -- @TODO - double the scale will make the camera move twice as fast too separating from the player follow @TODO
  camera.scale.x = .9
  camera.scale.y = .9

  asm:load() -- load asset manager
  -- store tilemap in asset manager -- adm loaded above
  asm:add(love.graphics.newImage("assets/maps/test.png"), 'tiles')
  tlm:load() -- load tile manager
  obm:load() -- load object manager
  tlm:loadMap('test') -- load tilemap for the world

  -- -- is canvas available?
  -- local canvas = love.graphics.getSupported()
  -- for k, v in pairs(canvas) do
  --   print(k, v)
  -- end




  obm:add(require('objects/player'):new(50,50))
  obm:add(require('objects/zombie'):new(250,50))

end

function Earth2:exitedState()
  -- love.graphics.clear( )
  -- destroy buttons, menus, etc
  -- world:remove(player)
  -- for _,block in ipairs(blocks) do
  --   --mark blocks for removal
  --   world:remove(block)
  -- end
  -- blocks = {} --zero out the array?
end


function Earth2:update(dt)
  -- testing camera movement transformation
  -- GAMETIME = GAMETIME + dt
  -- camera.pos.x = camera.pos.x + math.cos(GAMETIME) 
  -- camera.pos.x = camera.pos.x + math.cos(GAMETIME) -- jiggle the camera
end

function Earth2:draw(dt)
  -- camera not necessary here because camera is set around renderer and game draw, does game draw nee to be passed in love.draw in root main?
  -- camera:set()
  -- tlm:draw()
  -- player:draw()

    drawBlocks()
    drawPacman()
    if shouldDrawDebug then
      drawDebug()
      drawConsole()
    end

  --all drawing should be done
  -- camera:unset()
end

function Earth2:keypressed(key, code)
  if key == 'escape' then self:popState('Earth2') end --then love.event.push('quit') end
  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end

  -- Bump actions
  if key == "tab"    then shouldDrawDebug = not shouldDrawDebug end
  if key == "delete" then collectgarbage("collect") end
end
