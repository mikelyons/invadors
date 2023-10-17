require "nihongo"

__VER="1.1"
__APPNAME = "Nihongo"

background = {}

screenWidth = 800
screenHeight = 600
randomBackground = nil

hiraganaFont = love.graphics.newFont("data/font/Japanese.ttf", 200)
roomanjiFont = love.graphics.newFont("data/font/Japanese.ttf", 35)
appFont = love.graphics.newFont("data/font/Japanese.ttf", 15)

randomHiragana = nil

fullScreen = false
showShadow = true
useComposed = true
showRoomanji = true
showHUD = true

upLimit = 111
lowLimit = 1

function love.load()
	print("\n\nLoading " .. __APPNAME .. " ver. " .. __VER .. " Please be patient...")
	
	initData()
	
	print ("Loading config file")
	if love.filesystem.exists("nih.cfg") then
		ok, config = pcall(love.filesystem.load, "nih.cfg")
		
		if ok then 
			config() 
			print ("Done")
		else
			print ("Invalid Config file not loaded. Using defaults")
		end
	else
		print ("No config file found. Using defaults")
	end
	
	setScreen()
	
	generateHiragana()
	
	love.keyboard.setKeyRepeat(0.5, 0.08)
	
	print ("\nWelcome to Nihongo!!!")
end

function love.draw()
	drawBackground()
	hprint(randomHiragana["h"])
	if showRoomanji then rprint(string.upper(randomHiragana["r"])) end
	drawHUD()
end

function love.keypressed(key, unicode)
	if key == "escape" then
		sayoonara()
	elseif key == " " then
		generateHiragana()
	elseif key == "return" then
		showRoomanji = not showRoomanji
	elseif key == "f1" then
		useComposed = not useComposed
	elseif key == "f9" then
		showHUD = not showHUD
	elseif key == "f10" then
		showShadow = not showShadow
	elseif key == "f12" then
		fullScreen = not fullScreen
		setScreen()
		
	elseif key == "left" then
		lowLimit = lowLimit - 1
		if lowLimit < 1 then lowLimit = 1 end
	elseif key == "right" then
		lowLimit = lowLimit + 1
		if lowLimit >= upLimit then lowLimit = upLimit - 1 end
	elseif key == "down" then
		upLimit = upLimit - 1
		if upLimit <= lowLimit then upLimit = lowLimit + 1 end
	elseif key == "up" then
		upLimit = upLimit + 1
		if upLimit > #hiragana then upLimit = #hiragana end
	end
end

function love.mousepressed(x, y, button)
	generateHiragana()
end

function sayoonara()
	local configuration = nil
	
	configuration = "--[[ Nihongo Configuration file --]]\n"
	configuration = configuration .. "\nfullScreen = " .. tostring(fullScreen)
	configuration = configuration .. "\nshowShadow = " .. tostring(showShadow)
	configuration = configuration .. "\nuseComposed = " .. tostring(useComposed)
	configuration = configuration .. "\nshowRoomanji = " .. tostring(showRoomanji)
	configuration = configuration .. "\nshowHUD = " .. tostring(showHUD)
	configuration = configuration .. "\nlowLimit = " .. tostring(lowLimit)
	configuration = configuration .. "\nupLimit = " .. tostring(upLimit)
	configuration = configuration .. "\nscreenWidth = " .. screenWidth
	configuration = configuration .. "\nscreenHeight = " .. screenHeight
	
	love.filesystem.write("nih.cfg", configuration)
	
	love.event.push("quit")
end

function setScreen()
	print ("Setting up Screen")
	love.graphics.setBackgroundColor({255,255,255,255})
	print("    Screen is " .. screenWidth .. "x" .. screenHeight)
	love.graphics.setMode(screenWidth, screenHeight, fullScreen, false)
	print ("Done")
end


function initData()
	print ("Loading backgrounds.")
	-- init backgrounds
	local list = love.filesystem.enumerate("data/background/")
	
	randomBackground = math.random(1, #list)
	
	background = love.graphics.newImage("data/background/background" .. randomBackground .. ".jpg")
	
	print ("Done")
	
	loadHiragana()
end
