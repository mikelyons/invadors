--[[
  BodyRenderer.lua

  Parameterized body renderer for character creation preview.
  Based on the geometric/blocky style from drawMan.lua.

  Usage:
    local BodyRenderer = require('states/characterCreation/BodyRenderer')
    local CharacterStats = require('states/characterCreation/CharacterStats')

    local renderer = BodyRenderer:new()
    renderer:updateParams(stats)
    renderer:draw(centerX, centerY)
]]

local Theme = require('src/ui/theme')
local CharacterStats = require('states/characterCreation/CharacterStats')

local BodyRenderer = {}
BodyRenderer.__index = BodyRenderer

--- Create a new BodyRenderer instance
-- @return BodyRenderer The new renderer instance
function BodyRenderer:new()
  local instance = {
    -- Body parameters (will be updated from stats)
    params = CharacterStats:getBodyParams(CharacterStats:new()),

    -- Scar images (loaded on first use)
    scarA = nil,
    scarB = nil,
    scarsLoaded = false,
  }

  setmetatable(instance, self)
  return instance
end

--- Load scar images if not already loaded
function BodyRenderer:loadScars()
  if self.scarsLoaded then return end

  local success1, scar1 = pcall(love.graphics.newImage, "assets/scars/scar_1.png")
  if success1 then
    self.scarA = scar1
  end

  local success2, scar2 = pcall(love.graphics.newImage, "assets/scars/scar_2.png")
  if success2 then
    self.scarB = scar2
  end

  self.scarsLoaded = true
end

--- Update body parameters from stats
-- @param stats table Character stats object
function BodyRenderer:updateParams(stats)
  self.params = CharacterStats:getBodyParams(stats)
end

--- Draw the character body centered at given position
-- @param centerX number Center X position
-- @param centerY number Center Y position (top of chest area)
function BodyRenderer:draw(centerX, centerY)
  self:loadScars()

  local p = self.params
  local lg = love.graphics

  -- Calculate positions relative to center
  local chestX = centerX - (p.boxWidth / 2)
  local chestY = centerY

  -- Draw body parts in order (back to front)
  self:drawHead(lg, centerX, chestY - 100 * p.scale)
  self:drawChest(lg, chestX, chestY, p.boxWidth, p.boxHeight)
  self:drawAbdomen(lg, chestX, chestY, p.boxWidth, p.boxHeight)
  self:drawShading(lg, chestX, chestY, p.boxWidth, p.boxHeight)
  self:drawTattoo(lg, chestX, chestY)
  self:drawScars(lg, chestX, chestY)
  self:drawNipples(lg, chestX, chestY, p.boxWidth)
end

--- Draw in panel bounds (convenience method)
-- @param panel table Panel object with getContentArea method
function BodyRenderer:drawInPanel(panel)
  local cx, cy, cw, ch = panel:getContentArea()
  -- Center in panel
  local centerX = cx + cw / 2
  local centerY = cy + ch / 3  -- Position body in upper portion
  self:draw(centerX, centerY)
end

--- Draw the head
function BodyRenderer:drawHead(lg, centerX, headY)
  local p = self.params

  -- Head circle
  lg.setColor(Theme.body.flesh)
  lg.circle("fill", centerX, headY, p.headRadius)

  -- Eye (sad droopy eye)
  lg.setColor(0, 0, 0, 1)
  lg.circle("fill",
    centerX + p.eyeOffsetX,
    headY + p.eyeOffsetY,
    p.eyeRadius
  )

  -- Eye highlight (flesh overlay to create "sad" look)
  lg.setColor(Theme.body.flesh)
  lg.circle("fill",
    centerX + p.eyeOffsetX,
    headY + p.eyeOffsetY + 5 * p.scale,
    p.eyeRadius
  )
end

--- Draw the chest
function BodyRenderer:drawChest(lg, chestX, chestY, boxWidth, boxHeight)
  lg.setColor(Theme.body.flesh)
  lg.rectangle("fill", chestX, chestY, boxWidth, boxHeight)
end

--- Draw the abdomen (3 tapered sections)
function BodyRenderer:drawAbdomen(lg, chestX, chestY, boxWidth, boxHeight)
  local p = self.params

  lg.setColor(Theme.body.flesh)

  -- First section (0.8x taper from chest)
  local width1 = boxWidth * p.taper1
  local offset1 = (boxWidth - width1) / 2
  lg.rectangle("fill",
    chestX + offset1,
    chestY + boxHeight / 2,
    width1,
    boxHeight
  )

  -- Second section (0.5x taper)
  local width2 = boxWidth * p.taper2
  local offset2 = (boxWidth - width2) / 2
  lg.rectangle("fill",
    chestX + offset2,
    chestY + boxHeight,
    width2,
    boxHeight
  )

  -- Third section (0.33x taper - hips)
  local width3 = boxWidth * p.taper3
  local offset3 = (boxWidth - width3) / 2
  lg.rectangle("fill",
    chestX + offset3,
    chestY + boxHeight * 2,
    width3,
    boxHeight
  )
end

--- Draw muscle shading
function BodyRenderer:drawShading(lg, chestX, chestY, boxWidth, boxHeight)
  local p = self.params

  -- Shading color with alpha based on strength
  local r, g, b = Theme.body.fleshDark[1], Theme.body.fleshDark[2], Theme.body.fleshDark[3]
  lg.setColor(r, g, b, p.shadingAlpha)

  -- Pec shadows (lines)
  lg.rectangle("line", chestX, chestY + 10 * p.scale, boxWidth - 6 * p.scale, 10 * p.scale)
  lg.rectangle("line", chestX, chestY, boxWidth - 4 * p.scale, 20 * p.scale)
  lg.rectangle("line", chestX, chestY + 40 * p.scale, boxWidth - 2 * p.scale, 40 * p.scale)

  -- Armpit shadow
  lg.rectangle("fill", chestX + 3 * p.scale, chestY + 3 * p.scale, 32 * p.scale, 32 * p.scale)

  -- Ab shadows (lines)
  lg.rectangle("line", chestX, chestY + 10 * p.scale, boxWidth / 6, 10 * p.scale)
  lg.rectangle("line", chestX, chestY, boxWidth / 4, 20 * p.scale)
  lg.rectangle("line", chestX + 40 * p.scale, chestY + 40 * p.scale, boxWidth / 2, 40 * p.scale)

  -- Second armpit shadow
  lg.rectangle("fill", chestX + 3 * p.scale, chestX * 2 - 300 * p.scale, 32 * p.scale, 32 * p.scale)
end

--- Draw tattoo bars and text
function BodyRenderer:drawTattoo(lg, chestX, chestY)
  local p = self.params

  lg.setColor(Theme.body.tattooDark)

  -- Horizontal bars
  lg.rectangle("fill", chestX + 80 * p.scale, chestY + 30 * p.scale, p.tattooBarWidth, p.tattooBarHeight)
  lg.rectangle("fill", chestX + 80 * p.scale, chestY + 40 * p.scale, p.tattooBarWidth, p.tattooBarHeight)
  lg.rectangle("fill", chestX + 80 * p.scale, chestY + 50 * p.scale, p.tattooBarWidth, p.tattooBarHeight)

  -- Vertical bars
  lg.rectangle("fill", chestX + 180 * p.scale, chestY + 30 * p.scale, p.tattooBarHeight, p.tattooBarWidth)
  lg.rectangle("fill", chestX + 190 * p.scale, chestY + 40 * p.scale, p.tattooBarHeight, p.tattooBarWidth)
  lg.rectangle("fill", chestX + 200 * p.scale, chestY + 50 * p.scale, p.tattooBarHeight, p.tattooBarWidth)

  -- "raint" text (horizontal)
  lg.print("raint", chestX + 120 * p.scale, chestY + 50 * p.scale)

  -- "raint" text (vertical)
  lg.print("r\na\ni\nn\nt", chestX + 160 * p.scale, chestY + 50 * p.scale)
end

--- Draw scars
function BodyRenderer:drawScars(lg, chestX, chestY)
  local p = self.params

  if self.scarA then
    local s1w = self.scarA:getWidth()
    local s1h = self.scarA:getHeight()
    local s1a = 1  -- rotation angle

    lg.setColor(1, 1, 1, 1)  -- Reset color for images
    lg.draw(self.scarA,
      chestX + 210 * p.scale,
      chestY + 90 * p.scale,
      s1a,
      0.5 * p.scale, 0.5 * p.scale,
      s1w / 2, s1h / 2
    )
  end

  if self.scarB then
    local s1w = self.scarB:getWidth()
    local s1h = self.scarB:getHeight()
    local s1a = 0.5  -- different rotation

    lg.setColor(1, 1, 1, 1)
    lg.draw(self.scarB,
      chestX + 170 * p.scale,
      chestY + 90 * p.scale,
      s1a,
      0.9 * p.scale, 0.9 * p.scale,
      s1w / 2, s1h / 2
    )
  end
end

--- Draw nipples with pasties
function BodyRenderer:drawNipples(lg, chestX, chestY, boxWidth)
  local p = self.params

  -- Nipple color (tan)
  lg.setColor(Theme.body.nipple)

  -- Left nipple
  lg.rectangle("fill",
    chestX + 40 * p.scale,
    chestY + 40 * p.scale,
    p.nippleSize,
    p.nippleSize
  )

  -- Right nipple
  lg.rectangle("fill",
    chestX + boxWidth - 40 * p.scale - p.nippleSize,
    chestY + 40 * p.scale,
    p.nippleSize,
    p.nippleSize
  )

  -- Pasties (X marks)
  lg.setColor(Theme.body.tattooDark)

  -- Left pastie
  lg.print("X",
    chestX + 40 * p.scale + 8 * p.scale,
    chestY + 40 * p.scale + 8 * p.scale,
    0,
    2 * p.scale, 2 * p.scale
  )

  -- Right pastie
  lg.print("x",
    chestX + boxWidth - 40 * p.scale - p.nippleSize + 8 * p.scale,
    chestY + 40 * p.scale + 8 * p.scale,
    0,
    2 * p.scale, 2 * p.scale
  )
end

return BodyRenderer
