local draw_wires = {}

-- wireart.lua line 80
function bench ()
  -- draw crafting bench - trapezoid - fill with color
  love.graphics.setColor(25, 130, 25, 255)
  love.graphics.polygon('fill', {200,50, 400,50, 500,300, 100,300, 200,50})   -- last pair is a repeat to complete the trapezoid

  love.graphics.setLineWidth( 10 )
  love.graphics.setColor(200, 155, 95, 255)
  love.graphics.line(200,50, 400,50, 500,300, 100,300, 200,50)   -- last pair is a repeat to complete the trapezoid
end

return draw_wires
