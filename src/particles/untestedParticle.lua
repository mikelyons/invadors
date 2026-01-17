--[[
  this particle system is from a reddit post asking how to do it
    needs to be modified into a module we can use in the game
]]
function love.load()
	local img = love.graphics.newImage('logo.png')

	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-30, -30, 30, 30) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
end

function love.draw()
	-- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)
end

function love.update(dt)
	psystem:update(dt)
end