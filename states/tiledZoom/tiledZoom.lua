
--[[
  tiledZoom.lua

  a zoomed tiled view for indoor activities
  - uses sti in a simple implementation
  - intended to replace custom collision detection we have some problems with
  - try also to use for loading parts of the neighborhood newport hills
  - pearly gates game play


  - https://github.com/karai17/Simple-Tiled-Implementation/tree/master/tutorials
]]

print('tiledZoom.lua -> ')
-- dependencies
sti = require('lib/sti')

-- not working?
-- Sketchy = require 'lib/sketchy/sketchy'

print('TZ -> ')
local TZ = Game:addState('tiledZoom') -- registering the gamestate

function TZ:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER TZ STATE - %s \n", os.date())) end
	windowWidth  = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)
	-- Load a map exported to Lua from Tiled
	-- map = sti("assets/maps/bedroom/house2.lua", { "box2d" })
	map = sti("assets/maps/bedroom/house3.lua", { "box2d" })
  -- PrintTable(map, 1)
	world = love.physics.newWorld(0, 800) -- Prepare physics world with horizontal and vertical gravity
	-- map.box2d_init(map, world) -- Prepare collision objects
	map:box2d_init(world) -- Prepare collision objects

  -- not working?
  -- sketchy = Sketchy()
  --   :setViewport(0, 0, 400, 400)
  --   :setScale(1)

  --[[ PLAYER ]]
  self.player = {}
  local player = self.player
  -- player.speed = 5
    -- player.body =  love.physics.newBody( world, player.x, player.y, 'dynamic' )
    -- player.body =  love.physics.newBody( world, player.x, player.y, 'dynamic' )
    --  (set dozer.body (love.physics.newBody world dozer.x dozer.y "dynamic"))
  -- player.body =  love.physics.newBody( world, player.x, player.y, 'dynamic' )
  -- player.body =  love.physics.newBody( map, player.x, player.y, 'dynamic' )
  -- player.spriteSheet = love.graphics.newImage()
  -- player.grid = anim8.newGrid()
  -- player.animations = {}

  function player.draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle(
      "line",
      player.body:getX(),
      player.body:getY(),
      32, 32
    )
  end
  -- function player.update(dt)
  --   local player = self.player
  --   if love.keyboard.isDown('a' or 'left') then
  --     player.x = player.x + (-3)
  --   end
  --   if love.keyboard.isDown('d' or 'right') then
  --     player.x = player.x + (3)
  --   end
  --   if love.keyboard.isDown('w' or 'up') then
  --     player.y = player.y + (-3)
  --   end
  --   if love.keyboard.isDown('s' or 'down') then
  --     player.y = player.y + (3)
  --   end
  -- end

  -- Create a dynamic body for the player
  player.body = love.physics.newBody(
    world,
    200, 400,
    "dynamic"
  )
  -- Create a circular shape for the player
  -- player.shape = love.physics.newCircleShape(20)
  player.shape = love.physics.newRectangleShape(32, 32)
  -- Attach the shape to the body
  player.fixture = love.physics.newFixture(
    player.body,
    player.shape
  )

  function player:jump()
    -- self.body:applyAngularImpulse(200)
    self.body:applyForce(200, 800)
  end

	map:addCustomLayer("Sprite Layer", 2)
	-- Add data to Custom Layer
	local spriteLayer = map.layers["Sprite Layer"]
  local x, y = player.body:getLocalCenter()
  print(x, y)
	spriteLayer.sprites = {
		player = {
			image = love.graphics.newImage("assets/character/man.png"),
      -- x,
      -- y,
			x = player.body:getX() - 16,
			y = player.body:getY() - 16,
			-- x = player.body:getLocalCenter(),
			-- y = player.body:getLocalCenter(),
			-- player.body:getLocalCenter(),
			r = 0,
		}
	}

	-- Update callback for Custom Layer
	function spriteLayer:update(dt)
		for _, sprite in pairs(self.sprites) do
			-- sprite.r = sprite.r + math.rad(90 * dt)
      sprite.r = player.body:getAngle()
      sprite.x = player.body:getX()
      sprite.y = player.body:getY()
		end
	end

	-- Draw callback for Custom Layer
	function spriteLayer:draw()
		for _, sprite in pairs(self.sprites) do
			-- local x = math.floor(sprite.x)
			local x = sprite.x
			local y = sprite.y
			local r = sprite.r
			love.graphics.draw(sprite.image, x, y, r,0.05,0.05)
		end
	end

-- [[ END EnteredState() ]]
end
function TZ:exitedState() love.graphics.clear() end
function TZ:update(dt)
	map:update(dt)
  world:update(dt)

  -- Player controls
  -- self.player:update(dt)
  local speed = 200
  if love.keyboard.isDown("left") then
    self.player.body:applyForce(-speed, 0)
  elseif love.keyboard.isDown("right") then
    self.player.body:applyForce(speed, 0)
  end
  if love.keyboard.isDown("down") then
    self.player.body:applyForce(0, speed)
  elseif love.keyboard.isDown("up") then
    self.player.body:applyForce(0, -speed)
  end
  if love.keyboard.isDown('space') then
    -- self.player.jump()
    self.player.body:applyForce(000, -8000)
    -- self.body:applyAngularImpulse(-18000)
  end
end


function TZ:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)

	-- love.graphics.setColor(1, 1, 1)-- dark and spooky
	love.graphics.setColor(255, 255, 255, 255)
	map:draw()

  -- self.player.draw()

	love.graphics.setColor(255, 0, 0)
	-- map:box2d_draw()

  --not working?
  -- sketchy:draw(world)
  -- sketchy:drawWorld(world)

  -- angle and contacts
  -- sketchy:draw(self.player.body)
  -- sketchy:drawCircleShape(self.player.shape, self.player.fixture)
  -- sketchy:drawPolygonShape(self.player.shape, self.player.fixture)
  love.graphics.setColor(_r, _g, _b, _a)
end

function raent()
  local raint = {}

  print('raie t')

  return raint
end

-- input
function TZ:mousepressed(x,y, button , istouch) end
function TZ:mousereleased(x, y, button) end
function TZ:keypressed(key, code)
  if key == ('space') then
    print('psychobackflip')
  end

  if key == 'F2' then
    love.graphics.captureScreenshot( callback )
  end


  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('tiledZoom') end
end
