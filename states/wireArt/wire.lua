--[[
  wire.lua

  the class to maintain a wire and all it's behaviiors and drawing
]]

local Wire = {}

-- wire colors @TODO move this
local colors = {
  {152, 80, 6}, -- dark copper
  {212, 116, 26}, -- light copper
  {100, 100, 100}, -- Titanium
  {200, 200, 200}, -- silver
}

function Wire:new(length, spacing)
  assert(type(length) == "number", "length must be a number")
  print('new wire created')

  local spacing = spacing or 20

  local wire = {}
  local margin_x = 20 + spacing
  local margin_y = 20
  local wrap_distance = 20
  local wrap_count = 1
  local wrap_width = 20
  local ww = wrap_width

  wire.length = length

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
