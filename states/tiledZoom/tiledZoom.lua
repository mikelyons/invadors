
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

  self.player = {}
  local player = self.player
  player.x = 400
  player.y = 200
  player.speed = 5
  function player.draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle(
      "line",
      player.x,
      player.y,
      32, 32
    )
  end
  function player.update(dt)
    local player = self.player
    if love.keyboard.isDown('left') then
      player.x = player.x + (-3)
    end
    if love.keyboard.isDown('right') then
      player.x = player.x + (3)
    end
    if love.keyboard.isDown('up') then
      player.y = player.y + (-3)
    end
    if love.keyboard.isDown('down') then
      player.y = player.y + (3)
    end
  end
  -- player.spriteSheet = love.graphics.newImage()
  -- player.grid = anim8.newGrid()
  -- player.animations = {}

  -- not working?
  -- self.sketchy = Sketchy()
  --     :setViewport(200, 100, 400, 400)
  --     :setScale(2)

  	-- Grab window size
	windowWidth  = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)

	-- Load a map exported to Lua from Tiled? - no such luck where's the erroe? PCALL
	map = sti("assets/maps/bedroom/house2.lua", { "box2d" })

	-- Prepare physics world with horizontal and vertical gravity
	world = love.physics.newWorld(0, 0)

	-- Prepare collision objects
	map:box2d_init(world)

	-- Create a Custom Layer
	map:addCustomLayer("Sprite Layer", 3)

	-- Add data to Custom Layer
	local spriteLayer = map.layers["Sprite Layer"]
	spriteLayer.sprites = {
		player = {
			image = love.graphics.newImage("assets/character/man.png"),
			x = 64,
			y = 64,
			r = 0,
		},
		dopel = {
			image = love.graphics.newImage("assets/character/man.png"),
			x = 32,
			y = 32,
			r = 0,
		},
		dopel2 = {
			image = love.graphics.newImage("assets/character/man.png"),
			x = 320,
			y = 320,
			r = 0,
		}
	}

	-- Update callback for Custom Layer
	function spriteLayer:update(dt)
		for _, sprite in pairs(self.sprites) do
			sprite.r = sprite.r + math.rad(90 * dt)
		end
	end

	-- Draw callback for Custom Layer
	function spriteLayer:draw()
		for _, sprite in pairs(self.sprites) do
			local x = math.floor(sprite.x)
			local y = math.floor(sprite.y)
			local r = sprite.r
			love.graphics.draw(sprite.image, x, y, r)
		end
	end

end

function TZ:exitedState() love.graphics.clear() end

function TZ:update(dt)
	map:update(dt)
  self.player:update(dt)
end

function TZ:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 255, 255)

  -- Draw the map and all objects within
	-- love.graphics.setColor(1, 1, 1)-- dark and spooky
	love.graphics.setColor(255, 255, 255, 255)
	map:draw()

	-- Draw Collision Map (useful for debugging)
	love.graphics.setColor(255, 0, 0)
	map:box2d_draw()

	-- Please note that map:draw, map:box2d_draw, and map:bump_draw take
	-- translate and scale arguments (tx, ty, sx, sy) for when you want to
	-- grow, shrink, or reposition your map on screen.

  love.graphics.setColor(_r, _g, _b, _a)

  -- this is not working?
  -- self.sketchy:draw(world)
  self.player.draw()
end

-- input
function TZ:mousepressed(x,y, button , istouch) end
function TZ:mousereleased(x, y, button) end
function TZ:keypressed(key, code)

  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('tiledZoom') end
end
