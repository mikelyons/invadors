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
