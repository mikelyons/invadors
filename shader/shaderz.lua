--http://blogs.love2d.org/content/beginners-guide-shaders
function love.load()
	myShader = love.graphics.newShader[[
		extern number factor = 0;
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
			vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color 
			        
			number average = (pixel.r+pixel.b+pixel.g)/3.0;

			pixel.r = pixel.r + (average-pixel.r) * factor;
			pixel.g = pixel.g + (average-pixel.g) * factor;
			pixel.b = pixel.b + (average-pixel.b) * factor; 


			return pixel;	
		}
	]]
	joe = love.graphics.newImage("Joe.png")
	time = 0;
end

function love.update(dt)
	time = time + dt;
	local factor = math.abs(math.cos(time)); --so it keeps going/repeating
	myShader:send("factor",factor)
end

function love.draw()
	love.graphics.setShader(myShader)
	love.graphics.draw(joe,250,100)
	love.graphics.setShader()
end