-- flood fill with canvas

function love.load()
	fill_canvas = love.graphics.newCanvas(100, 100)

	love.graphics.setCanvas(fill_canvas)
	fill_canvas:clear()
	love.graphics.setColor(255, 255, 0)
	love.graphics.circle("line", 50, 50, 20)
	love.graphics.setCanvas()

	fillimage = love.graphics.newImage(fill_canvas:getImageData())
end

function fill(image, x, y, red, green, blue)
	if black[1] == nil then
		adj = {-1, 0, 1, 0, -1, -1, 0, -1, 1, -1, -1, 1, 0, 1, 1, 1}
		pixels = image:getData()
		black[#black + 1] = {}
		black[#black].x = x
		black[#black].y = y
	end
	while #black > 0 do
		x = black[1].x; y = black[1].y
		table.remove(black, 1)
		pixels:setPixel(x, y, red, green, blue, 255)
		for i = 1, #adj, 2 do
-- instead of 100's should be variables, size of image
			if x + adj[i] > 0 and x + adj[i] < 100 and y + adj[i + 1] > 0 and y + adj[i + 1] < 100 then
				r, g, b, a = pixels:getPixel(x + adj[i], y + adj[i + 1])
				if (r == 0 and g == 0 and b == 0) then
					pixels:setPixel(x + adj[i], y + adj[i + 1], red, green, blue, 255)
					black[#black + 1] = {}
					black[#black].x = x + adj[i]
					black[#black].y = y + adj[i + 1]
				end
			end
		end
--	fill(image, x, y)
	end
end

function love.draw()
	black = {}
	fill(fillimage, 5, 5, 255, 0, 0)
	fill(fillimage, 50, 50, 255, 255, 0)
	fillimage = love.graphics.newImage(pixels)
	love.graphics.draw(fillimage, 200, 200)
end
