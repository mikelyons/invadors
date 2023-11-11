--[[

Simple ASCII Art Generator.
This was created as a TEST
by 10$man

]]--


--White OR Black. If 1, then white will be black, if 2 then white will be white.
WORB = 1

--Get the image.
--We will split this up into RGB values soon
IMAGE = love.image.newImageData( "PIC.PNG" )

if not IMAGE then
	error("IMAGE WASN'T LOADED!")
end
--Get the width and height of the image:
IMAGE_WIDTH = IMAGE:getWidth()
IMAGE_HEIGHT = IMAGE:getHeight()


--Create a table to store our image
--Table will be structures like so: TABLE[x][y] = {r, g, b}
IMAGE_COLORS = {}


--Loop through our image and fill our table with the data
for a = 1, IMAGE_WIDTH do
	IMAGE_COLORS[a] = {}
	for b = 1, IMAGE_HEIGHT do
		IMAGE_COLORS[a][b] = {}
		
		local temp_r = 0
		local temp_g = 0
		local temp_b = 0
		
		temp_r, temp_g, temp_b = IMAGE:getPixel(a - 1, b - 1)
		
		IMAGE_COLORS[a][b] = {temp_r, temp_g, temp_b}
	end
end



--Create a table that will have ASCII characters
CHARS = {
"A", --1
"D", --2
"V", --3
"H", --4
"X", --5
"O", --6
"1", --7
"/", --8
"?", --9
":", --10
"}", --11
"+", --12
"-", --13
"$", --14
"#", --15
"@", --16
"!" --17
}

--Table that will hold our ASCII art:
ROWS = {}

--And finally, generate our ASCII art!
for a = 1, IMAGE_HEIGHT do
	ROWS[a] = {}
	ROWS[a] = ""
	for b = 1, IMAGE_WIDTH do
		
		ASCII = ""
		--First, get the ASCII character for our pixel:
		AVG = (IMAGE_COLORS[b][a][1] + IMAGE_COLORS[b][a][2] + IMAGE_COLORS[b][a][3]) / 3
		
		if AVG == 255 and WORB == 1 then
			ASCII = " "
		elseif AVG == 0 and WORB == 0 then
			ASCII = " "
		else
			AVG = (AVG * 17) / (255 * 3)
			AVG = math.floor(AVG)
			if AVG > 17 then
				AVG = 17
			elseif AVG < 1 then
				AVG = 1
			end
			ASCII = CHARS[AVG]
		end
		
		ROWS[a] = ROWS[a] .. ASCII
	end
end

--Save the art to a file
file = love.filesystem.newFile("IMAGE.TXT")

file:open('w')
file:write(ROWS[1] .. "\n")
file:close()

for a = 2, #ROWS do
	file:open('a')
	file:write(ROWS[a] .. "\n")
	file:close()
end

--Now lets display this art on le screen :D

function love.draw()
	for a = 1, #ROWS do
		love.graphics.print(ROWS[a], 0, a * 12)
	end
end

--[[
  INVERTED = false

--Get the image.
--We will split this up into RGB values soon
IMAGE = love.image.newImageData( "PIC.PNG" )

if not IMAGE then
	error("IMAGE WASN'T LOADED!")
end

--Create a table that will have ASCII characters
CHARS = {
"A", --1
"D", --2
"V", --3
"H", --4
"X", --5
"O", --6
"1", --7
"/", --8
"?", --9
":", --10
"}", --11
"+", --12
"-", --13
"$", --14
"#", --15
"@", --16
"!" --17
}

--Table that will hold our ASCII art:
ROWS = {}

--And finally, generate our ASCII art!
for a = 1, IMAGE:getHeight() do
	ROWS[a] = ""
	for b = 1, IMAGE:getWidth() do
		--First, get the ASCII character for our pixel:
		R, G, B = IMAGE:getPixel(b - 1, a - 1)
		AVG = (R + G + B) / 3
		
		if (AVG == 255 and not INVERTED) or (AVG == 0 and INVERTED) then
			ASCII = " "
		else
			CHAR_INDEX = math.floor((#CHARS-1) * (AVG/255) + 1)
			ASCII = CHARS[CHAR_INDEX]
		end
		
		ROWS[a] = ROWS[a] .. ASCII
	end
end

--Save the art to a file
FILENAME = 'IMAGE.TXT'
love.filesystem.remove(FILENAME)
file = love.filesystem.newFile(FILENAME)

for a = 1, #ROWS do
	file:open('a')
	file:write(ROWS[a] .. "\n")
	file:close()
end

--Now lets display this art on le screen :D

function love.draw()
	for a = 1, #ROWS do
		love.graphics.print(ROWS[a], 0, a * 12)
	end
end

]]
