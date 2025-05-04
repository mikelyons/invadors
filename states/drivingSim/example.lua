local PM7 = require "playmat"

function love.load()
	love.graphics.setDefaultFilter("nearest","nearest")
	
	img = love.graphics.newImage("map.png")
	spriteimg = love.graphics.newImage("sprite.png")
	
	--quad = love.graphics.newQuad(0,0,4,4,8,8)
	
	love.graphics.setBackgroundColor(0,0,200)
	
	sprites={{0,0}}
	
	--I get around 9 fps!
	--[[for x=4,1024,8 do
		for y=4,1024,8 do
			table.insert(sprites,{x,y})
		end
	end]]
	
	camera = PM7.newCamera(800,600)
end

function love.draw()	
	PM7.drawPlane(camera,img)
	
	--Camera point
	local x,y,s = PM7.toScreen(camera, camera:getPosition())
	love.graphics.circle("line",x,y,s/2)
	
	--To world!
	local x,y,s = PM7.toScreen(camera, PM7.toWorld(camera, love.mouse.getPosition()))
	love.graphics.circle("line",x,y,s/2)
	love.graphics.setColor(255,255,255,128)
	s=s*8
	love.graphics.draw(spriteimg,x,y,0,s/spriteimg:getWidth(),s/spriteimg:getHeight(),spriteimg:getWidth()/2,spriteimg:getHeight())
	love.graphics.setColor(255,255,255)

	--Sprites
	for i,v in ipairs(sprites) do
		PM7.placeSprite(camera,spriteimg,v[1],v[2],0,8,8)
	end
	PM7.renderSprites(camera)
	
	love.graphics.print("X: "..camera.x.."\nY: "..camera.y.."\nRot: "..camera.r.."\nFov: "..camera.f.."\nZoom: "..camera.z.."\nOffset: "..camera.o)
end

function love.update(dt)
	if love.keyboard.isDown("q") then
		camera:setRotation(camera:getRotation()-dt)
	elseif love.keyboard.isDown("e") then
		camera:setRotation(camera:getRotation()+dt)
	end
	
	if love.keyboard.isDown("w") then
		camera.x=camera.x+math.cos(camera.r)*40*dt
		camera.y=camera.y+math.sin(camera.r)*40*dt
	elseif  love.keyboard.isDown("s") then
		camera.x=camera.x-math.cos(camera.r)*40*dt
		camera.y=camera.y-math.sin(camera.r)*40*dt
	end
	
	if love.keyboard.isDown("a") then
		camera.x=camera.x+math.cos(camera.r-math.pi/2)*40*dt
		camera.y=camera.y+math.sin(camera.r-math.pi/2)*40*dt
	elseif  love.keyboard.isDown("d") then
		camera.x=camera.x+math.cos(camera.r+math.pi/2)*40*dt
		camera.y=camera.y+math.sin(camera.r+math.pi/2)*40*dt
	end
	
	if love.keyboard.isDown("i") then
		camera:setFov(camera:getFov()+dt)
	elseif  love.keyboard.isDown("o") then
		camera:setFov(camera:getFov()-dt)
	end
	if love.keyboard.isDown("k") then
		camera:setOffset(camera:getOffset()+dt)
	elseif  love.keyboard.isDown("l") then
		camera:setOffset(camera:getOffset()-dt)
	end
	if love.keyboard.isDown("-") then
		camera:setZoom(camera:getZoom()+dt*10)
	elseif  love.keyboard.isDown("=") then
		camera:setZoom(camera:getZoom()-dt*10)
	end
	
	love.window.setTitle("FPS: "..love.timer.getFPS())
end

function love.mousepressed(x,y,m)
	if m == 1 then
		table.insert(sprites,{PM7.toWorld(camera,x,y)})
	else
		table.remove(sprites)
	end
end
