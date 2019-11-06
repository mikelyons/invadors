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

      self.highscore  = self.highscores[3]
      self.saves      = self.highscores[2]
      self.motd       = self.highscores[1]
      print(self.motd)
      print(self.saves)
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
      lg.printf(self.total, 100,100, 320, 'left', 0, .85)
      lg.printf(self.highscore, 100,110, 320, 'left', 0, .85)
    end,
    quit = function(self)
      self.saves = self.saves + 1
      love.filesystem.write('scores.lua',
        'First Line of Save file: each line is a value to load\n'..
        self.saves..'\n'.. 
        self.highscore
        )
    end
  }
end

return Score
