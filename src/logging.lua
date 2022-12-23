function luaInfo()
	local info = "Lua version: " .. _VERSION .. "\n"
	info = info .. "LuaJIT version: "

	if (jit) then
		info = info .. jit.version
	else
		info = info .. "this is not LuaJIT"
	end

	return info
end

-- local loggingOn = false
local loggingOn = DEBUG_LOGGING_ON

if loggingOn then
  -- broken?
  require("../lib/debug/lovedebug")
  require("../tools/resolution")

  print("")
  print("")
  print("/////////////////- LOGGING ON -////////////////////")
  print("")

  -- https://love2d.org/wiki/love.window.getMode -- information about the window mode (fullscreen, vsync, size, etc.)
  -- record an
  local width, height, flags = love.window.getMode()
  print(width, height)

  print(luaInfo())

  print('clipboard : ')
  print(love.system.getClipboardText())
  print('OS : ')
  print(love.system.getOS())
  print('Power Info : ')
  print(love.system.getPowerInfo())
  print('Proc count: ')
  print(love.system.getProcessorCount())
  print('BMG : ')
  print(love.system.hasBackgroundMusic)
  -- love.system.openURL(sharewareURL)
  -- love.system.setClipboardText(sharewareAffiliateAd)
  -- love.system.vibrate() -- vibe when loaded

  -- print('flags: \n'..flags)
  print("\27[101;93m YOUR TEXT HERE \27[0m")
  -- text = string.gsub('raint', "[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
  -- print(text)

  -- local codes = {reset = "\x1B[m", red = "\x1B[31m", green = "\x1B[32m", --[[ rest left as exercise :P ]]}
  -- function printC(colour, ...)
  --   if not codes[colour] then error("Undefined colour: " .. colour) end
  --   io.write(codes[colour])
  --   print(...)
  --   io.write(codes.reset)
  -- end

  -- printC("red", "This text is red", "This one too")
  -- print("This is normal")
  -- printC("reset", "This is normal too")


  -- print(string.format(" full screen? %s", flags['fullscreen']))
  -- print(string.format(" vsync? %s", flags['vsync']))
  -- print(string.format(" fs type? %s", flags['fullscreentype']))
  -- print(string.format(" refresh rate %s", flags['refreshrate']))


  print(string.format("Loading gamesaves from - %s ...",
    love.filesystem.getSaveDirectory()
  ))
  -- print(string.format("Launched %s times.", self.saves))

  print("")
  print("//////////////////- LOGGING -/////////////////////")
  print("")
  print("")

end
