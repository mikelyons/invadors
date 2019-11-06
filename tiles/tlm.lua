local tlm = {}

local quad = love.graphics.newQuad
local quads = {}
--   quad(0,0,32,32,64, 32),
--   quad(32,0,32,32,64, 32)
-- }
local floor = math.floor

function gen_quads()
  for i = 1,floor(32/32) do
    for j = 1, floor(64/32) do
      -- print((32*j-32)..','..(32*i-32)..' '.. 32 ..',' .. 32 ..' ' .. 64 ..',' .. 32)
      table.insert(quads,quad(32*j-32, 32*i-32, 32, 32, 64, 32))
    end
  end
end
gen_quads()
-- for _,t in ipairs(quads) do print(t) end

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
  -- self.canvas = love.graphics.newCanvas(256, 64)
  self.canvas = love.graphics.newCanvas(200,200)
end


function tlm:is_solid_at_pos( x,y )
  solids = self.tiles[2]

  if solids[y][x] ~= nil then
    return true
  end
  return false
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
          -- (x,y,w,h,quad,type)
          local typevalue = data[index]
          self.tiles[layer][y][x] = tile(ts.w*x-ts.w,ts.h*y-ts.h,ts.w,ts.h,q,typevalue)
        end
      end
    end
  end
  tlm:loadMiniMap()
end

function tlm:destroy( )
end
function tlm:tick()
end

local lg = love.graphics
function tlm:loadMiniMap()
  -- very important!: reset color before drawing to canvas to have colors properly displayed
  -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
  lg.setColor(255, 255, 255, 255)
  lg.setBlendMode("alpha")
  local mm_x = g_Width /2
  local mm_y = g_Height/2
  local cx = camera.pos.x
  local cy = camera.pos.y

  lg.setCanvas(self.canvas)
    lg.clear() -- no trailing effect

    lg.setColor(10, 10, 10, 155) -- GREY medium translucent
    lg.rectangle("fill", cx, cy, 128, 64)

    lg.setLineWidth(5)
    lg.setColor(255, 5, 5, 255) -- RED
    lg.rectangle("line", cx, cy, 128, 64)

    lg.setLineWidth(1) -- stroke reset
    lg.setColor(255, 255, 255, 255) -- WHITE reset
  lg.setCanvas()
  for layer = 1,#self.tiles do
    for i = 1,16 do
      for j = 1,16 do

        if self.tiles[layer][i][j] ~= nil then
          local tile = self.tiles[layer][i][j]
          local text = tile.type
          local x_pos = camera.pos.x + floor(tile.pos.x / g_TileSize)+1
          local y_pos = camera.pos.y + floor(tile.pos.y / g_TileSize)+1

            -- minimap?
            if text ~= 2 then lg.setColor(20,0,0,255) end
            if text == 2 then lg.setColor(90,90,0,255) end
          -- lg.rectangle("fill",x_pos,y_pos,0,(2),(2))

          lg.setCanvas(self.canvas)
            -- lg.setColor(5, 255, 5, 255) -- GREEN
            -- lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
            lg.rectangle("fill",x_pos,y_pos,0,2,2)
            lg.setColor(255,255,255,255)
          lg.setCanvas()
            -- lg.setColor(255,255,255,255)
          -- lg.setCanvas()
          -- ( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
          -- love.graphics.draw(self.canvas, 200, 200, 0, 2, 2, 100, 100, 0, 0)

          lg.setColor(255,255,255,255)
        end

      end
    end
  end
end

function tlm:drawMinimap()


  lg.setBlendMode('alpha')
  local w = love.graphics.getWidth( ) 
  local h= love.graphics.getHeight( ) 
  local x = 0 * (1/camera.scale.x) - g_Width / 2
  local y = 0 * (1/camera.scale.y) - g_Height / 2
  -- camera:set()
    -- in the same renderer as the map background
    -- a wall minimap bounding box for the map
    lg.setColor(5,255,0,255) -- GREEN
    lg.rectangle("line", 0,0,256,64)
    lg.setColor(255,255,255)
  -- ( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
    -- draw at the camera.pos to lock it to the corner?
    love.graphics.draw(self.canvas, camera.pos.x, camera.pos.y, 0, 1, 1, 0, 0, 0, 0)
    -- love.graphics.draw(self.canvas, 0, 0, 0, 1, 1, 0, 0, 0, 0)
  -- camera:unset()
end
function tlm:draw()
  for layer = 1,#self.tiles do
    for i = 1,16 do
      for j = 1,16 do

        if self.tiles[layer][i][j] ~= nil then
          local tile = self.tiles[layer][i][j]
          -- local text = i..j
          local text = tile.type
          -- if i <2 then
          --   print(i..j..' tile: '..(tile.pos.x/32)..'x'..(tile.pos.y/32)..' rect('..tile.pos.x..','..tile.pos.y..'\','..(tile.pos.x+32)..','..tile.pos.y..'\',\'')
          -- end
          -- ( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
          -- lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
            -- minimap?
            -- love.graphics.draw(self.img,tile.quad,x_pos,y_pos,0,(1/16),(1/16))
            if text ~= 2 then lg.setColor(200,0,0,25) end
            if text == 2 then lg.setColor(2000,200,0,255) end
          lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
          -- lg.rectangle("fill",x_pos,y_pos,0,(2),(2))
            -- lg.setColor(255,255,255,255)
          -- lg.setCanvas()

          -- print the layer data from the map on the tile
          -- lg.printf(text, tile.pos.x, tile.pos.y, 32, 'left', 0, .85)
          lg.setColor(255,255,255,255)
        end

      end
    end
  end
  -- in the same renderer as the map background
  -- tlm:drawMinimap()
  -- love.graphics.draw(self.canvas, 200, 200, 0, 2, 2, 100, 100, 0, 0)
end

function tlm:add(t)
  self.tiles[t.y][t.x] = t
end

return tlm