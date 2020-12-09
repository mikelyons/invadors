return function(imageDir)
	local image = love.graphics.newImage((imageDir or '').. 'test.png')
	local ps = love.graphics.newParticleSystem(image, 1000)

	
	ps:setEmissionRate(60)
	ps:setEmitterLifetime(-1)
	ps:setParticleLifetime(1.000000, 1.000000)
	ps:setSizes(0, 1)
	ps:setSizeVariation(0)
	ps:setInsertMode('top')
	ps:setColors({ 255, 255, 255, 255 }, { 255, 255, 255, 0 })
	ps:setAreaSpread('uniform', 32.000000, 32.000000)
	ps:setDirection(0)
	ps:setSpeed(0.000000, 0.000000)
	ps:setLinearAcceleration(0.000000, 0.000000, 0.000000, 0.000000)
	ps:setRadialAcceleration(0.000000, 0.000000)
	ps:setTangentialAcceleration(0.000000, 0.000000)
	ps:setLinearDamping(0.000000, 0.000000)
	ps:setRotation(0.000000, 0.000000)
	ps:setOffset(16, 16)
	ps:setRelativeRotation(false)
	ps:setSpin(0.000000, 0.000000)
	ps:setSpinVariation(0)

	return ps, 'alpha'
end
