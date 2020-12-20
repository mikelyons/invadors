local BloodParticle = {}

function BloodParticle:new(x,y,img)
    local particle = {}
    particle.x = x or 100
    particle.y = y or 100
    particle.img = img
  -- local img = 
  -- local particle = require('src/particles/baseParticle'):new(x,y,img)

  -- local options = {
  --   [''] = ''
  -- }
  function particle:load()
    local imageDir = '/assets/particles/'
    particle.image = particle.img or love.graphics.newImage((imageDir or '').. 'blood1.png')
    particle.system = love.graphics.newParticleSystem(particle.image, 1000)

    particle.system:setParticleLifetime(.3,9)

    particle.system:setLinearAcceleration(-20, -200, 200, 20)
    -- particle.system:setEmissionRate(300)
    particle.system:setSpeed(-10,10)
    particle.system:setRotation(10,20) 
    particle.system:setSpin(0.02, 15)

  end
  function particle:emit()
    self.system:emit(32) 
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

return BloodParticle