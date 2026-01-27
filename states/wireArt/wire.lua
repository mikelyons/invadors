--[[
  wire.lua

  the class to maintain a wire and all it's behaviiors and drawing
  @TODO - create a wire class that can be drawn and mouse dragged
    - add a wire.pos.x and wire.pos.y
    - add a wire.size.w and wire.size.h
    - add a wire.color
    - add a wire.material
    - add a wire.gauge
    - add a wire.length
    - add a wire.spacing
]]

local Wire = {}

-- wire colors @TODO move this
local colors = {
  {152/255, 80/255, 6/255, 1}, -- dark copper
  {212/255, 116/255, 26/255, 1}, -- light copper
  {100/255, 100/255, 100/255, 1}, -- Titanium
  {200/255, 200/255, 200/255, 1}, -- silver
}

function Wire:new(length, spacing, material, gauge)
  assert(type(length) == "number", "length must be a number")
  print('new wire created: '..length..' '..spacing..' '..material..' '..gauge)
  local wire = {}

  wire.pos = {x=0, y=0}
  wire.size = {w=0, h=0}

  local spacing = spacing or 20 -- what's this?

  local margin_x = 20 + spacing
  local margin_y = 20
  local wrap_distance = 20
  local wrap_count = 1
  local wrap_width = 20
  local ww = wrap_width

  wire.length = length
  wire.gauge = gauge or 10 -- does nothing yet, line-thickness
  wire.material = material or 'copper' -- determines color

  local x2 = margin_x + margin_x * wrap_count
  local y2 = margin_y + margin_y * wrap_count

  local line = {
    margin_x,margin_y,
    x2,y2,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- x2+ww*#line,y2+ww*#line,
    -- 200,50,
  }

  -- line[#line+1] = x2+ww*#line
  line[#line+1] = margin_x
  line[#line+1] = y2+ww*#line

  function wire:draw()
    -- print('wire of length '..wire.length)
    love.graphics.line(line)

  end

  -- function wire:mousepressed(x,y, button , istouch) end
  -- function wire:mousereleased(x, y, button) end
  function wire:keypressed() end

  return wire
end

return Wire
