--[[
  love_compat.lua

  LÖVE 10.2 to 11.5 Compatibility Layer

  This module provides helper functions to bridge the gap between
  LÖVE 10.2 and 11.5 APIs, particularly for:
  - Color conversion (0-255 to 0-1 range)
  - Deprecated filesystem functions
  - Audio source type parameter
]]

local compat = {}

-- Detect LÖVE version
local major, minor = love.getVersion()
compat.isLove11 = major >= 11 or (major == 0 and minor >= 11)

--- Convert colors from 0-255 range to 0-1 range
-- Automatically detects if conversion is needed
-- @param r Red component (0-255 or 0-1)
-- @param g Green component (0-255 or 0-1)
-- @param b Blue component (0-255 or 0-1)
-- @param a Alpha component (optional, defaults to 255/1)
-- @return r, g, b, a in 0-1 range
function compat.color(r, g, b, a)
  -- If any value > 1, assume 0-255 range and convert
  if r > 1 or g > 1 or b > 1 or (a and a > 1) then
    return r / 255, g / 255, b / 255, (a or 255) / 255
  end
  return r, g, b, a or 1
end

--- Convert a color table from 0-255 to 0-1 range
-- @param colorTable Table with {r, g, b, a} in 0-255 range
-- @return Table with values in 0-1 range
function compat.colorTable(colorTable)
  if not colorTable then return nil end
  local r, g, b, a = colorTable[1], colorTable[2], colorTable[3], colorTable[4]
  return {compat.color(r, g, b, a)}
end

--- Check if a file exists (replaces deprecated love.filesystem.exists)
-- @param path Path to check
-- @return boolean True if file exists
function compat.fileExists(path)
  if love.filesystem.getInfo then
    -- LÖVE 11.0+
    return love.filesystem.getInfo(path) ~= nil
  else
    -- LÖVE 10.2 fallback
    return love.filesystem.exists(path)
  end
end

--- Check if a path is a directory
-- @param path Path to check
-- @return boolean True if path is a directory
function compat.isDirectory(path)
  if love.filesystem.getInfo then
    local info = love.filesystem.getInfo(path)
    return info and info.type == "directory"
  else
    return love.filesystem.isDirectory(path)
  end
end

--- Check if a path is a file
-- @param path Path to check
-- @return boolean True if path is a file
function compat.isFile(path)
  if love.filesystem.getInfo then
    local info = love.filesystem.getInfo(path)
    return info and info.type == "file"
  else
    return love.filesystem.isFile(path)
  end
end

--- Get file size (replaces deprecated love.filesystem.getSize)
-- @param path Path to file
-- @return number File size in bytes, or nil if not found
function compat.getFileSize(path)
  if love.filesystem.getInfo then
    local info = love.filesystem.getInfo(path)
    return info and info.size
  else
    return love.filesystem.getSize(path)
  end
end

--- Create a new audio source with proper type parameter
-- @param path Path to audio file
-- @param sourceType "static" or "stream" (defaults to "static")
-- @return Source object
function compat.newSource(path, sourceType)
  sourceType = sourceType or "static"
  return love.audio.newSource(path, sourceType)
end

--- Set graphics color with automatic conversion
-- Wrapper for love.graphics.setColor that accepts 0-255 values
-- @param r Red (0-255 or 0-1)
-- @param g Green (0-255 or 0-1)
-- @param b Blue (0-255 or 0-1)
-- @param a Alpha (optional)
function compat.setColor(r, g, b, a)
  love.graphics.setColor(compat.color(r, g, b, a))
end

--- Set background color with automatic conversion
-- @param r Red (0-255 or 0-1)
-- @param g Green (0-255 or 0-1)
-- @param b Blue (0-255 or 0-1)
-- @param a Alpha (optional)
function compat.setBackgroundColor(r, g, b, a)
  love.graphics.setBackgroundColor(compat.color(r, g, b, a))
end

return compat
