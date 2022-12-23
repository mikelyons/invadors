-- Score needs renamed and refactored:
-- https://www.youtube.com/watch?v=wjGbFrvt2Ok
-- Score manager
-- Currently only one save file with stats on lines
-- future: @TODO - multiple save files with grades for different playstyles
-- -- grid scores https://www.reddit.com/r/love2d/comments/w9us4g/comment/ii3w5nv/?utm_source=reddit&utm_medium=web2x&context=3
local binser   = require 'lib/binser/binser'

Score = {}

local lg = love.graphics
-- create an instance
function Score:new(self)
  return {
    highscores = {},
    saves      = 0,
    highscore  = 0,
    total      = 0,
    handicap   = 0,
    showscore = false,
    init = function() end,
    load = function(self)
      if not love.filesystem.exists('scores.lua') then
        scores = love.filesystem.newFile('scores.lua')
      end

      for lines in love.filesystem.lines('scores.lua') do
        table.insert(self.highscores, lines)
      end

      self.clicks     = self.highscores[8] or 0
      self.keyStroked = self.highscores[7] or 0
      self.email      = self.highscores[6] or 'lyons.mr@gmail.com'
      self.machine    = self.highscores[5] or 'God'
      self.lastLaunch = os.date()
      self.highscore  = tonumber(self.highscores[3]) or 0
      self.saves      = self.highscores[2] or 0
      self.motd       = self.highscores[1] or ''



      print("")
      print("")
      print("")
      print("=================================")
      print("=============SCORES==============")
      print("=================================")
      print("")
      print(self.motd)
      print("")
      print("=================================")
      print("")
      --TODO why does this break ?
      -- print(--'First Line of Save file: each line is a value to load\n'.. -- the Message of the day
      --   "Times Launched     : "..self.saves              ..'\n' .. -- the number of times launched
      --   "High Score         : "..self.highscore          ..'\n' .. -- the highest score achieved
      --   "Score this time    : "..self.total              ..'\n' .. -- the highest score achieved
      --   "Date               : "..os.date()               ..'\n' .. -- the recording of the current ending launch date
      --   'PC Name            : '..os.getenv('USERDOMAIN') ..'\n' .. -- computers network name
      --   'Email              : '..self.email              ..'\n' .. -- replace this with the users email address
      --   'Key Strokes        : '..self.keyStroked         ..'\n' .. -- number of times a key was pressed
      --   'Clicks             : '..self.clicks             ..'\n'    -- number of times mouse clicked
      -- )
      print("")
      print("")
      print("=================================")

      -- print(self.saves)

      print(string.format("\n Launched %s times. \n", self.saves))
    end,

    add = function(self, points)
      self.total = self.total + (points or 10)
      if self.total > self.highscore then
        self.highscore = self.total
      end
    end,
    setEmail = function(self, email)
      self.email = email
    end,
    getEmail = function(self)
      return self.email
    end,
    keypress = function(self, key, presses)
      self.keyStroked= self.keyStroked + (presses or 1)
      if key == 'tab' then self.showscore = true end
    end,
    keyrelease = function(self, key)
      if key == 'tab' then self.showscore = false end
    end,
    mousepress = function(self, presses)
      self.clicks = self.clicks + 1
    end,

    get = function(self)
      return self.total
    end,

    update = function(self)
    end,

    draw = function(self)
      local block = 
        "Times Launched     : "..self.saves              ..'\n' .. -- the number of times launched
        "High Score         : "..self.highscore          ..'\n' .. -- the highest score achieved
        "Total this time    : "..self.total              ..'\n' .. -- this round's score
        "Date               : "..os.date()               ..'\n' .. -- the recording of the current ending launch date
        'PC Name            : '..os.getenv('USERDOMAIN') ..'\n' .. -- computers network name
        'Email              : '..self.email              ..'\n' .. -- replace this with the users email address
        'Key Strokes        : '..self.keyStroked         ..'\n' .. -- number of times a key was pressed
        'Clicks             : '..self.clicks             ..'\n'    -- number of times mouse clicked


      if self.showscore then
        lg.setColor(0,55,0,240)
        love.graphics.rectangle("fill", 20,50, 480,640)
        lg.setColor(0,255,0,255)
        lg.printf(block, 100, 280, 320, 'left', 0, .85)
        lg.printf(self.motd,       100, 100, 320, 'left', 0, .85)
        -- lg.setColor(0,155,0,255)
        -- lg.printf(self.saves,      100, 160, 320, 'left', 0, .85)
        -- lg.printf(self.highscore, 100, 120, 320, 'left', 0, .85)
        -- lg.printf(self.total, 100,110, 320, 'left', 0, .85)
        lg.setColor(0,155,155,255)
        -- lg.printf(self.lastLaunch, 100, 280, 320, 'left', 0, .85)
      end
    end,

    quit = function(self)
      -- love.timer.sleep(3)
      self.saves = self.saves + 1

      print("raint")
      -- ok, msg = pcall(self:getEmail ,'')  
      print(self:getEmail())
      print("raint")

        -- Where is this save file?
        -- %appdata%\LOVE\invadors_save_directory
        -- https://love2d.org/wiki/love.filesystem.setIdentity
        -- print(os.getenv('PATH')) -- get environmental variable
        -- print(debug.getfenv(Game)) -- not sure what this does
        -- https://www.tenforums.com/tutorials/3234-environment-variables-windows-10-a.html

      love.filesystem.write('scores.lua',
        'First Line of Save file: each line is a value to load\n'.. -- the Message of the day
        self.saves              ..'\n' .. -- the number of times launched
        self.highscore          ..'\n' .. -- the highest score achieved
        os.date()               ..'\n' .. -- the recording of the current ending launch date
        os.getenv('USERDOMAIN') ..'\n' .. -- computers network name
        self.email              ..'\n' .. -- replace this with the users email address
        self.keyStroked         ..'\n' .. -- number of times a key was pressed
        self.clicks             ..'\n'    -- number of times mouse clicked
      )

    end


    -- attempt to break out serialization for more flexibility
    -- serializeScores = function(self)
    --   local scoreString = string.format(" %s\n %s\n %s\n %s\n ",
    --   self.motd,
    --   self.saves,
    --   self.highscore,
    --   os.date() -- this tracks the last time the game launched
    -- )
    -- end
  }
end

-- function Score:keypressed(self, key, code) end
-- function Score:mousepressed(x, y, button, istouch) end
-- function Score:mousereleased(x, y, button) end

return Score
