-- spatialhash.lua

-- Define the spatial hash module
local SpatialHash = {}
SpatialHash.__index = SpatialHash

function SpatialHash:new(cellSize)
    local self = setmetatable({}, SpatialHash)
    self.cellSize = cellSize or 32
    self.cells = {}

    return self
end

function SpatialHash:clear()
    self.cells = {}
end

function SpatialHash:insert(object, x, y)
    local cellX = math.floor(x / self.cellSize)
    local cellY = math.floor(y / self.cellSize)
    local cellKey = cellX .. "," .. cellY

    if not self.cells[cellKey] then
        self.cells[cellKey] = {}
    end

    table.insert(self.cells[cellKey], object)
end

function SpatialHash:query(x, y)
    local cellX = math.floor(x / self.cellSize)
    local cellY = math.floor(y / self.cellSize)
    local cellKey = cellX .. "," .. cellY
    local objects = self.cells[cellKey] or {}

    return objects
end

-- Now, let's use this spatial hash in a Love2D/Tiled game:

-- main.lua

local SpatialHash = require("spatialhash")

local spatialHash
local objects = {}

function love.load()
    spatialHash = SpatialHash:new(32)

    -- Load your Tiled map here and extract object positions
    -- For example, you can use Tiled's Object Layer to place objects on the map
    -- objects should be a table with objects' positions, e.g., { { x = 100, y = 100 }, { x = 200, y = 200 } }

    for _, object in ipairs(objects) do
        spatialHash:insert(object, object.x, object.y)
    end
end

function love.update(dt)
    -- Perform game logic, as needed
end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.setColor(0, 0, 0)

    -- Replace this with your own rendering code for objects
    for _, object in ipairs(objects) do
        love.graphics.rectangle("fill", object.x, object.y, 32, 32)
    end

    -- Query objects in a specific cell
    local mouseX, mouseY = love.mouse.getPosition()
    local queriedObjects = spatialHash:query(mouseX, mouseY)

    love.graphics.setColor(255, 0, 0)
    for _, object in ipairs(queriedObjects) do
        love.graphics.rectangle("line", object.x, object.y, 32, 32)
    end
end
