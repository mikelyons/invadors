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
  print("src/logging.lua")
  print("")

  -- https://love2d.org/wiki/love.window.getMode -- information about the window mode (fullscreen, vsync, size, etc.)
  -- record an
  local width, height, flags = love.window.getMode()
  print(width, height)

  print(luaInfo())

  print("///- SYSTEM STATE -///")
  print('clipboard : ')
  print(love.system.getClipboardText())
  print("")
  print('OS : ')
  print(love.system.getOS())
  print("")
  print('Power Info : ')
  print(love.system.getPowerInfo())
  print("")
  print('Proc count: ')
  print(love.system.getProcessorCount())
  print("")
  print('BMG : ')
  print(love.system.hasBackgroundMusic)
  print("")
  -- love.system.openURL(sharewareURL)
  -- love.system.setClipboardText(sharewareAffiliateAd)
  -- love.system.vibrate() -- vibe when loaded

  -- learn about this hear
  -- https://superuser.com/questions/413073/windows-console-with-ansi-colors-handling
  -- https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences?redirectedfrom=MSDN

  -- print('flags: \n'..flags)
  print("\27[101;93m YOUR TEXT HERE \27[0m")
  print("\27[7;31m YOUR TEXT HERE \27[0m")
  print("\27[7;91m YOUR TEXT HERE \27[0m")
  print("\27[101;91m YOUR TEXT HERE \27[0m")
  print("\27[101;93m YOUR TEXT HERE \27[0m")
  print("\27[101;31m YOUR TEXT HERE \27[0m")
  print("\27[1;31m YOUR TEXT HERE \27[0m")
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

else -- does this trigger?!?
  print("/////////////////- LOGGING OFF!!! -////////////////////")
  print("\27[101;93m LOGGING OFF!!! \27[0m")

end
