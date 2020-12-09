
-- local loggingOn = false
local loggingOn = DEBUG_LOGGING_ON

if loggingOn then
  -- https://love2d.org/wiki/love.window.getMode -- information about the window mode (fullscreen, vsync, size, etc.)
  local width, height, flags = love.window.getMode()
  print(width, height)
  print('flags: \n')
  print(string.format(" full screen? %s", flags['fullscreen']))
  print(string.format(" vsync? %s", flags['vsync']))
  print(string.format(" fs type? %s", flags['fullscreentype']))
  print(string.format(" refresh rate %s", flags['refreshrate']))


  print(string.format("\nLoading gamesaves from \n %s \n",
    love.filesystem.getSaveDirectory()
  ))
  -- print(string.format("Launched %s times.", self.saves))
  -- print(love.filesystem.getSaveDirectory())

end