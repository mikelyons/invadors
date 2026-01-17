hiragana = {}

function generateHiragana(thisHiragana)
	if type(thisHiragana) == "string" then
		for i in pairs(hiragana) do
			if hiragana[i]["r"] == thisHiragana then
				randomHiragana = hiragana[i]
			end
		end
	elseif type(thisHiragana) == "number" then
		randomHiragana = hiragana[thisHiragana]
	else
		randomHiragana = selectRandomHiragana()
	end
end

function selectRandomHiragana()
	local thisHiragana = nil
	
	while true do
		if useComposed then
			thisHiragana = hiragana[math.random(1, #hiragana)]
		else
			thisHiragana = hiragana[math.random(lowLimit, upLimit)]
		end
		
		if thisHiragana ~= randomHiragana then break end
	end
	
	return thisHiragana
end

function drawBackground()
	local scale = 800/screenWidth
	local width = screenWidth
	local height = 600/scale
	
	color(255,255,255,45)
	love.graphics.draw(background, screenWidth/2 - width/2, screenHeight/2 - height/2, 0, width/800, height/600)
end

function hprint(hiragana)
	setFont(hiraganaFont)
	color(0,0,0)
	lprint(hiragana, 
						screenWidth/2 - hiraganaFont:getWidth(randomHiragana["h"])/2, 
						screenHeight/2 - hiraganaFont:getHeight(randomHiragana["h"])/2 - 50)
end

function rprint(roomanji)
	setFont(roomanjiFont)
	color(0,0,0)
	lprint(roomanji, screenWidth/2 - roomanjiFont:getWidth(randomHiragana["r"])/2, screenHeight/2 - roomanjiFont:getHeight(randomHiragana["r"])/2 + 150)
end

function draw(image, x, y)
	love.graphics.draw(image, x or 0, y or 0)
end

function drawHUD()
	local hudLine = 10
	setFont(appFont)
	
	if showHUD then
		color(0, 0, 0)
		
		lprint("Test only Hiraganas in specified range: " .. tostring(not useComposed), 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("Show Shadows: " .. tostring(showShadow), 10, hudLine, false)
		hudLine = hudLine + 15 + 15
		
		lprint("Space - New Hiragana", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("Return - Toggle Roomanji", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("Up, Down, Left, Right - Change Hiragana generation limits", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("F1 - Toggle use of compound Hiraganas", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("F9 - Toggle HUD", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("F10 - Toggle Shadows", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("F12 - Toggle Fullscreen", 10, hudLine, false)
		hudLine = hudLine + 15
		lprint("ESC - Quit app", 10, hudLine, false)
		hudLine = hudLine + 15
	else
		color(170, 170, 170)
		lprint("Press F9 to show HUD", 10, 10, false)
	end
	
	color(100, 100, 100)
	lprint("From " .. hiragana[lowLimit]["h"] .. " to " .. hiragana[upLimit]["h"], 10, screenHeight - 20, false)
end

function color(r, g, b, a)
	love.graphics.setColor(r or 0, g or 0, b or 0, a or 255)
end

function lprint(str, x, y, shadow)
	if shadow == nil then shadow = showShadow end
	
	love.graphics.print(str, x, y)
	
	if shadow and showShadow then
		color(10, 10, 10, 65)
		love.graphics.print(str, x + 5, y + 5)
	end
end

function setFont(font)
	love.graphics.setFont(font)
end

function loadHiragana()
	print("Loading Hiragana data")
	
	hiragana[1] = {h = "あ", r = "a"} 
	hiragana[2] = {h = "い", r = "i"}
	hiragana[3] = {h = "う", r = "u"}
	hiragana[4] = {h = "え", r = "e"}
	hiragana[5] = {h = "お", r = "o"}
	hiragana[6] = {h = "か", r = "ka"}
	hiragana[7] = {h = "き", r = "ki"}
	hiragana[8] = {h = "く", r = "ku"}
	hiragana[9] = {h = "け", r = "ke"}
	hiragana[10] = {h = "こ", r = "ko"}
	hiragana[11] = {h = "さ", r = "sa"}
	hiragana[12] = {h = "し", r = "shi"}
	hiragana[13] = {h = "す", r = "su"}
	hiragana[14] = {h = "せ", r = "se"}
	hiragana[15] = {h = "そ", r = "so"}
	hiragana[16] = {h = "た", r = "ta"}
	hiragana[17] = {h = "ち", r = "chi"}
	hiragana[18] = {h = "つ", r = "tsu"}
	hiragana[19] = {h = "て", r = "te"}
	hiragana[20] = {h = "と", r = "to"}
	hiragana[21] = {h = "な", r = "na"}
	hiragana[22] = {h = "に", r = "ni"}
	hiragana[23] = {h = "ぬ", r = "nu"}
	hiragana[24] = {h = "ね", r = "ne"}
	hiragana[25] = {h = "の", r = "no"}
	hiragana[26] = {h = "は", r = "ha"}
	hiragana[27] = {h = "ひ", r = "hi"}
	hiragana[28] = {h = "ふ", r = "fu"}
	hiragana[29] = {h = "へ", r = "he"}
	hiragana[30] = {h = "ほ", r = "ho"}
	hiragana[31] = {h = "ま", r = "ma"}
	hiragana[32] = {h = "み", r = "mi"}
	hiragana[33] = {h = "む", r = "mu"}
	hiragana[34] = {h = "め", r = "me"}
	hiragana[35] = {h = "も", r = "mo"}
	hiragana[36] = {h = "や", r = "ya"}
	hiragana[37] = {h = "ゆ", r = "yu"}
	hiragana[38] = {h = "よ", r = "yo"}
	hiragana[39] = {h = "ら", r = "ra"}
	hiragana[40] = {h = "り", r = "ri"}
	hiragana[41] = {h = "る", r = "ru"}
	hiragana[42] = {h = "れ", r = "re"}
	hiragana[43] = {h = "ろ", r = "ro"}
	hiragana[44] = {h = "わ", r = "wa"}
	hiragana[45] = {h = "ゐ", r = "wi"}
	hiragana[46] = {h = "ゑ", r = "we"}
	hiragana[47] = {h = "を", r = "wo"}
	hiragana[48] = {h = "ん", r = "n"}
	
	hiragana[49] = {h = "が", r = "ga"}
	hiragana[50] = {h = "ぎ", r = "gi"}
	hiragana[51] = {h = "ぐ", r = "gu"}
	hiragana[52] = {h = "げ", r = "ge"}
	hiragana[53] = {h = "ご", r = "go"}
	hiragana[54] = {h = "ざ", r = "za"}
	hiragana[55] = {h = "じ ", r = "ji"}
	hiragana[56] = {h = "ず", r = " zu"}
	hiragana[57] = {h = "ぜ", r = "ze"}
	hiragana[58] = {h = "ぞ", r = "zo"}
	hiragana[59] = {h = "だ", r = "da"}
	hiragana[60] = {h = "ぢ", r = "ji"}
	hiragana[61] = {h = "づ", r = "zu"}
	hiragana[62] = {h = "で", r = "de"}
	hiragana[63] = {h = "ど", r = "do"}
	hiragana[64] = {h = "ば", r = "ba"}
	hiragana[65] = {h = "び", r = "bi"}
	hiragana[66] = {h = "ぶ", r = "bu"}
	hiragana[67] = {h = "べ", r = "be"}
	hiragana[68] = {h = "ぼ", r = "bo"}
	hiragana[69] = {h = "ぱ", r = "pa"}
	hiragana[70] = {h = "ぴ", r = "pi"}
	hiragana[71] = {h = "ぷ", r = "pu"}
	hiragana[72] = {h = "ぺ", r = "pe"}
	hiragana[73] = {h = "ぽ", r = "po"}
	
	hiragana[74] = {h = "きゃ", r = "kya"}
	hiragana[75] = {h = "きゅ", r = "kyu"}
	hiragana[76] = {h = "きょ", r = "kyo"}
	hiragana[77] = {h = "くゎ", r = "kwa"}
	hiragana[78] = {h = "しゃ", r = "sha"}
	hiragana[79] = {h = "しゅ", r = "shu"}
	hiragana[80] = {h = "しょ", r = "sho"}
	hiragana[81] = {h = "ちゃ", r = "cha"}
	hiragana[82] = {h = "ちゅ", r = "chu"}
	hiragana[83] = {h = "ちょ", r = "cho"}
	hiragana[84] = {h = "にゃ", r = "nya"}
	hiragana[85] = {h = "にゅ", r = "nyu"}
	hiragana[86] = {h = "にょ", r = "nyo"}
	hiragana[87] = {h = "ひゃ", r = "hya"}
	hiragana[88] = {h = "ひゅ", r = "hyu"}
	hiragana[89] = {h = "ひょ", r = "hyo"}
	hiragana[90] = {h = "みゃ", r = "mya"}
	hiragana[91] = {h = "みゅ", r = "myu"}
	hiragana[92] = {h = "みょ", r = "myo"}
	hiragana[93] = {h = "りゃ", r = "rya"}
	hiragana[94] = {h = "りゅ", r = "ryu"}
	hiragana[95] = {h = "りょ", r = "ryo"}
	
	hiragana[96] = {h = "ぎゃ", r = "gya"}
	hiragana[97] = {h = "ぎゅ", r = "gyu"}
	hiragana[98] = {h = "ぎょ", r = "gyo"}
	hiragana[99] = {h = "ぐゎ", r = "gwa"}
	hiragana[100] = {h = "じゃ", r = "ja"}
	hiragana[101] = {h = "じゅ", r = "ju"}
	hiragana[102] = {h = "じょ", r = "jo"}
	hiragana[103] = {h = "ぢゃ", r = "ja"}
	hiragana[104] = {h = "ぢゅ", r = "ju"}
	hiragana[105] = {h = "ぢょ", r = "jo"}
	hiragana[106] = {h = "びゃ", r = "bya"}
	hiragana[107] = {h = "びゅ", r = "byu"}
	hiragana[108] = {h = "びょ", r = "byo"}
	hiragana[109] = {h = "ぴゃ", r = "pya"}
	hiragana[110] = {h = "ぴゅ", r = "pyu"}
	hiragana[111] = {h = "ぴょ", r = "pyo"}
	
	print("    Total hiraganas: " .. #hiragana)
	print("Done")
end
