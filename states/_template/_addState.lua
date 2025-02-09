--[[
  addState.lua

  a script that can be run to add a gamestate
  from the template
  WIP
  -- creates in game save directory, needs rethought
  -- use native lua or a bash script/apple script
  @TODO - set up a new state from the template(s)
    - Detect if a state already has a the specified name
    - if not, create the directory
    - create the files in the directory
    - write all the custom configurations in the files

    @TODO - add the Security Guard state
]]

filename = 'testAddState'
linestable = {}
writeme = false

-- local dir = ""
-- --assuming that our path is full of lovely files (it should at least contain main.lua in this case)
-- local files = love.filesystem.enumerate(dir)
-- for k, file in ipairs(files) do
-- 	print(k .. ". " .. file) --outputs something like "1. main.lua"
-- end

_G.util = {}
function _G.util.addState(stateName)
  -- creates in game save directory, needs rethought
  if not love.filesystem.exists(stateName) then
    PrintColor(stateName..' is available!', 'green')
  else
    PrintColor(stateName..' is not available / taken!', 'red')
  end
end

-- if not love.filesystem.exists(filename) then
--   scores = love.filesystem.newFile(filename)
-- end

-- for lines in love.filesystem.lines(filename) do
--   table.insert(linestable, lines)
-- end

-- if writeme then
--   love.filesystem.write('scores.lua',
--     'First Line of Save file: each line is a value to load\n'.. -- the Message of the day
--     self.saves              ..'\n' .. -- the number of times launched
--     self.highscore          ..'\n' .. -- the highest score achieved
--     os.date()               ..'\n' .. -- the recording of the current ending launch date
--     os.getenv('USERDOMAIN') ..'\n' .. -- computers network name
--     self.email              ..'\n' .. -- replace this with the users email address
--     self.keyStroked         ..'\n' .. -- number of times a key was pressed
--     self.clicks             ..'\n' .. -- number of times mouse clicked
--     self.achievements       ..'\n'    -- number of times mouse clicked
--     -- 'save file version '..self.save_file_version  ..'\n'--..
--     -- 'letter grade    : '..self.letter_grade       ..'\n'--..
--   )
-- end