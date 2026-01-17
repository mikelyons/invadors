
--[[
  drivingSim.lua

  The mode 7 driving sim for the commute
  https://www.youtube.com/watch?v=ybLZyY655iY

  @TODO
	= re-implement the mode 7 thing you deleted!!!!!! Playmat mode 7
  = was using this to test the mesh texture, remove later!!!!
  - find-replace the word 'template' with the new state name for internal variables
  - find-replace the word 'Template' (capitalization) for the instance/class name.
]]

if DEBUG_LOGGING_LOADING then
	print('drivingSim.lua -> ')
	-- dependencies
	print('Driving Sim -> ')
end

local Template = Game:addState('drivingSim') -- registering the gamestate

function Template:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER template STATE - %s \n", os.date())) end

	image = love.graphics.newImage("states/drivingSim/pig.png")
	local meshVertices = {
		{
			-- top-left corner (red-tinted)
			0, 0, -- position of the vertex
			0, 0, -- texture coordinate at the vertex position
			255, 0, 0, -- color of the vertex
		},
		{
			-- top-right corner (green-tinted)
			image:getWidth(), 0,
			1, 0, -- texture coordinates are in the range of [0, 1]
			0, 255, 0
		},
		{
			-- bottom-right corner (blue-tinted)
			image:getWidth(), image:getHeight(),
			1, 1,
			0, 0, 255
		},
		{
			-- bottom-left corner (yellow-tinted)
			0, image:getHeight()*2,
			0, 1,
			255, 255, 0
		},
	}
	-- the Mesh DrawMode "fan" works well for 4-vertex Meshes.
	mesh = love.graphics.newMesh(meshVertices, "fan")
	mesh:setTexture(image)


	-- more controls
	curve = love.math.newBezierCurve({25,25, 25,125, 75,25, 125,25})
	-- curve = love.math.newBezierCurve({25,25, 25,125, 125,25})
	local count    = curve:getControlPointCount()
	curveVertices = {}

	for i = 1, count do
		local x, y = curve:getControlPoint(i)
		table.insert(curveVertices, {x, y})
	end

end
function Template:exitedState() love.graphics.clear() end

function Template:update(dt) end

function Template:draw()
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.draw(image, 100, 100)
  love.graphics.draw(mesh, 0, 0)


  love.graphics.setColor(255, 5, 5, 255)
	for i = 1, #curveVertices do
		local x = curveVertices[i][1]
		local y = curveVertices[i][2]
		if i == 1 or i == 4 then
			-- do nothing
		else
			love.graphics.rectangle("fill", x-1,y-1, 3, 3)
		end
	end
	-- control arm #1
	love.graphics.line(
		curveVertices[1][1], curveVertices[1][2],
		curveVertices[2][1], curveVertices[2][2]
	)
	-- control arm #2
	love.graphics.line(
		curveVertices[4][1], curveVertices[4][2],
		curveVertices[3][1], curveVertices[3][2]
	)

  love.graphics.setColor(255, 255, 255, 255)
	love.graphics.line(curve:render())

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Template:mousepressed(x,y, button , istouch) end
function Template:mousereleased(x, y, button) end
function Template:keypressed(key, code)

--   if key == ('escape') then love.event.push('quit') end
  if key == 'escape' then self:popState() end
end
