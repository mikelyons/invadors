-- Handlers
love.load
love.update(deltatime)
love.draw
love.mousepressed
love.keypressed
-- Physics
love.physics.newWorld(xg,yg,sleep)
love.physics.newRectangleShape(width,height)
love.physics.newBody(world,x,y,type)
love.physics.newFixture(body,shape,density)
x, y = body:getLinearVelocity()
body:getX
body:getY
body:getAngle
fixture:setFriction(value)
-- Graphics
love.graphics.newImage()
love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
love.graphics.setColor(red,green,blue,alpha)
love.graphics.rectangle(mode,x,y,width,height)
love.graphics.setBackgroundColor(red,green,blue)
love.graphics.print(text,x,y,r,sx,sy,ox,oy)
-- Metrics for image manipulation
image.png: 40, 40; center 20,20; size: 32,32

-- Colors (see Colors.lua)

-- ToDo's
Boxes, Score, Views, Drop Boxes

