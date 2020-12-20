-- the Particle system base class -- can inherit to blood, smoke or whatnot
local Particle = {}

-- local defaults = {

-- }

-- function Particle:new(x,y,w,h,img,quad,id)
function Particle:new(x,y, img)
  local particle = {}
    particle.x = x or 100
    particle.y = y or 100
    particle.img = img
  -- particle.w = w
  -- particle.h = h
  -- particle.img = img
  -- particle.quad = quad
  -- particle.id = id

  function particle:load()
    -- set this dynamically
    local imageDir = '/assets/particles/'
    particle.image = particle.img or love.graphics.newImage((imageDir or '').. 'test.png')
    particle.system = love.graphics.newParticleSystem(particle.image, 1000)

    particle.system:setEmissionRate(60)
    particle.system:setEmitterLifetime(-1)
    particle.system:setParticleLifetime(1.000000, 1.000000)
    particle.system:setSizes(0, 1)
    particle.system:setSizeVariation(0)
    particle.system:setInsertMode('top')
    particle.system:setColors({ 255, 255, 255, 255 }, { 255, 255, 255, 0 })
    -- particle.system:setAreaSpread('uniform', 32.000000, 32.000000)
    particle.system:setAreaSpread('uniform', 320, 320)
    particle.system:setDirection(0)
    particle.system:setSpeed(0.000000, 0.000000)
    particle.system:setLinearAcceleration(0.000000, 0.000000, 0.000000, 0.000000)
    particle.system:setRadialAcceleration(0.000000, 0.000000)
    particle.system:setTangentialAcceleration(0.000000, 0.000000)
    particle.system:setLinearDamping(0.000000, 0.000000)
    particle.system:setRotation(0.000000, 0.000000)
    particle.system:setOffset(16, 16)
    particle.system:setRelativeRotation(false)
    particle.system:setSpin(0.000000, 0.000000)
    particle.system:setSpinVariation(0)
  end
  function particle:update(dt)
    self.system:update(dt)
  end
  function particle:draw(dx,dy)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(
      self.system,
      dx or self.x or 100,
      dy or self.y or 100
    )
  end

  return particle
end

return Particle

-- return function(imageDir)
-- 	local image = love.graphics.newImage((imageDir or '').. 'test.png')
-- 	local ps = love.graphics.newParticleSystem(image, 1000)

	

-- 	return ps, 'alpha'
-- end

