--[[
  loaging_helpers.lua


  helper functions to load states whether their a file or a folder
]]

function logLoad(name)
  if DEBUG_LOGGING_LOADING then
    print('LOADING: ' .. name..'-state')
  end
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

function loadState(name, fileorfolder) end

function loadAllStates() end
