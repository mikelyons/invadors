local Earth2 = Game:addState('Earth2')

-- based on : https://love2d.org/wiki/Tutorial:Baseline_2D_Platformer
-- Libraries
tlm  = require 'tiles/tlm' -- tile manager 
obm  = require 'tools/obm' -- object manager
asm  = require 'tools/asm' -- asset manager
local camera = require 'tools/camera' -- using a camera for this gamemode

entity_factory =  require 'entity_factory' 

-- World Creation
local instructions = [[You have gravity, 
jump with space
left right aarow keys to move]]

local function drawPacman()
  -- drawBox(player, 0, 255, 0)
  pacwidth = math.pi / 6 -- size of his mouth
  love.graphics.setColor( 255, 255, 0 ) -- pacman needs to be yellow
  love.graphics.arc( "fill", 400, 100, 100, pacwidth, (math.pi * 2) - pacwidth )

end


function Earth2:enteredState()
  print('ENTERED Earth2 STATE!')
  renderer:addRenderer(self, 2)
  -- gameloop:addLoop(self)

  camera.scale.x = 1
  camera.scale.y = 1

  asm:load() -- load asset manager
  -- store tilemap in asset manager -- adm loaded above
  asm:add(love.graphics.newImage("assets/maps/test.png"), 'tiles')
  tlm:load() -- load tile manager
  obm:load() -- load object manager
  tlm:loadMap('test') -- load tilemap for the world
  love.timer.sleep(0.25)

  -- -- is canvas available?
  -- local canvas = love.graphics.getSupported()
  -- for k, v in pairs(canvas) do
  --   print(k, v)
  -- end



  obm:add(require('objects/player'):new(32,170))
  -- obm:add(require('objects/zombie'):new(320,180))

  local rect = entity_factory:new_rectangle(-128, 128, 128, 128)
  rect:init()
end

function Earth2:exitedState()
  camera:goToPoint({x=0,y=0})
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
  gameloop:update(dt)
end

function Earth2:draw(dt)
  -- camera not necessary here because camera is set around renderer and game draw, does game draw nee to be passed in love.draw in root main?

  --drawUI()

    -- tlm:drawMinimap()
    -- drawPacman()

  --all drawing should be done
  -- camera:unset()
end

function Earth2:keypressed(key, code)
  if key == 'escape' then self:popState('Earth2') end --then love.event.push('quit') end
  if key == 'p' then self:pushState('Pause') end --then love.event.push('quit') end

end
