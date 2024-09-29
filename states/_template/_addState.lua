--[[
  addState.lua

  a script that can be run to add a gamestate
  from the template
  WIP
]]

filename = 'testAddState'
linestable = {}
writeme = false

if not love.filesystem.exists(filename) then
  scores = love.filesystem.newFile(filename)
end

for lines in love.filesystem.lines(filename) do
  table.insert(linestable, lines)
end

if writeme then
  love.filesystem.write('scores.lua',
    'First Line of Save file: each line is a value to load\n'.. -- the Message of the day
    self.saves              ..'\n' .. -- the number of times launched
    self.highscore          ..'\n' .. -- the highest score achieved
    os.date()               ..'\n' .. -- the recording of the current ending launch date
    os.getenv('USERDOMAIN') ..'\n' .. -- computers network name
    self.email              ..'\n' .. -- replace this with the users email address
    self.keyStroked         ..'\n' .. -- number of times a key was pressed
    self.clicks             ..'\n' .. -- number of times mouse clicked
    self.achievements       ..'\n'    -- number of times mouse clicked
    -- 'save file version '..self.save_file_version  ..'\n'--..
    -- 'letter grade    : '..self.letter_grade       ..'\n'--..
  )
end