
-- local loggingOn = false
local loggingOn = DEBUG_LOGGING_ON

if loggingOn then
  -- https://love2d.org/wiki/love.window.getMode
  -- information about the window mode (fullscreen, vsync, size, etc.)
  print(love.window.getMode()) -- is this useful? no?


  print(string.format("Loading gamesaves from \n %s \n",
    love.filesystem.getSaveDirectory()
  ))
  -- print(string.format("Launched %s times.", self.saves))
  -- print(love.filesystem.getSaveDirectory())

end