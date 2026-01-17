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
  print("Loading state folder:", path)
  local success, err = pcall(function() require(path) end)
  if success then
    logLoad(name..' folder')
    print("Successfully loaded state folder:", name)
  else
    print("Failed to load state folder:", name, "Error:", err)
  end
end

-- loads states that are a single file
function loadStateFile(name)
  local path = "states/" .. name
  print("Loading state file:", path)
  local success, err = pcall(function() require(path) end)
  if success then
    logLoad(name..' file')
    print("Successfully loaded state file:", name)
  else
    print("Failed to load state file:", name, "Error:", err)
  end
end

function loadMenuStateFile(name)
  local path = 'states/menu/' .. name
  require(path)
  logLoad(name..' file')
end

function loadState(name, fileorfolder) end

function loadAllStates() end
