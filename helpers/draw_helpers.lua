--
--
-- Helpers for Drawing certain shapes
--
-- 1. Parabolic curve
-- 2. @TODO - Pacman
-- 3. screen coordinate helper variables

-- draws a parabolic curve
-- for y = 0, 16 do
--   love.graphics.line(
--     camera.pos.x, camera.pos.y + (y*32),
--     camera.pos.y + (y*32),
--     camera.pos.y + self.height
--   )
-- end



draw_helpers = {}
local dh = draw_helpers

dh.camera = camera

-- dh.camCenter = camera.x + camera.w

--[[
  Draw Pacman
]]

local function drawPacman()
  -- drawBox(player, 0, 255, 0)
  pacwidth = math.pi / 6 -- size of his mouth
  -- love.graphics.setColor( 255, 255, 0 ) -- pacman needs to be yellow
  -- love.graphics.arc( "fill", 400, 100, 100, pacwidth, (math.pi * 2) - pacwidth )

  -- draw trees
  local vertices = {0, 0, -100, -100, -100, 0}
  love.graphics.setColor( 0, 155, 55, 1000 ) -- pacman needs to be yellow
  love.graphics.polygon('fill', vertices)

  -- draw clouds
  love.graphics.setColor( 255, 255, 255, 30 ) -- pacman needs to be yellow

  -- https://love2d.org/wiki/love.graphics.arc
  -- love.graphics.arc( drawmode, x, y, radius, angle1, angle2, segments )
  love.graphics.arc( "fill", 400, 200, 200, pacwidth, (math.pi * 2) - pacwidth )

  -- draw lightening
  sometable = {
    100, 100,
    200, 200,
    300, 100,
    400, 200,
  }
  love.graphics.line(sometable)

  -- @TODO - implement the generation 
  anotherTable = generateLighteningVertecies()

  -- shoot lightening
  love.graphics.setColor( 255, 255, 255, 80 )

  -- love.graphics.setLine(2, "smooth") -- removed
  local width = 2
  -- local style = 'smooth'
  local style = 'rough'
  love.graphics.setLineStyle( style )
  love.graphics.setLineWidth( width )

  -- why is this not aligned with the camera?
  w = love.graphics.getWidth() --/ 2   -- half the window width
  h = love.graphics.getHeight() --/ 2   -- half the window height
  local mx, my = love.mouse.getPosition()  -- current position of the mouse
  love.graphics.line(w, h, mx, my)

end
