local tlm = {}

local width  = 128
local height = 128

local size = 16

local quad = love.graphics.newQuad
local quads = {
  quad(0,0,32,32,64, 32),
  quad(32,0,32,32,64, 32),
  quad(0,0,32,32,64, 32),
  
}

function tile(x,y,w,h,quad)
  local tile = {}

  tile.pos = require("tools/vec2"):new(x,y)
  tile.size= require("tools/vec2"):new(w,h)
  tile.quad= quad

  return tile
end

function tlm:load()

  self.tiles = {}
  -- self.img = love.graphics.newImage("assets/images/tilesheet.png")
  self.img = love.graphics.newImage("assets/maps/test.png")

  renderer:addRenderer(self, 2)
  gameloop:addLoop(self)

end

function tlm:loadMap(mapname)
  local map = require("assets/maps/"..mapname)

  for i = 1,map.height do self.tiles[i] = {} end

  for layer = 1,#map.layers do
    local data = map.layers[layer].data
    local prop = map.layers[layer].prop

    for y = 1, map.height do 
      for x = 1, map.width do 

        local index = (y*map.height +(x+1)-map.width)+1
        if data[index] ~= 0 then
          local q = quads[data[index]]
          self.tiles[y][x] = tile(32*x-32, 32*y-32, 32, 32, q)
          -- self.tiles[y][x] = tile(32*x-32, 32*y-32, 32, 32, quad(32,0,32,32,64,32))
        end

      end
    end
  end
end
function tlm:destroy( )
end
function tlm:tick()
end
function tlm:draw()
  for i = 1, #self.tiles do
    for j = 1, #self.tiles do
      if self.tiles[i][j] ~= nil then
        local tile = self.tiles[i][j]
        love.graphics.draw(self.img, tile.quad or quad(32,0,32,32,64,32), tile.pos.x, tile.pos.y)
      end
      -- local t = self.tiles[i][j]
      -- love.graphics.rectangle("fill",size*t.x-size,size*t.y-size,t.w,t.h)
    end
  end

end

function tlm:add(t)
  self.tiles[t.y][t.x] = t
end

return tlm