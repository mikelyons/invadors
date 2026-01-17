--[[
  pois.lua

  first pass (with ai) attempt to add places of interests to sti tiled map rendering in worldMap
  see https://chatgpt.com/share/68037ffb-e1ac-8003-9d67-deb52ee83fc3
]]

local pois = {}

function pois.load(map)
    -- Assumes there's an object layer called "PointsOfInterest"
    -- local poiLayer = map.layers["PointsOfInterest"]
    local poiLayer = map.layers[2]
    print(poiLayer)
    for _, obj in ipairs(poiLayer.objects) do
        table.insert(pois, {
            name = obj.name,
            x = obj.x,
            y = obj.y,
            width = obj.width,
            height = obj.height,
            onInteract = function()
                print("Interacted with: " .. obj.name)
                -- Custom behavior per PoI can be added here
            end
        })
    end
end

function pois.update(player, isInteracting)
    for _, poi in ipairs(pois) do
        if checkCollision(player, poi) then
            if isInteracting then
                poi.onInteract()
            end
        end
    end
end

function pois.draw()
    for _, poi in ipairs(pois) do
        love.graphics.setColor(255, 255, 0, 130)
        love.graphics.rectangle("fill", poi.x, poi.y, poi.width, poi.height)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

-- Basic AABB collision
function checkCollision(a, b)
    return a.x < b.x + b.width and
           b.x < a.x + a.width and
           a.y < b.y + b.height and
           b.y < a.y + a.height
end

return pois
