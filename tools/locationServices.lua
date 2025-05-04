--[[
  locationServices.lua - WIP - not yet implemented or integrated, copypasta from google example result
  
  Request and handle permissions for and organize location services for mobile devices and any other platforms that can use them
  @TODO - break out the OS detection and permissions handling and limit this to GPS only
  ]]

-- Check for GPS availability and permissions
local gps = love.gps
local isMobile = love.system.getOS() == "android" or love.system.getOS() == "ios"

if isMobile then
  -- Request location permissions
  love.system.requestPermissions({ "location" })

  -- Check if location permissions are granted
  if love.system.hasPermission("location") then
    -- Start GPS tracking
    gps:start()

    -- Get location data
    local position = gps:getPosition()
    if position then
      local latitude = position.latitude
      local longitude = position.longitude
      local altitude = position.altitude
      local accuracy = position.accuracy
      print("Latitude:", latitude)
      print("Longitude:", longitude)
      print("Altitude:", altitude)
      print("Accuracy:", accuracy)
    end

    -- Stop GPS tracking
    gps:stop()
  else
    print("Location permissions not granted.")
  end
else
  print("GPS not available on this platform.")
end