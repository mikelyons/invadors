-- Score manager
-- Currently only one save file with stats on lines
-- future: @TODO - multiple save files with grades for different playstyles
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
    init = function()
    end,
    load = function(self)
      if not love.filesystem.exists('scores.lua') then
        scores = love.filesystem.newFile('scores.lua')
      end

      for lines in love.filesystem.lines('scores.lua') do
        table.insert(self.highscores, lines)
      end

      self.email      = self.highscores[6] or 'lyons.mr@gmail.com'
      self.machine    = self.highscores[5] or 'God'
      self.lastLaunch = os.date()
      self.highscore  = self.highscores[3] or 0
      self.saves      = self.highscores[2] or 0
      self.motd       = self.highscores[1] or ''

      print("")
      print("")
      print(self.motd)

      -- print(self.saves)

      print(string.format("\n Launched %s times. \n", self.saves))
    end,

    add = function(self, points)
      self.total = self.total + (points or 10)
    end,

    get = function(self)
      return self.total
    end,

    update = function(self)
      if self.total > tonumber(self.highscore) then
        self.highscore = self.total
      end
    end,

    draw = function(self)
      lg.setColor(0,255,0,255)
      lg.printf(self.motd,       100, 100, 320, 'left', 0, .85)
      lg.setColor(0,155,0,255)
      lg.printf(self.saves,      100, 160, 320, 'left', 0, .85)
      -- lg.printf(self.highscore, 100, 120, 320, 'left', 0, .85)
      -- lg.printf(self.total, 100,110, 320, 'left', 0, .85)
      lg.setColor(0,155,155,255)
      lg.printf(self.lastLaunch, 100, 280, 320, 'left', 0, .85)
    end,

    quit = function(self)
      self.saves = self.saves + 1
      love.filesystem.write('scores.lua',
        'First Line of Save file: each line is a value to load\n'.. -- the Message of the day
        self.saves     ..'\n'.. -- the number of times launched
        self.highscore ..'\n'.. -- the highest score achieved
        os.date()..'\n'.. -- the recording of the current ending launch date
        os.getenv('USERDOMAIN')..'\n'.. -- computers network name
        'lyons.mr@gmail.com'..'\n' -- replace this with the users email address
        -- print(os.getenv('PATH')) -- get environmental variable
        -- print(debug.getfenv(Game)) -- not sure what this does

        -- https://www.tenforums.com/tutorials/3234-environment-variables-windows-10-a.html

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

return Score
