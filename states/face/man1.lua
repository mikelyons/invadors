--[[
  man1.lua

  all the drawing for making a man
]]

local drawman = {}

function drawman:drawMan()
  -- Draw the head (ellipse)
  love.graphics.setColor(255, 210, 179)
  love.graphics.ellipse("fill", 128, 128, 100, 120)

  -- Draw the eyes (whites)
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", 100, 110, 12)
  love.graphics.circle("fill", 156, 110, 12)

  -- Draw the irises (blue)
  love.graphics.setColor(0, 0, 255)
  love.graphics.circle("fill", 100, 110, 6)
  love.graphics.circle("fill", 156, 110, 6)

  -- Draw the nose (triangle)
  love.graphics.setColor(255, 210, 179)
  love.graphics.polygon("fill", 128, 128, 120, 140, 136, 140)

  -- Draw shading for the jawline (darker curve)
  love.graphics.setColor(230, 230, 230)
  love.graphics.arc("fill", 128, 150, 40, math.pi / 5, 4 * math.pi / 5)

  -- Draw the mouth (red)
  love.graphics.setColor(255, 0, 0)
  love.graphics.arc("fill", 128, 162, 33, math.pi / 6, 5 * math.pi / 6)

  -- Draw broad shoulders (rectangles)
  love.graphics.setColor(255, 210, 179)
  love.graphics.rectangle("fill", 85, 170, 82, 20)
  love.graphics.rectangle("fill", 83, 180, 86, 10)
end

function drawman:drawskull()
      -- Background
    love.graphics.setBackgroundColor(255, 255, 255)

    -- Draw the skull base (ellipse)
    love.graphics.setColor(255, 255, 255)
    love.graphics.ellipse("fill", 150, 150, 120, 160)

    -- Draw the eye sockets (circles)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", 110, 130, 20)
    love.graphics.circle("fill", 190, 130, 20)

    -- Draw the nose cavity (ellipse)
    love.graphics.setColor(0, 0, 0)
    love.graphics.ellipse("fill", 150, 170, 20, 10)

    -- Draw the teeth (rectangles)
    love.graphics.setColor(255, 255, 255)
    for i = 1, 8 do
        local x = 150 - 15 + i * 4
        love.graphics.rectangle("fill", x, 180, 2, 15)
    end

    -- Add shading and contours to give more depth (ellipses)
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.ellipse("line", 150, 150, 120, 160)
    love.graphics.ellipse("line", 150, 130, 80, 100)
    love.graphics.ellipse("line", 150, 150, 80, 120)
    love.graphics.ellipse("line", 150, 170, 20, 10)
end

function drawman:secondskull()
    -- Background
    love.graphics.setBackgroundColor(255, 255, 255)

    -- Draw the skull base (ellipse)
    love.graphics.setColor(255, 255, 255)
    love.graphics.ellipse("fill", 150, 150, 120, 160)

    -- Draw the eye sockets (circles)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", 110, 130, 20)
    love.graphics.circle("fill", 190, 130, 20)

    -- Draw the nose cavity (ellipse)
    love.graphics.setColor(0, 0, 0)
    love.graphics.ellipse("fill", 150, 170, 20, 10)

    -- Draw the teeth (rectangles)
    love.graphics.setColor(255, 255, 255)
    for i = 1, 8 do
        local x = 150 - 15 + i * 4
        love.graphics.rectangle("fill", x, 180, 2, 15)
    end

    -- Add shading and contours to give more depth (ellipses)
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.ellipse("line", 150, 150, 120, 160)
    love.graphics.ellipse("line", 150, 130, 80, 100)
    love.graphics.ellipse("line", 150, 150, 80, 120)
    love.graphics.ellipse("line", 150, 170, 20, 10)

    -- Add some details to the eye sockets (shading)
    love.graphics.setColor(100, 100, 100)
    love.graphics.arc("fill", 110, 130, 20, math.pi / 4, 3 * math.pi / 4)
    love.graphics.arc("fill", 190, 130, 20, math.pi / 4, 3 * math.pi / 4)

    -- Add some texture to the skull base (circles)
    for i = 1, 20 do
        local x = love.math.random(110, 190)
        local y = love.math.random(150, 310)
        love.graphics.circle("fill", x, y, 2)
    end
end

function drawman:skully()
    -- love.graphics.setBackgroundColor
    
    -- Draw the skull base (ellipse)
    love.graphics.setColor(255, 255, 255)
    love.graphics.ellipse("line", 150, 150, 120, 160)

    -- Draw the eye sockets (ellipses)
    love.graphics.ellipse("line", 110, 140, 30, 20)
    love.graphics.ellipse("line", 190, 140, 30, 20)

    -- Draw the nose (lines)
    love.graphics.line(150, 140, 150, 170)
    love.graphics.line(150, 140, 140, 160)
    love.graphics.line(150, 140, 160, 160)

    -- Draw the mouth (lines)
    love.graphics.arc("line", 150, 170, 40, math.pi / 6, 5 * math.pi / 6)

    -- Add more detail to the skull base (ellipses)
    love.graphics.ellipse("line", 150, 120, 60, 80)
    love.graphics.ellipse("line", 150, 150, 80, 100)
    love.graphics.ellipse("line", 150, 180, 30, 40)
    love.graphics.ellipse("line", 150, 195, 20, 10)

    -- Add contour lines to the eyes
    love.graphics.arc("line", 110, 140, 30, math.pi / 5, 4 * math.pi / 5)
    love.graphics.arc("line", 190, 140, 30, math.pi / 5, 4 * math.pi / 5)
    
    -- Add contour lines to the nose
    love.graphics.line(150, 140, 145, 150)
    love.graphics.line(150, 140, 155, 150)
    
    -- Add more detail to the mouth (lines)
    love.graphics.arc("line", 150, 170, 38, math.pi / 6, 5 * math.pi / 6)
    love.graphics.arc("line", 150, 170, 35, math.pi / 5, 4 * math.pi / 5)

    -- Continue to add more lines, contours, and details to your liking
end

function drawman:pencil()
    -- Draw the pencil tray background (rectangle)
    love.graphics.setColor(139, 69, 19) -- Brown color for wood
    love.graphics.rectangle("fill", 50, 100, 200, 50)

    -- Draw wood grain texture (lines)
    -- love.graphics.setColor(160, 82, 45) -- Slightly lighter brown
    love.graphics.setColor(0, 2, 5) -- Slightly lighter brown
    for i = 1, 10 do
        local x1 = love.math.random(50, 250)
        local y1 = love.math.random(100, 150)
        local x2 = x1 + love.math.random(2, 10)
        local y2 = y1 + love.math.random(2, 10)

        love.graphics.line(x1, y1, x2, y2)
    end
end

return drawman
