--[[
  theme.lua

  Centralized UI theming system for consistent styling across the game.
  Provides colors, dimensions, fonts, and spacing constants.

  All colors are in LÖVE 11+ format (0.0 - 1.0 range).

  Usage:
    local Theme = require('src/ui/theme')

    love.graphics.setColor(Theme.colors.button.normal)
    love.graphics.rectangle('fill', x, y, Theme.button.width, Theme.button.height)
]]

local Theme = {}

-- Color palette (LÖVE 11+ format: 0.0 - 1.0)
Theme.colors = {
  -- Primary colors
  primary = {0.3, 0.5, 0.8, 1},
  secondary = {0.4, 0.6, 0.4, 1},
  accent = {0.9, 0.6, 0.2, 1},

  -- UI element colors
  button = {
    normal = {80/255, 80/255, 100/255, 1},
    hover = {100/255, 100/255, 120/255, 1},
    pressed = {60/255, 60/255, 80/255, 1},
    disabled = {50/255, 50/255, 50/255, 1},
    text = {1, 1, 1, 1},
    textDisabled = {0.5, 0.5, 0.5, 1},
  },

  -- Panel colors
  panel = {
    background = {30/255, 30/255, 40/255, 0.9},
    border = {80/255, 80/255, 100/255, 1},
    header = {50/255, 50/255, 70/255, 1},
  },

  -- Text colors
  text = {
    primary = {1, 1, 1, 1},
    secondary = {0.7, 0.7, 0.7, 1},
    highlight = {1, 1, 0, 1},
    error = {1, 0.3, 0.3, 1},
    success = {0.3, 1, 0.3, 1},
  },

  -- State colors
  state = {
    success = {0.2, 0.8, 0.2, 1},
    warning = {0.9, 0.7, 0.2, 1},
    error = {0.9, 0.2, 0.2, 1},
    info = {0.2, 0.6, 0.9, 1},
  },

  -- Game-specific colors
  health = {
    high = {0.2, 0.9, 0.2, 1},
    medium = {0.9, 0.9, 0.2, 1},
    low = {0.9, 0.2, 0.2, 1},
  },

  -- Background
  background = {
    dark = {0.1, 0.1, 0.15, 1},
    medium = {0.2, 0.2, 0.25, 1},
    light = {0.3, 0.3, 0.35, 1},
  },

  -- Debug colors
  debug = {
    hitbox = {1, 0, 0, 0.5},
    collision = {0, 1, 0, 0.5},
    origin = {1, 1, 0, 1},
  },
}

-- Button dimensions and styling
Theme.button = {
  width = 200,
  height = 64,
  minWidth = 100,
  maxWidth = 400,
  padding = 16,
  margin = 16,
  cornerRadius = 8,
  borderWidth = 2,
}

-- Panel dimensions
Theme.panel = {
  padding = 16,
  margin = 8,
  cornerRadius = 4,
  borderWidth = 1,
}

-- Spacing system (use multiples for consistency)
Theme.spacing = {
  xs = 4,
  sm = 8,
  md = 16,
  lg = 24,
  xl = 32,
  xxl = 48,
}

-- Font configuration
Theme.fonts = {
  sizes = {
    xs = 10,
    sm = 12,
    md = 16,
    lg = 24,
    xl = 32,
    xxl = 48,
    title = 64,
  },
  -- Font objects will be loaded when needed
  _cache = {},
}

--- Get or create a font at the specified size
-- @param size number Font size in pixels
-- @return Font The LÖVE font object
function Theme.fonts.get(size)
  if not Theme.fonts._cache[size] then
    Theme.fonts._cache[size] = love.graphics.newFont(size)
  end
  return Theme.fonts._cache[size]
end

--- Get a font by named size
-- @param name string One of: xs, sm, md, lg, xl, xxl, title
-- @return Font The LÖVE font object
function Theme.fonts.getByName(name)
  local size = Theme.fonts.sizes[name] or Theme.fonts.sizes.md
  return Theme.fonts.get(size)
end

-- Slider styling
Theme.slider = {
  height = 24,
  trackHeight = 8,
  handleWidth = 16,
  handleHeight = 24,
  labelSpacing = 4,
  colors = {
    track = {60/255, 60/255, 80/255, 1},
    trackFilled = {100/255, 140/255, 180/255, 1},
    handle = {150/255, 150/255, 170/255, 1},
    handleHover = {180/255, 180/255, 200/255, 1},
    handleActive = {120/255, 120/255, 140/255, 1},
    label = {1, 1, 1, 1},
    value = {0.8, 0.8, 0.9, 1},
  },
}

-- Character creation layout
Theme.characterCreation = {
  headerHeight = 80,
  panelRatios = {0.25, 0.50, 0.25},  -- left, center, right
  panelGap = 8,
}

-- Body skin tones
Theme.body = {
  flesh = {1, 209/255, 127/255, 1},
  fleshDark = {235/255, 189/255, 97/255, 1},
  tattooDark = {0, 5/255, 55/255, 1},
  nipple = {245/255, 159/255, 97/255, 1},
}

-- Equipment slot styling
Theme.equipmentSlot = {
  size = 64,
  spacing = 16,
  borderWidth = 2,
  colors = {
    background = {40/255, 40/255, 50/255, 1},
    border = {80/255, 80/255, 100/255, 1},
    borderHover = {120/255, 120/255, 150/255, 1},
    empty = {60/255, 60/255, 70/255, 1},
    label = {0.7, 0.7, 0.7, 1},
  },
}

-- Animation timing
Theme.animation = {
  fast = 0.1,
  normal = 0.2,
  slow = 0.4,
  hover = 0.15,
}

-- Input constants
Theme.input = {
  clickThreshold = 0.2,   -- Max time for click vs hold
  repeatDelay = 0.5,      -- Initial delay before key repeat
  repeatRate = 0.05,      -- Rate of key repeat
  debounceTime = 0.1,     -- Debounce for rapid inputs
}

--- Helper to create a color with modified alpha
-- @param color table The base color {r, g, b, a}
-- @param alpha number New alpha value (0.0 - 1.0)
-- @return table New color table
function Theme.withAlpha(color, alpha)
  return {color[1], color[2], color[3], alpha}
end

--- Helper to lighten a color
-- @param color table The base color {r, g, b, a}
-- @param amount number Amount to lighten (0.0 - 1.0)
-- @return table New color table
function Theme.lighten(color, amount)
  return {
    math.min(1, color[1] + amount),
    math.min(1, color[2] + amount),
    math.min(1, color[3] + amount),
    color[4] or 1
  }
end

--- Helper to darken a color
-- @param color table The base color {r, g, b, a}
-- @param amount number Amount to darken (0.0 - 1.0)
-- @return table New color table
function Theme.darken(color, amount)
  return {
    math.max(0, color[1] - amount),
    math.max(0, color[2] - amount),
    math.max(0, color[3] - amount),
    color[4] or 1
  }
end

return Theme
