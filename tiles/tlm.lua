local tlm = {}

local quad = love.graphics.newQuad
local quads = {
  quad(0,0,32,32,64, 32),
  quad(32,0,32,32,64, 32),
  quad(0,0,32,32,64, 32),
  
}

function tile(x,y,w,h,quad,type)
  local tile = {}

  tile.type = type or 0
  tile.pos = require("tools/vec2"):new(x,y)
  tile.size= require("tools/vec2"):new(w,h)
  tile.quad= quad

  return tile
end

function tlm:load()
  renderer:addRenderer(self, 1)

  self.tiles = {}
  self.img = asm:get('tiles')
  self.img:setFilter("nearest", "nearest")

end

function tlm:loadMap(mapname)
  local map = require("assets/maps/"..mapname)
  local ts = {w=map.tilewidth, h=map.tileheight}

  for layer = 1,#map.layers do
    self.tiles[layer] = {}
    for i = 1,map.height do
      self.tiles[layer][i] = {}
    end
  end
  for layer = 1,#map.layers do
    local data = map.layers[layer].data
    local prop = map.layers[layer].properties

    for y = 1,map.height do
      for x = 1,map.width do

        local index = (y*map.height +(x-1)-map.width)+1

        if data[index] ~= 0 then
          local q = quads[data[index]]
          self.tiles[layer][y][x] = tile(ts.w*x-ts.w,ts.h*y-ts.h,ts.w,ts.h,q)
        end

      end
    end
  end


  -- for i = 1,map.height do self.tiles[i] = {} end

  -- for layer = 1,#map.layers do
  --   local data = map.layers[layer].data
  --   local prop = map.layers[layer].properties

  --   for y = 1, map.height do 
  --     for x = 1, map.width do 

  --       local index = (y*map.height +(x)-map.width)
  --       if data[index] ~= 0 then
  --         local q = quads[data[index]]
  --         self.tiles[y][x] = tile(32*x-32, 32*y-32, 32, 32, q, data[index])
  --         -- self.tiles[y][x] = tile(32*x-32, 32*y-32, 32, 32, quad(32,0,32,32,64,32))
  --       end

  --     end
  --   end
  -- end
end
function tlm:destroy( )
end
function tlm:tick()
end
function tlm:draw()
  for layer = 1,#self.tiles do
    for i = 1,16 do
      for j = 1,16 do

        if self.tiles[layer][i][j] ~= nil then
          local tile = self.tiles[layer][i][j]
          love.graphics.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
        end

      end
    end
  end

  -- for i = 1, #self.tiles do
  --   for j = 1, #self.tiles do
  --     if self.tiles[i][j] ~= nil then
  --       local tile = self.tiles[i][j]
  --       love.graphics.draw(self.img, tile.quad, tile.pos.x, tile.pos.y)
  --       local text = tile.type
  --       love.graphics.setColor(255, 223, 0)
  --       love.graphics.printf(text, tile.pos.x, tile.pos.y+10, 32, 'left', 0, .85)
  --       -- love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky )

  --     end
  --     -- local t = self.tiles[i][j]
  --     -- love.graphics.rectangle("fill",size*t.x-size,size*t.y-size,t.w,t.h)
  --   end
  -- end

end

function tlm:add(t)
  self.tiles[t.y][t.x] = t
end

return tlm