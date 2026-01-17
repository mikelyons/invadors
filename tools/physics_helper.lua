local floor = math.floor
function rectangle_collision(rect_1, rect_2)
  local r1, r2 = rect_1, rect_2
  -- print('r1 x: '..floor(r1.pos.x)..' y: '..floor(r1.pos.y))
  -- print('r2 x: '..floor(r2.pos.x)..' y: '..floor(r2.pos.y))
  -- print('r1 x: '..floor(r1.pos.x)..' y: '..floor(r1.pos.y)..' r2 x: '..floor(r2.pos.x)..' y: '..floor(r2.pos.y))

  if
    -- right edge r1 crossed over left edge r2
    rect_1.pos.x + rect_1.size.x  >  rect_2.pos.x and
    -- left edge r1 crossed over right edge r2
                    rect_1.pos.x  <  rect_2.pos.x+rect_2.size.x and
    -- bottom edge 
    rect_1.pos.y + rect_1.size.y  >  rect_2.pos.y and
    -- top edge
                    rect_1.pos.y  <  rect_2.pos.y+rect_2.size.y
  then
      return true, rect_2
  end
  return false, nil
end