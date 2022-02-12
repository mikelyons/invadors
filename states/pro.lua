-- first pass proc gen map 
-- using sti for the map loading

local sti = require("lib/sti")

local pro = Game:addState('pro')

function pro:enteredState()
  if DEBUG_LOGGING_ON then
    print("")
    print(string.format("ENTER pro STATE - %s \n", os.date()))
    print("")
  end

	-- Grab window size
	windowWidth  = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)

	-- Load a map exported to Lua from Tiled
	-- Map = sti("assets/maps/infinite/infinite.lua", { 'box2d' })
	Map = sti("assets/maps/test/test.lua", { 'box2d' })
	-- Prepare physics world with horizontal and vertical gravity
	World = love.physics.newWorld(0,0)

  -- Map.layers.solid.visible = true
  -- PrintTable(Map.layers['tiles-solid'], 2)
  Map.layers['tiles-solid'].visible = false

	-- Prepare collision objects
	Map:box2d_init(World)

	-- Create a Custom Layer
	Map:addCustomLayer("Sprite Layer", 3)
	-- Add data to Custom Layer
	local spriteLayer = Map.layers["Sprite Layer"]
	spriteLayer.sprites = {
		player = {
			image = love.graphics.newImage("assets/character/man.png"),
			x = 64,
			y = 64,
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
  --- end ENTEREDSTATE
end
function pro:exitedState() end

function pro:update(dt)
	Map:update(dt)
end

function pro:draw(dt)

  love.graphics.setColor(205, 205, 195, 255)

	-- Draw the map and all objects within
	Map:draw(0, 0, 2, 2)

  love.graphics.setColor(255, 205, 195, 255)
	-- Draw Collision Map (useful for debugging)
	Map:box2d_draw()


end

function pro:keypressed(key, code)
  if key == 'escape' then self:pushState('Pause') end
  -- if key == 'escape' then self:popState('pro') end
  if key == ('q') then love.event.push('quit') end
end
