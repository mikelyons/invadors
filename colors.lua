--[[
  colors.lua
  Constants that can be used for color

  Updated for LÖVE 11+ (0.0 - 1.0 color range)
]]


-- love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)

-- love.graphics.setColor(1,0,0,1) -- RED
-- love.graphics.setColor(0,1,0,1) -- GREEN
-- love.graphics.setColor(1,1,1,1) -- WHITE reset


-- color constants
-- R, G, B, Alpha (0.0 - 1.0 range for LÖVE 11+)
COLOR_GREEN_HUNTER =   {0, 148/255, 0, 1}

COLOR_TEAL         =   {150/255, 1, 1, 1}

-- Greyscale
COLOR_WHITE        =   {1, 1, 1, 1}
COLOR_GREY         =   {150/255, 150/255, 150/255, 1}
COLOR_DARK_GREY    =   {100/255, 100/255, 100/255, 1}
COLOR_VERY_DARK_GREY = {55/255, 55/255, 55/255, 55/255}
COLOR_BLACK        =   {0, 0, 0, 1}

-- Primary colors
COLOR_RED          =   {1, 0, 0, 1}
COLOR_GREEN        =   {0, 1, 0, 1}
COLOR_BLUE         =   {0, 0, 1, 1}

-- UI colors
COLOR_UI_BUTTON    =   {80/255, 80/255, 100/255, 1}
COLOR_UI_BUTTON_HOVER = {100/255, 100/255, 120/255, 1}
COLOR_UI_BUTTON_TEXT = {1, 1, 1, 1}