--[[
  version.lua
  
  Centralized version management for the Invadors project.
  All version references should use this file to maintain consistency.
]]

local Version = {
  -- Main game version (MAJOR.MINOR.PATCH.BUILD)
  GAME_VERSION = "0.4.7.3",
  
  -- Save file version (for compatibility)
  SAVE_VERSION = "0.4.7.3",
  
  -- LÖVE version this game was made for
  LOVE_VERSION = "11.5",
  
  -- Build date (auto-generated)
  BUILD_DATE = os.date("%Y-%m-%d"),
  
  -- Build time (auto-generated)
  BUILD_TIME = os.date("%H:%M:%S"),
  
  -- Snap date for development builds
  SNAP_DATE = os.date("m%md%d"),
  
  -- Full version string with snap date
  FULL_VERSION = nil, -- Will be set below
  
  -- Version history and release notes
  CHANGELOG = {
    ["0.4.7.3"] = {
      date = "2025-08-16",
      changes = {
        "Added dinner simulation game state",
        "Implemented guest interaction system",
        "Added food consumption mechanics",
        "Created tooltip system for item descriptions",
        "Added real-time stats tracking",
        "Centralized version management system"
      }
    },
    ["0.4.7.2"] = {
      date = "2024-12-XX",
      changes = {
        "Added vape status game state",
        "Added driving simulation with physics",
        "Added world map state",
        "Enhanced wire art with bezier curves",
        "Implemented particle system",
        "Added comprehensive documentation",
        "Improved menu system and shortcuts",
        "Enhanced computer state with sticky notes",
        "Major kitchen state overhaul",
        "Improved inventory and character creation",
        "Enhanced editor tools and physics system"
      }
    }
  }
}

-- Generate full version string
Version.FULL_VERSION = Version.GAME_VERSION .. "." .. Version.SNAP_DATE

-- Helper functions
function Version:getGameVersion()
  return self.GAME_VERSION
end

function Version:getFullVersion()
  return self.FULL_VERSION
end

function Version:getSaveVersion()
  return self.SAVE_VERSION
end

function Version:getLoveVersion()
  return self.LOVE_VERSION
end

function Version:getBuildInfo()
  return {
    version = self.GAME_VERSION,
    fullVersion = self.FULL_VERSION,
    buildDate = self.BUILD_DATE,
    buildTime = self.BUILD_TIME,
    loveVersion = self.LOVE_VERSION
  }
end

function Version:getChangelog(version)
  return self.CHANGELOG[version] or nil
end

function Version:getLatestChangelog()
  return self.CHANGELOG[self.GAME_VERSION] or nil
end

-- Export the version information
return Version
