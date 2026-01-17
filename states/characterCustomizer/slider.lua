-- slider.lua: A custom Gspot slider element
local Gspot = require 'lib/gspot/Gspot' -- Assuming Gspot is in the same directory or properly pathed

-- Slider constructor function
local function newSlider(gui, label, pos, min, max, value)
    -- Create a new Gspot element
    local slider = gui:element('slider', nil, pos) -- 'slider' is our custom type, parent is nil
    
    -- Default properties
    slider.label = label or 'Slider'
    slider.pos = {x = pos[1], y = pos[2], w = pos[3] or 100, h = pos[4] or 20} -- x, y, width, height
    slider.min = min or 0
    slider.max = max or 100
    slider.value = math.max(slider.min, math.min(slider.max, value or slider.min)) -- Clamp initial value
    
    -- Handle properties (the draggable knob)
    slider.handle = {
        w = 10, -- Fixed handle width
        h = slider.pos.h, -- Handle height matches slider height
    }
    slider.handle.x = slider.pos.x + ((slider.value - slider.min) / (slider.max - slider.min)) * (slider.pos.w - slider.handle.w)
    slider.handle.y = slider.pos.y
    
    -- Dragging state
    slider.dragging = false
    
    -- Update function (called by Gspot in gui:update(dt))
    slider.update = function(self, dt)
        if self.dragging and love.mouse.isDown(1) then
            local mx = love.mouse.getX()
            -- Clamp handle position to slider bounds
            local newX = math.max(self.pos.x, math.min(self.pos.x + self.pos.w - self.handle.w, mx))
            self.handle.x = newX
            -- Calculate new value based on handle position
            local range = self.max - self.min
            local posRange = self.pos.w - self.handle.w
            self.value = self.min + (range * (newX - self.pos.x) / posRange)
        elseif not love.mouse.isDown(1) then
            self.dragging = false
        end
    end
    
    -- Draw function (called by Gspot in gui:draw())
    slider.draw = function(self)
        -- Draw track (background)

        love.graphics.setColor(55/255, 55/255, 55/255, 1)
        love.graphics.rectangle('fill', self.pos.x, self.pos.y, self.pos.w, self.pos.h)

        -- Draw handle
        love.graphics.setColor(155/255, 155/255, 155/255, 1)
        love.graphics.rectangle('fill', self.handle.x, self.handle.y, self.handle.w, self.handle.h)

        -- Draw label and value
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(self.label .. ': ' .. math.floor(self.value), self.pos.x, self.pos.y - 15)
    end
    
    -- Mouse press handler
    slider.mousepress = function(self, x, y, button)
        if button == 1 then -- Left mouse button
            -- Check if click is within handle bounds
            if x >= self.handle.x and x <= self.handle.x + self.handle.w and
               y >= self.handle.y and y <= self.handle.y + self.handle.h then
                self.dragging = true
            end
        end
    end
    
    -- Mouse release handler
    slider.mouserelease = function(self, x, y, button)
        if button == 1 then
            self.dragging = false
        end
    end

    return slider
end

-- Register the slider with Gspot
Gspot.slider = newSlider

return newSlider