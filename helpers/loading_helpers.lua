
function logLoad(name)
  print('LOADING: ' .. name..'-state')
end
-- loads states that are a folder instead of a file
function loadStateFolder(name)
  local path = "states/" .. name .. '/' .. name
  require(path)
  logLoad(name..' folder')
end

-- loads states that are a single file
function loadStateFile(name)
  local path = "states/" .. name
  require(path)
  logLoad(name..' file')
end

function loadMenuStateFile(name)
  local path = 'states/menu/' .. name
  require(path)
  logLoad(name..' file')
end