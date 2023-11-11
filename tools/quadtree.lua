-- Quadtree Node Class
local QuadNode = {}
QuadNode.__index = QuadNode

function QuadNode:new(x, y, width, height, max_objects, max_levels, level)
    local node = setmetatable({}, QuadNode)
    node.x, node.y, node.width, node.height = x, y, width, height
    node.objects = {}
    node.children = {}
    node.max_objects = max_objects or 4
    node.max_levels = max_levels or 8
    node.level = level or 0
    return node
end

function QuadNode:split()
    local subWidth = math.floor(self.width / 2)
    local subHeight = math.floor(self.height / 2)
    local x, y = self.x, self.y

    self.children[1] = QuadNode:new(x, y, subWidth, subHeight, self.max_objects, self.max_levels, self.level + 1)
    self.children[2] = QuadNode:new(x + subWidth, y, subWidth, subHeight, self.max_objects, self.max_levels, self.level + 1)
    self.children[3] = QuadNode:new(x, y + subHeight, subWidth, subHeight, self.max_objects, self.max_levels, self.level + 1)
    self.children[4] = QuadNode:new(x + subWidth, y + subHeight, subWidth, subHeight, self.max_objects, self.max_levels, self.level + 1)
end

function QuadNode:getIndex(object)
    local objectX, objectY, objectWidth, objectHeight = object.x, object.y, object.width, object.height
    local verticalMidpoint = self.x + self.width / 2
    local horizontalMidpoint = self.y + self.height / 2

    local topQuadrant = objectY < horizontalMidpoint and objectY + objectHeight < horizontalMidpoint
    local bottomQuadrant = objectY > horizontalMidpoint

    if objectX < verticalMidpoint and objectX + objectWidth < verticalMidpoint then
        if topQuadrant then
            return 1
        elseif bottomQuadrant then
            return 3
        end
    elseif objectX > verticalMidpoint then
        if topQuadrant then
            return 2
        elseif bottomQuadrant then
            return 4
        end
    end

    return 0 -- Object cannot completely fit in a child node, so it belongs here
end

function QuadNode:insert(object)
    if self.children[1] then
        local index = self:getIndex(object)

        if index > 0 then
            self.children[index]:insert(object)
            return
        end
    end

    table.insert(self.objects, object)

    if #self.objects > self.max_objects and self.level < self.max_levels then
        if not self.children[1] then
            self:split()
        end

        local i = 1
        while i <= #self.objects do
            local index = self:getIndex(self.objects[i])
            if index > 0 then
                self.children[index]:insert(table.remove(self.objects, i))
            else
                i = i + 1
            end
        end
    end
end

function QuadNode:retrieve(returnObjects, object)
    local index = self:getIndex(object)
    if index > 0 and self.children[1] then
        self.children[index]:retrieve(returnObjects, object)
    end

    for _, obj in ipairs(self.objects) do
        table.insert(returnObjects, obj)
    end

    return returnObjects
end

function QuadNode:clear()
    self.objects = {}
    for i = 1, 4 do
        if self.children[i] then
            self.children[i]:clear()
            self.children[i] = nil
        end
    end
end

-- Quadtree Class
local Quadtree = {}
Quadtree.__index = Quadtree

function Quadtree:new(x, y, width, height, max_objects, max_levels)
    local tree = setmetatable({}, Quadtree)
    tree.root = QuadNode:new(x, y, width, height, max_objects, max_levels)
    return tree
end

function Quadtree:insert(object)
    self.root:insert(object)
end

function Quadtree:retrieve(area, returnObjects)
    return self.root:retrieve(returnObjects, area)
end

function Quadtree:clear()
    self.root:clear()
end

return Quadtree
