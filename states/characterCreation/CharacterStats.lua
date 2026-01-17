--[[
  CharacterStats.lua

  Data model for character stats with definitions, defaults,
  validation, and visual parameter calculation.

  Usage:
    local CharacterStats = require('states/characterCreation/CharacterStats')

    local stats = CharacterStats:new()
    stats.strength = 15
    stats.agility = 12

    local bodyParams = CharacterStats:getBodyParams(stats)
    -- bodyParams contains calculated visual dimensions
]]

local CharacterStats = {}
CharacterStats.__index = CharacterStats

-- Stat definitions with min, max, default, and label
CharacterStats.DEFINITIONS = {
  strength = {
    min = 1,
    max = 20,
    default = 10,
    label = "Strength",
    order = 1,
  },
  agility = {
    min = 1,
    max = 20,
    default = 10,
    label = "Agility",
    order = 2,
  },
  constitution = {
    min = 1,
    max = 20,
    default = 10,
    label = "Constitution",
    order = 3,
  },
  height = {
    min = 150,
    max = 210,
    default = 175,
    label = "Height (cm)",
    order = 4,
  },
  weight = {
    min = 50,
    max = 150,
    default = 75,
    label = "Weight (kg)",
    order = 5,
  },
}

-- Get ordered list of stat keys
function CharacterStats:getStatOrder()
  local stats = {}
  for key, def in pairs(self.DEFINITIONS) do
    table.insert(stats, {key = key, order = def.order})
  end
  table.sort(stats, function(a, b) return a.order < b.order end)
  local ordered = {}
  for _, stat in ipairs(stats) do
    table.insert(ordered, stat.key)
  end
  return ordered
end

--- Create a new stats object with default values
-- @return table Stats object with default values
function CharacterStats:new()
  local stats = {}
  for key, def in pairs(self.DEFINITIONS) do
    stats[key] = def.default
  end
  return stats
end

--- Validate and clamp stats to valid ranges
-- @param stats table The stats object to validate
-- @return table The validated stats object
function CharacterStats:validate(stats)
  for key, def in pairs(self.DEFINITIONS) do
    if stats[key] then
      stats[key] = math.max(def.min, math.min(def.max, stats[key]))
    else
      stats[key] = def.default
    end
  end
  return stats
end

--- Calculate a normalized ratio (0-1) for a stat
-- @param stats table The stats object
-- @param statKey string The stat key
-- @return number Normalized ratio (0-1)
function CharacterStats:getNormalizedValue(stats, statKey)
  local def = self.DEFINITIONS[statKey]
  if not def then return 0.5 end
  local range = def.max - def.min
  if range == 0 then return 0.5 end
  return (stats[statKey] - def.min) / range
end

--- Calculate body visual parameters from stats
-- @param stats table The stats object
-- @return table Body parameters for rendering
function CharacterStats:getBodyParams(stats)
  -- Get normalized values (0-1 range)
  local strNorm = self:getNormalizedValue(stats, "strength")
  local agiNorm = self:getNormalizedValue(stats, "agility")
  local conNorm = self:getNormalizedValue(stats, "constitution")
  local heightNorm = self:getNormalizedValue(stats, "height")
  local weightNorm = self:getNormalizedValue(stats, "weight")

  -- Base dimensions (from original drawMan.lua)
  local baseBoxWidth = 300
  local baseBoxHeight = 80
  local baseHeadRadius = 64

  -- Calculate modifiers from stats:
  -- Strength (1-20): affects shoulder/chest width and muscle shading
  -- Range: 0.8x to 1.2x for width
  local strengthWidthMod = 0.8 + (strNorm * 0.4)
  local shadingAlpha = 0.3 + (strNorm * 0.7)

  -- Agility (1-20): affects abdomen taper (higher = slimmer waist)
  -- Base tapers are 0.8, 0.5, 0.33 - higher agility increases taper
  local baseTaper1 = 0.8
  local baseTaper2 = 0.5
  local baseTaper3 = 0.33
  local agilityTaperMod = 1.0 - (agiNorm * 0.3)  -- 0.7 to 1.0 multiplier
  local taper1 = baseTaper1 * agilityTaperMod
  local taper2 = baseTaper2 * agilityTaperMod
  local taper3 = baseTaper3 * agilityTaperMod

  -- Constitution (1-20): affects torso height and head size
  -- Range: 0.85x to 1.15x
  local constitutionMod = 0.85 + (conNorm * 0.3)

  -- Height (150-210): affects global scale
  -- Range: 0.7x to 1.3x
  local globalScale = 0.7 + (heightNorm * 0.6)

  -- Weight (50-150): affects body width and reduces taper effect
  -- Range: 0.9x to 1.2x for width, also reduces taper
  local weightWidthMod = 0.9 + (weightNorm * 0.3)
  local weightTaperReduction = weightNorm * 0.2  -- Reduce taper difference
  taper1 = taper1 + (1 - taper1) * weightTaperReduction
  taper2 = taper2 + (1 - taper2) * weightTaperReduction
  taper3 = taper3 + (1 - taper3) * weightTaperReduction

  -- Calculate final dimensions
  local finalWidthMod = strengthWidthMod * weightWidthMod

  return {
    -- Main dimensions
    boxWidth = baseBoxWidth * finalWidthMod * globalScale,
    boxHeight = baseBoxHeight * constitutionMod * globalScale,
    headRadius = baseHeadRadius * constitutionMod * globalScale,

    -- Taper ratios for abdomen sections
    taper1 = taper1,  -- First abdomen section (shoulders → waist)
    taper2 = taper2,  -- Second abdomen section
    taper3 = taper3,  -- Third abdomen section (hips)

    -- Global scale factor
    scale = globalScale,

    -- Visual effects
    shadingAlpha = shadingAlpha,

    -- Eye offset (proportional to head size)
    eyeRadius = 16 * globalScale,
    eyeOffsetX = 32 * globalScale,
    eyeOffsetY = 32 * globalScale,

    -- Tattoo bar dimensions
    tattooBarHeight = 4 * globalScale,
    tattooBarWidth = 64 * globalScale,

    -- Nipple dimensions
    nippleSize = 32 * globalScale,
  }
end

return CharacterStats
