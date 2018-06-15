require('camera')

math.randomseed(os.time())
math.random()
math.random()
math.random()

function love.load(args)
  camera.layers = {}
  
  for i = .5, 3, .5 do
    local rectangles = {}
    
    for j = 1, math.random(2, 15) do
      table.insert(rectangles, {
        math.random(0, 1600),
        math.random(0, 1600),
        math.random(50, 400),
        math.random(50, 400),
        color = { math.random(0, 255), math.random(0, 255), math.random(0, 255) }
      })
    end
    
    camera:newLayer(i, function()
      for _, v in ipairs(rectangles) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle('fill', unpack(v))
        love.graphics.setColor(255, 255, 255)
      end
    end)
  end
end

function love.update(dt)
  camera:setPosition(love.mouse.getX() * 2, love.mouse.getY() * 2)
end

function love.draw()
  camera:draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 2)
end

function love.keypressed(key, unicode)
  if key == ' ' then
    love.load()
  elseif key == 'escape' then
    love.event.push('q')
  end
end