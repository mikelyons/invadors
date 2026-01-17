local denver = require 'denver'

function love.load()

	piano = love.graphics.newImage("data/piano.png")
	
	time = 0
	n = 1
	sPn = 0.3
	scaleMult = 0
	play = false
	playTime = 0
	lastI = 0
	rec = false
	recTime = 0
	recEnd = 0
	recTable = {}
	
	notes = {	'A0', 'A#0', 'B0', 'C1', 'C#1', 'D1', 'D#1', 'E1', 'F1', 'F#1', 'G1',  'G#1', 'A1', 'A#1', 'B1', 'C2', 'C#2', 'D2', 'D#2', 'E2', 'F2',
				'F#2', 'G2', 'G#2', 'A2', 'A#2', 'B2', 'C3', 'C#3', 'D3', 'D#3', 'E3', 'F3', 'F#3', 'G3', 'G#3', 'A3', 'A#3', 'B3', 'C4', 'C#4', 'D4', 'D#4', 'E4', 'F4', 'F#4', 'G4',
				'G#4', 'A4', 'A#4', 'B4', 'C5', 'C#5', 'D5', 'D#5', 'E5', 'F5', 'F#5', 'G5', 'G#5', 'A5', 'A#5', 'B5', 'C6', 'C#6', 'D6', 'D#6', 'E6',
				'F6', 'F#6', 'G6', 'G#6', 'A6', 'A#6', 'B6', 'C7', 'C#7', 'D7', 'D#7', 'E7', 'F7', 'F#7', 'G7', 'G#7', 'A7', 'A#7', 'B7', 'C8', 'C#8', 'D8', 'D#8', 'E8', 'F8', 'F#8', 'G8', 'G#8'
			}
end

function love.draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	love.graphics.print("Scale: " .. scaleMult/12 .. " (Up/Down)", 18,10)
	love.graphics.print("Note length(s): " .. sPn .. " (+/-)", 160,10)
	--love.graphics.print( "X:" .. love.mouse.getX() .. "  Y:" .. love.mouse.getY(),150,10)
	love.graphics.print("Note: " .. notes[n],18,30)
	if rec and not play then
		love.graphics.print("Recording (F1)",160,30)
	else
		love.graphics.print("Record (F1)",160,30)
	end
	
	if #recTable > 0 and not rec then
		if play then
			love.graphics.print("Playing (F2)",160,50)
		else
			love.graphics.print("Play (F2)",160,50)
		end
	end
	
	if #recTable > 0 and not rec then love.graphics.print("Delete recording (Delete)",160,70) end
	
	love.graphics.translate(0,50)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(piano, 10, 50)
	
	if love.keyboard.isDown( "a" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("A",33,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("A",33,193)
	end
		
	if love.keyboard.isDown( "w" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("W",50,143)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.print("W",50,143)
	end
	
	if love.keyboard.isDown( "s" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("S",74,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("S",74,193)
	end
	
	if love.keyboard.isDown( "d" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("D",116,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("D",116,193)
	end
	
	if love.keyboard.isDown( "r" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("R",137,143)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.print("R",137,143)
	end
	
	if love.keyboard.isDown( "f" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("F",159,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("F",159,193)
	end
	
	if love.keyboard.isDown( "t" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("T",179,143)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.print("T",179,143)
	end
	
	if love.keyboard.isDown( "g" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("G",199,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("G",199,193)
	end
	
	if love.keyboard.isDown( "h" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("H",241,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("H",241,193)
	end
	
	if love.keyboard.isDown( "u" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("U",263,143)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.print("U",263,143)
	end
	
	if love.keyboard.isDown( "j" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("J",285,193)
	else
		love.graphics.setColor(0,0,0)
		love.graphics.print("J",285,193)
	end
	
	if love.keyboard.isDown( "i" ) then
		love.graphics.setColor(0,255,0)
		love.graphics.print("I",304,143)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.print("I",304,143)
	end
	
end

function love.update(dt)

	
	
	time = time + dt
	
	if play and playTime <= recEnd then
		playTime = playTime + dt
		for i,v in ipairs(recTable) do
			if string.format("%.1f", playTime) == string.format("%.1f", v.rTime) then
				if i ~= lastI then
					local square = denver.get('square', notes[v.note], sPn)
					love.audio.play(square)
					lastI = i
				end
			end
		end
	else
		play = false
		playTime = 0
	end
	
	if rec then 
		recTime = recTime + dt 
	else
		recTime = 0
	end
	
	if love.keyboard.isDown( "up" ) and time > 0.3 then
		scaleMult = scaleMult + 12
		if scaleMult > 84 then scaleMult = 84 end
		time = 0
	end
	
	if love.keyboard.isDown( "down" ) and scaleMult >= 12 and time > 0.3 then
		scaleMult = scaleMult - 12
		time = 0
	end
	
	if love.keyboard.isDown( "kp+" ) and time > 0.1 then
		sPn = sPn + 0.01
		time = 0
	end
	
	if love.keyboard.isDown( "kp-" ) and time > 0.1 then
		sPn = sPn - 0.01
		time = 0
	end
	
	if sPn < 0.01 then sPn = 0.01 end
end

function love.keypressed(key, unicode)
	
	if key == "delete" then
		for rem = 1,#recTable do
			table.remove(recTable, 1)
		end
	end
	
	if key == "f2" then
		if play then
			play = false
		else
			play = true
		end
	end

	if key == "f1" then
		if rec then
			rec = false
			recEnd = recTime
		else
			rec = true
		end
	end
	
	if key == "a" then
		n = 1 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
		
	if key == "w" then
		n = 2 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "s" then
		n = 3 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "d" then
		n = 4 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "r" then
		n = 5 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "f" then
		n = 6 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "t" then
		n = 7 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "g" then
		n = 8 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "h" then
		n = 9 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "u" then
		n = 10 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "j" then
		n = 11 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	if key == "i" then
		n = 12 + scaleMult
		local square = denver.get('square', notes[n], sPn)
		love.audio.play(square)
		if rec then
			table.insert(recTable, {note = n, rTime = recTime})
		end
	end
	
	
end

