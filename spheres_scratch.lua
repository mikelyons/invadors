-- spheres_scratch.lua

--https://love2d.org/forums/viewtopic.php?f=3&t=2198&start=580

local rad = 100
local detail = 40
local data = { points = {}, triangles = {} }
local rot_inc = 360 / detail / 2
local y_inc = rad / detail

-- Create the points
local n = 1
for y = math.pi, 0, -(math.pi/detail) do
  local c = {math.random(0,200),math.random(0,200),math.random(0,200)}
  local j = 1
  for i = 0, 360-rot_inc, rot_inc do
    local r = (rad * math.sin(y))
    local x = 0 + math.cos(math.rad(i)) * r
    local z = 0 + math.sin(math.rad(i)) * r
    data.points[n] = { x = x, y = (rad * math.cos(y)), z = z }
    n = n + 1
    j = j + 1
  end
end

-- Create a colored grid to apply to the sphere
local grid = {}
for x = 1, detail * 2 do
  grid[x] = {}
  for y = 1, detail do
    grid[x][y] = {math.random(0,1)*255,math.random(0,1)*255,math.random(0,1)*255}
  end
end

-- Create the polygons
n = 1
for y = 0, detail-1 do
  for x = 0, detail * 2 - 1 do
    local c = grid[x+1][y+1]
    local p = y * (detail*2)
    local xx = x
    if x == detail * 2 - 1 then xx = x - (detail * 2) end
    local p1, p2, p3, p4 = p + 1 + x, p + 2 + xx, p + (detail*2) + 2 + xx, p + (detail*2) + 1 + x

    if y > 0 and y < detail-1 then
      data.triangles[n] = { p = {p1,p2,p3,p4}, c = c }
      n = n + 1
    else
      data.triangles[n] = { p = {p1,p2,p3}, c = c }
      data.triangles[n+1] = { p = {p3,p4,p1}, c = c }
      n = n + 2
    end
  end
end

return data