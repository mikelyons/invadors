--[[
  debug_menu.lua

  A toggleable debug menu for development purposes.
  Supports keyboard and mouse navigation.

  Usage:
    local DebugMenu = require('src/ui/debug_menu')
    local menu = DebugMenu:new({title = "Debug Menu"})
    menu:addItem("Option 1", function() print("Selected 1") end)
    menu:toggle()  -- Show/hide
    menu:update(dt)
    menu:draw()
    menu:keypressed(key)
]]

local DebugMenu = {}
DebugMenu.__index = DebugMenu

function DebugMenu:new(config)
    local self = setmetatable({}, DebugMenu)

    self.title = config.title or "Debug Menu"
    self.visible = false
    self.items = {}
    self.selectedIndex = 1

    -- Styling
    self.x = config.x or 20
    self.y = config.y or 20
    self.width = config.width or 300
    self.itemHeight = config.itemHeight or 28
    self.padding = config.padding or 10
    self.font = love.graphics.newFont(14)

    -- Colors
    self.colors = {
        background = {0.1, 0.1, 0.15, 0.95},
        border = {0.4, 0.4, 0.5, 1},
        title = {1, 1, 0.3, 1},
        item = {0.8, 0.8, 0.8, 1},
        selected = {0.2, 0.2, 0.3, 1},
        selectedText = {0.3, 1, 0.3, 1},
        hint = {0.5, 0.5, 0.5, 1},
    }

    return self
end

function DebugMenu:addItem(label, callback, data)
    table.insert(self.items, {
        label = label,
        callback = callback,
        data = data,
    })
end

function DebugMenu:addSeparator(label)
    table.insert(self.items, {
        label = label or "---",
        separator = true,
    })
end

function DebugMenu:clear()
    self.items = {}
    self.selectedIndex = 1
end

function DebugMenu:toggle()
    self.visible = not self.visible
end

function DebugMenu:show()
    self.visible = true
end

function DebugMenu:hide()
    self.visible = false
end

function DebugMenu:isVisible()
    return self.visible
end

function DebugMenu:selectNext()
    repeat
        self.selectedIndex = self.selectedIndex + 1
        if self.selectedIndex > #self.items then
            self.selectedIndex = 1
        end
    until not self.items[self.selectedIndex].separator or #self.items == 0
end

function DebugMenu:selectPrevious()
    repeat
        self.selectedIndex = self.selectedIndex - 1
        if self.selectedIndex < 1 then
            self.selectedIndex = #self.items
        end
    until not self.items[self.selectedIndex].separator or #self.items == 0
end

function DebugMenu:confirm()
    local item = self.items[self.selectedIndex]
    if item and item.callback then
        item.callback(item.data)
    end
end

function DebugMenu:update(dt)
    if not self.visible then return end

    -- Mouse hover detection
    local mx, my = love.mouse.getPosition()
    local itemY = self.y + self.padding + self.itemHeight + 10 -- After title

    for i, item in ipairs(self.items) do
        if not item.separator then
            local itemTop = itemY
            local itemBottom = itemY + self.itemHeight

            if mx >= self.x and mx <= self.x + self.width and
               my >= itemTop and my <= itemBottom then
                self.selectedIndex = i
            end
        end
        itemY = itemY + self.itemHeight
    end
end

function DebugMenu:draw()
    if not self.visible then return end

    local prevFont = love.graphics.getFont()
    love.graphics.setFont(self.font)

    local totalHeight = self.padding * 2 + self.itemHeight + 10 + (#self.items * self.itemHeight) + 30

    -- Background
    love.graphics.setColor(self.colors.background)
    love.graphics.rectangle("fill", self.x, self.y, self.width, totalHeight, 5, 5)

    -- Border
    love.graphics.setColor(self.colors.border)
    love.graphics.rectangle("line", self.x, self.y, self.width, totalHeight, 5, 5)

    -- Title
    love.graphics.setColor(self.colors.title)
    love.graphics.print(self.title, self.x + self.padding, self.y + self.padding)

    -- Items
    local itemY = self.y + self.padding + self.itemHeight + 10

    for i, item in ipairs(self.items) do
        if item.separator then
            -- Draw separator line
            love.graphics.setColor(self.colors.border)
            love.graphics.line(
                self.x + self.padding,
                itemY + self.itemHeight / 2,
                self.x + self.width - self.padding,
                itemY + self.itemHeight / 2
            )
            if item.label ~= "---" then
                love.graphics.setColor(self.colors.hint)
                love.graphics.print(item.label, self.x + self.padding, itemY + 2)
            end
        else
            -- Selected highlight
            if i == self.selectedIndex then
                love.graphics.setColor(self.colors.selected)
                love.graphics.rectangle("fill",
                    self.x + self.padding / 2,
                    itemY,
                    self.width - self.padding,
                    self.itemHeight,
                    3, 3
                )
                love.graphics.setColor(self.colors.selectedText)
            else
                love.graphics.setColor(self.colors.item)
            end

            -- Item text
            love.graphics.print(item.label, self.x + self.padding, itemY + 4)
        end

        itemY = itemY + self.itemHeight
    end

    -- Hints at bottom
    love.graphics.setColor(self.colors.hint)
    love.graphics.print(
        "[Up/Down] Navigate  [Enter] Select  [F1] Close",
        self.x + self.padding,
        itemY + 5
    )

    love.graphics.setFont(prevFont)
    love.graphics.setColor(1, 1, 1, 1)
end

function DebugMenu:keypressed(key)
    if not self.visible then return false end

    if key == "up" then
        self:selectPrevious()
        return true
    elseif key == "down" then
        self:selectNext()
        return true
    elseif key == "return" or key == "space" then
        self:confirm()
        return true
    elseif key == "escape" or key == "f1" then
        self:hide()
        return true
    end

    return false
end

function DebugMenu:mousepressed(x, y, button)
    if not self.visible then return false end

    if button == 1 then
        -- Check if click is within menu bounds
        local totalHeight = self.padding * 2 + self.itemHeight + 10 + (#self.items * self.itemHeight) + 30

        if x >= self.x and x <= self.x + self.width and
           y >= self.y and y <= self.y + totalHeight then
            self:confirm()
            return true
        end
    end

    return false
end

return DebugMenu
