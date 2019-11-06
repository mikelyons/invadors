local Starfield = {}
Starfield.__index = Starfield

--NOTE TEMP FOR STATS
local results = {}

function Starfield:clipResults()
    local str = "count,threshold,ox,oy\n"
    for i = 1, #results, 4 do
        str = str .. results[i] .. "," .. results[i+1] .. "," .. results[i+2] .. "," .. results[i+3] .. "\n"
    end

    love.system.setClipboardText(str)
    print("Results on clipboard.")
end
--NOTE TEMP FOR STATS

function Starfield:new(min, max)
    if (not min) or (not max) then
        min = 150
        max = 250
    end

    self = {} -- new instance
    setmetatable(self, Starfield)

    self.w, self.h = love.graphics.getWidth(), love.graphics.getHeight()
    self.ox, self.oy = 0, 0
    self.threshold = 0.99

    local RNG = love.math.newRandomGenerator(os.time()) -- don't mess with other randomness

    while (self.ox == 0) or (self.oy == 0) or (self.ox == 1) or (self.oy == 1) do
        self.ox, self.oy = RNG:random(), RNG:random()
    end

    local stars = 0

    while stars < min do
        stars = self:count()

        if stars < min then
            print("Starfield: too few stars! lowering threshold")
            self.threshold = self.threshold - 0.0005
        end

        if stars > max then
            print("Starfield: too many stars, using new seed")
            --NOTE TEMP FOR STATS
            table.insert(results, stars)
            table.insert(results, self.threshold)
            table.insert(results, self.ox)
            table.insert(results, self.oy)
            --NOTE TEMP FOR STATS
            self = Starfield:new(min, max) -- this is stupid, my code is really stupid
        end
    end

    return self
end

function Starfield:draw(cx, cy) -- camera x/y
    if (not cx) or (not cy) then
        cx, cy = 0, 0
    end

    for x = cx + self.ox, self.w + cx + self.ox do
        for y = cy + self.oy, self.h + cy + self.oy do
            if love.math.noise(x, y) > self.threshold then
                love.graphics.points(x - cx - self.ox, y - cy - self.oy)
            end
        end
    end
end

function Starfield:count(cx, cy) -- camera x/y
    if (not cx) or (not cy) then
        cx, cy = 0, 0
    end

    local stars = 0

    for x = cx + self.ox, self.w + cx + self.ox do
        for y = cy + self.oy, self.h + cy + self.oy do
            if love.math.noise(x, y) > self.threshold then
                stars = stars + 1
            end
        end
    end

    return stars
end

return Starfield
