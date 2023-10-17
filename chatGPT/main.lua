local particles = {}

function love.load()
  for i = 1, 100 do
    local particle = {
      x = math.random(0, love.graphics.getWidth()),
      y = math.random(0, love.graphics.getHeight()),
      xvel = math.random(-100, 100),
      yvel = math.random(-100, 100),
      size = math.random(5, 10),
      color = {math.random(), math.random(), math.random()}
    }
    table.insert(particles, particle)
  end
end

function love.update(dt)
  for i, particle in ipairs(particles) do
    particle.x = particle.x + particle.xvel * dt
    particle.y = particle.y + particle.yvel * dt
  end
end

function love.draw()
  for i, particle in ipairs(particles) do
    love.graphics.setColor(particle.color)
    love.graphics.circle("fill", particle.x, particle.y, particle.size)
  end
end
