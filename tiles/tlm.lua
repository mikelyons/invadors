--[[
  tlm.lua - The tile handling code

    Handles generation of chunks of tiles for the world
    loads custom tile worlds
    many other things

    DOES NOT 
    -- handle gravity
    -- handle assets or player code
]]
local vec2 = require "tools/vec2"

local tlm = {}

local floor = math.floor
local quad = love.graphics.newQuad
quads = {}
print('gen_quads')

-- these quads punch out the tiles from the tileatlas
--[[
  This function creates the table of quads that have the proper coordinates on the tile atlas to mask each tile as it's
    repeated on the tile gird world
]]
function tlm:gen_quads(map)
  -- print(map)
  print ("GENERATING QUADS [___]")
  if not map then
    print('no map')
    print('no map')
    print('no map')
      for i = 1,floor(32/32) do
        for j = 1, floor(64/32) do
          -- print((32*j-32)..','..(32*i-32)..' '.. 32 ..',' .. 32 ..' ' .. 64 ..',' .. 32)
          table.insert(quads,
            quad(
              32*j-32,
              32*i-32,
              32,
              32,
              64, 32))
        end
      end
  else
    print('map')
    print('map')
    print('map')
    -- if map.tiledversion == "1.1.5" then
    if true then

      -- asm:add(love.graphics.newImage("assets/images/terrain_32x32_by_sonicrumpets-d7vj9k7.png"),
      --   'tiles'
      -- )
      print('map.tiledversion = ' .. map.tiledversion)
      -- for i = 1,floor(32/32) do
      --   for j = 1, floor(64/32) do

      local mt = map.tilesets
      local iw, ih = mt.imagewidth, mt.imageheight
      local tw, th =  mt.tilewidth, mt.tileheight
      local imgsrc = mt.image

      print(self.img.getPixelWidth)

    asm:add(love.graphics.newImage("assets/maps/bedroom/house1.png"), 'im2')
    self.img = asm:get('im2')
      -- supports up to 256  32x32 tiles in a 512x512 png
      -- for i = 1,floor(512/32) do
      --   for j = 1, floor(512/32) do
      for i = 1,floor(512/32) do
        for j = 1, floor(512/32) do
          -- print((32*j-32)..','..(32*i-32)..' '.. 32 ..',' .. 32 ..' ' .. 64 ..',' .. 32)
          -- print(
          --   'quad: ',
          --   32*j-32,
          --   32*i-32,
          --   32,
          --   32,
          --   512,
          --   512
          -- )
          -- table.insert(quads, quad(
          --   32,32,
          --   -- 32*j-32,
          --   -- 32*i-32,
          --   32,
          --   32,
          --   512,
          --   512
          -- ))
          -- print('raint')
          table.insert(quads, quad(
            32*j-32,
            32*i-32,
            32,
            32,
            512,
            512
          ))
          -- table.insert(quads, quad(
          --   32*j-32,
          --   32*i-32,
          --   32,
          --   32,
          --   512,
          --   512
          -- ))
        end
      end
      -- local y, x = map.height, map.width
      -- for i = 1, floor(x/32) do
      --   for j = 1, floor(y/32) do
      -- -- for i = 1, floor(64) do
      -- --   for j = 1, floor(32) do
      --     print((32*j-32)..','..(32*i-32)..' '.. 32 ..',' .. 32 ..' ' .. 64 ..',' .. 32)
      --     table.insert(quads,quad(32*j-32, 32*i-32, 32, 32, 64, 32))
      --   end
      -- end
    else
      print('PROBLEMMMMMMMMMMMMMMMMMMMMMM tlm.gen_quads()')
    end
  end
        -- PrintTable(quads)

end
-- gen_quads()


-- WIP functions to create and load chunked maps in the users save
-- function tlm:createMap() end
-- function tlm:loadSavedMap() end

function tile(x,y,w,h, quad, type, index)
  local tile = {}
  tile.index = index

  tile.type = type or 0
  tile.pos  = require("tools/vec2"):new(x,y)
  tile.size = require("tools/vec2"):new(w,h)
  tile.quad = quad

  tile.occupied = false

  return tile
end

-- WIP
-- function chunk(x,y,w,h,index)
--   local chunk = {}
--   chunk.index = index

--   chunk.tiles = {}
--   chunk.pos = require('tools/vec2'):new(x,y)
--   chunk.size= require('tools/vec2'):new(w,h)

--   return chunk
-- end

function tlm:load(isCustomMap)
  print('tlm loaded ->')
  renderer:addRenderer(self, 1)

  -- switches between not-chunk-based-pre-built and chunk based generated map,
  -- self.customMap = false
  self.customMap = isCustomMap

  self.map = {}
  self.tiles = {}
  self.chunks = {}
  self.chunksByStrKey = {}
  self.chunksLoaded = false

  self.canvas = love.graphics.newCanvas(200,200) -- what for?

  -- left to right then down
  function chunkdump(chunkCoords)
    local coords = chunkCoords or nil

    coords = vec2:new(0, 0)
    tlm:generateChunk(coords)

    for x = -4, 4 do
      for y = -4, 4 do
        coords = vec2:new(x, y)
        tlm:generateChunk(coords)
      end
    end

    self.chunksLoaded = true
  end

  if not customMap then -- load default chunk test assets
    asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')
    tlm:gen_quads()
    self.img = asm:get('tiles') -- set TLM's img to the test assets
    self.img:setFilter("nearest", "nearest") -- not sure what we're doing here
    chunkdump() -- dump chunks!
  else

    -- do nothing because custom maps load their own assets
  end
end

function tlm:destroy() end
function tlm:tick() end

function tlm:is_solid_at_pos( x,y )
  local solids = self.tiles[2]

  if solids[y][x] ~= nil then
    return true
  end
  return false
end

function tlm:loadChunk() end
function tlm:generateChunk(chunkCoords, chunkOptions)
  -- make chunk generation configurable
  -- not yet in use WIP
  if chunkOptions then
    local co = chunkOptions or nil
    local biome = co.biome or nil
    local entities = co.entities or nil
  end

  -- the chunk template
  local map = require("assets/maps/generator/template")--..mapname)

  local ox = chunkCoords.x * 32 * 16
  local oy = chunkCoords.y * 32 * 16

  if DEBUG_LOGGING_CHUNKS then
    print('-> Generating chunk')
    print('--> '..tostring(chunkCoords.x)..tostring(chunkCoords.y))
    print('--> '.. ox ..' ' .. oy)
  end

  local chunk = {}
  chunk.pos   = {}
  chunk.pos.x = ox
  chunk.pos.y = oy
  chunk.tiles = {}
  chunk.chunkCoords = chunkCoords
  chunk.strKey = tostring(chunkCoords.x)..tostring(chunkCoords.y)


  -- tile size
  local ts = {w=map.tilewidth, h=map.tileheight}
  --template is 16 tiles square
  local mapHeight,mapWidth = 16,16

  for layer = 1,#map.layers do
    chunk.tiles[layer] = {}

    for i = 1,mapHeight do
      chunk.tiles[layer][i] = {}
    end
  end

  -- for all Layers do
  for layer = 1,#map.layers do
    local L = map.layers[layer]
    local name = L.name
    -- print('Generating world: '..L['name'])
    local data = L.data
    local prop = L.properties

    -- each row index y
    for y = 1,mapHeight do
      -- each column index x on that y
      for x = 1,mapWidth do

        -- chunk offset for tile positioning
        -- local ox = chunkCoords.x * 32 * 16
        -- local oy = chunkCoords.y * 32 * 16
        -- print(data[index])

        -- the index of the tile based on it's x and y position
        local index = (y*mapHeight + (x-1)-mapWidth) + 1
        if data[index] ~= 0 then
          local q = quads[data[index]]
          local typevalue = data[index]
                                  --  tile(x,y,w,h,quad,type)
          chunk.tiles[layer][y][x] = tile(
            (ts.w*x-ts.w)+ox,
            (ts.h*y-ts.h)+oy,
            ts.w,
            ts.h,
            q,
            typevalue,
            index
          )
        end
      end
    end
  end

  -- loaded chunks
  self.chunks[#self.chunks+1] = chunk
  self.chunksByStrKey[chunk.strKey] = chunk

  if DEBUG_LOGGING_CHUNKS then
    print('CHUNK generated@: x'..tostring(chunkCoords.x)..' y'..tostring(chunkCoords.y))
  end
  return chunk
end

-- coordinate helpers
--[[
  a set of ohelper functions to convert between screen space SS, chunk space CS, and tile space TS
  this allows different coordinate systems to be used for collision detection and world generation
  @TODO - WIP: SS,CS,TS are still to be renamed and implemented/refined
]]
-- screenspace position coordinates to chunkspace coordinates
function tlm:posToCCoords(coords)
  local chunkCoords = require('tools/vec2'):new(
    (x / 32) / 16,
    (y / 32) / 16
  )
  return chunkCoords
end
-- chunkspace coordinate to screenspace coordinate
function tlm:chunkCoordsToPos(chunkCoords)
  local coords = require('tools/vec2'):new(
    (chunkCoords.x * 32) * 16,
    (chunkCoords.y * 32) * 16
  )
  return coords
end
-- screenspace coordinate to tilespace coordinate
function tlm:coordsToTile(coords)
  local tileCoords = require('tools/vec2'):new(
    (coords.x / 32) / 16,
    (coords.y / 32) / 16
  )
  return tileCoords
end
function tlm:getTilesAtCoords(coords)
  local coords = coords
  local chunkCoords = {}
  chunkCoords.x = (coords.x / 32) / 16
  chunkCoords.y = (coords.y / 32) / 16

  return tlm:getChunkTiles(chunkCoords)
end
function tlm:getChunkTiles(chunkCoords)
  local tiles = {}
  local strKey = tostring(chunkCoords.x)..tostring(chunkCoords.y) 

  if (self.chunksByStrKey[strKey]) then
    tiles = self.chunksByStrKey[strKey].tiles
    return tiles
  end

  return tiles
end
function tlm:strKeyAtPos(pos)
  local x, y = pos.x, pos.y
  -- vec2 strKey
  -- local strKey = require('tools/vec2'):new(
  --   (x / 32) / 16,
  --   (y / 32) / 16
  -- )
  local strKey = tostring(floor(x / 32 / 16))
    .. tostring(floor(y / 32 / 16))
  print(strKey)
end

-- @TODO:  Oldschool map loader - TODO update this to chunkloader

function tlm:generateMap()--mapname)
  local map = require("assets/maps/generator/template")--..mapname)
  -- tile size
  local ts = {w=map.tilewidth, h=map.tileheight}
  --template is 16 tiles square
  local mapHeight,mapWidth = 16,16

  -- tiles is {} on load
  --Layers: 
    -- 0: - tiles-bg
    -- 1: - tiles-solid
    -- 2: - foreground
  for layer = 1,#map.layers do
    self.tiles[layer] = {}

    for i = 1,mapHeight do
      self.tiles[layer][i] = {}
    end
  end

  for layer = 1,#map.layers do
    local L = map.layers[layer]
    local name = L.name
    -- print('Generating world: '..L['name'])
    local data = L.data
    local prop = L.properties

    -- each row index y
    for y = 1,mapHeight do
      -- each column index x on that y
      for x = 1,mapWidth do
        -- print(data[index])

        -- the index of the tile based on it's x and y position
        local index = (y*mapHeight + (x-1)-mapWidth) + 1

        if data[index] ~= 0 then
        -- if love.math.random(0,2) ~= 0 then
          local q = quads[data[index]]
          -- tile(x,y,w,h,quad,type)
          -- local typevalue = love.math.random(0,2)--data[index]
          local typevalue = data[index]
          -- self.tiles[layer][y][x] = tile(ts.w*x-ts.w,ts.h*y-ts.h,ts.w,ts.h,q,typevalue)

                                --  tile(x,y,w,h,quad,type)
          self.tiles[layer][y][x] = tile(ts.w*x-ts.w, ts.h*y-ts.h, ts.w, ts.h, q, typevalue, index)
        end
      end
    end
  end
  -- end
end

function tlm:loadMap(mapname)
  -- PrintDebug(mapname)
  print('')
  print('TLM427 -> LOADING MAP ' .. 'assets/maps/' .. mapname..'.lua ->')
  print('')
  self.map = require("assets/maps/"..mapname)
  -- self.map = require("assets/maps/test/")

  -- asm:add(love.graphics.newImage("assets/maps/test/test.png"), 'tiles')

  local mp = self.map

  local map = self.map
  -- PrintDebug(map)
  PrintTable(map, 3)

  -- what map uses this version?
  if map.tiledversion == "1.1.5" then
    print('')
    print(' -> LOADING TILED MAP->')
    print(' ->  ->  ->  ->  ->  ->')
    print(' -> VERSION:      '.. mp.version ..'   ->')
    print(' -> LUA VERSION:  '.. mp.luaversion ..'   ->')
    print(' -> TILED VERSION '.. mp.tiledversion ..' ->')
    print(' -> SOURCE IMAGE  '.. mp.tilesets[1].image ..' ->')
    -- print(' ->  '.. true ..' ->')
    -- print(' ->  '.. true ..' ->')
    -- print(' ->  '.. true ..' ->')
    -- print(' ->  '.. true ..' ->')
    print(' ->  ->')
    print('')

    asm:add(love.graphics.newImage("assets/maps/test/"..mp.tilesets[1].image), 'tiles')
  end
  -- house1.tmx, 
  if map.tiledversion == "1.8.4" then
    print('')
    print(' -> LOADING TILED MAP->')
    print(' ->  ->  ->  ->  ->  ->')
    print(' -> VERSION:      '.. mp.version ..'   ->')
    print(' -> LUA VERSION:  '.. mp.luaversion ..'   ->')
    print(' -> TILED VERSION '.. mp.tiledversion ..' ->')
    print(' -> SOURCE IMAGE  '.. mp.tilesets[1].filename..' ->')
    print(' ->  ->')
    print('')

    -- asm:add(love.graphics.newImage("assets/maps/bedroom/"..mp.tilesets[1].filename), 'tiles')
    -- asm:add(love.graphics.newImage("assets/maps/bedroom/"..mp.tilesets[1].name..'.png'), 'tiles')
    asm:add(love.graphics.newImage("assets/maps/bedroom/house1.png"), 'tiles')
  end
  if map.tiledversion == "1.10.2" then
    print('')
    print(' -> LOADING TILED MAP->')
    print(' ->  ->  ->  ->  ->  ->')
    print(' -> VERSION:      '.. mp.version ..'   ->')
    print(' -> LUA VERSION:  '.. mp.luaversion ..'   ->')
    print(' -> TILED VERSION '.. mp.tiledversion ..' ->')
    print(' -> SOURCE IMAGE  '.. mp.tilesets[1].filename..' ->')
    print(' ->  ->')
    print('')

    -- asm:add(love.graphics.newImage("assets/maps/bedroom/"..mp.tilesets[1].filename), 'tiles')
    -- asm:add(love.graphics.newImage("assets/maps/bedroom/"..mp.tilesets[1].name..'.png'), 'tiles')
    asm:add(love.graphics.newImage("assets/maps/bedroom/house1.png"), 'tiles')
  end


  self.img = asm:get('tiles')
  tlm:gen_quads(map)

  local ts = {
    w = map.tilewidth,
    h = map.tileheight
  }

  -- explain in documentation how these versions load differently
  -- so that we can fix it and also document for map makers
  if map.tiledversion == "1.1.5" then
    print("tiled 1.1.5")
    -- self.tiles is {} on load
    -- each layer
    for layer = 1,#map.layers do
      -- make a table for each layer in the self.tiles from load
      self.tiles[layer] = {}
      for i = 1,map.height do
        -- each tiles layer table entry for each tile in layer, assumes a square map
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
            local typevalue = data[index]
                                  --  tile(x,y,w,h,quad,type)
            self.tiles[layer][y][x] = tile(ts.w*x-ts.w,ts.h*y-ts.h,ts.w,ts.h,q,typevalue)
          end
        end
      end
    end
  end
  -- house1.tmx
  if map.tiledversion == "1.8.4" then
    print("tiled 1.8.4")
    -- self.tiles is {} on load
    -- each layer
    for layer = 1,#map.layers do
      -- make a table for each layer in the self.tiles from load
      self.tiles[layer] = {}
      for i = 1, map.height do
        -- each tiles layer table entry for each tile in layer, assumes a square map
        self.tiles[layer][i] = {}
      end
    end

    -- see gen_quads, this creates all the tiles for the layer
    -- but why is only one layer showing up?
    -- need to handle all layers here an in drawing

    for layer = 2, #map.layers do
      local count = 0
      local data = map.layers[layer].data
      local prop = map.layers[layer].properties

      for y = 1, map.height do
        for x = 1, map.width do

          count = count + 1

          local index =
            (y * map.height + (x-1) - map.width) + 1

          -- if data[index] ~= 0 then
            local q = quads[data[index]]
            -- local typevalue = data[index]
            local typevalue = data[count]
          -- if data[index] ~= 0 then
            -- print(data[count])
                                  --  tile(x,y,w,h,quad,type)
            self.tiles[layer][y][x] = tile(
              ts.w*x-ts.w,
              ts.h*y-ts.h,
              ts.w,
              ts.h,
              q,
              typevalue,
              count
            )
          -- end
        end
      end
    end
  end
  -- stonebox.tmx (.lua)
  if map.tiledversion == "1.8.4" then
    print("tiled 1.8.4")
    -- self.tiles is {} on load
    -- each layer
    for layer = 1,#map.layers do
      -- make a table for each layer in the self.tiles from load
      self.tiles[layer] = {}
      for i = 1, map.height do
        -- each tiles layer table entry for each tile in layer, assumes a square map
        self.tiles[layer][i] = {}
      end
    end

    -- see gen_quads, this creates all the tiles for the layer
    -- but why is only one layer showing up?
    -- need to handle all layers here an in drawing

    for layer = 1, #map.layers do
      local count = 0
      local data = map.layers[layer].data
      local prop = map.layers[layer].properties

      for y = 1, map.height do
        for x = 1, map.width do

          count = count + 1

          local index =
            (y * map.height + (x-1) - map.width) + 1

          -- if data[index] ~= 0 then
            local q = quads[data[index]]
            -- local typevalue = data[index]
            local typevalue = data[count]
          -- if data[index] ~= 0 then
            -- print(data[count])
                                  --  tile(x,y,w,h,quad,type)
            self.tiles[layer][y][x] = tile(
              ts.w*x-ts.w,
              ts.h*y-ts.h,
              ts.w,
              ts.h,
              q,
              typevalue,
              count
            )
          -- end
        end
      end
    end
  end
  tlm:loadMiniMap()
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
    -- lg.clear() -- no trailing effect

    lg.setColor(10, 10, 10, 155) -- GREY medium translucent
    lg.rectangle("fill", cx, cy, 128, 64)

    lg.setLineWidth(5)
    lg.setColor(255, 5, 5, 255) -- RED
    lg.rectangle("line", cx, cy, 128, 64)

    lg.setLineWidth(1) -- stroke reset
    lg.setColor(255, 255, 255, 255) -- WHITE reset
  lg.setCanvas()

  -- what is this doing?
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

-- WIP
function tlm:drawChunk(chunk)
  local tiles = chunk.tiles

  -- PrintTable(chunk.tiles, 1)

  for layer = 2,#chunk.tiles do
    for i = 1, 16 do
      for j = 1, 16 do

          -- ( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )

        if chunk.tiles[layer][i][j] ~= nil then
          local tile = chunk.tiles[layer][i][j]
          local text = tile.type
            -- lava colors
            -- if text ~= 2 then lg.setColor(200,0,0,25) end
            -- if text == 2 then lg.setColor(2000,200,0,255) end
          -- save color from above
          local _r, _g, _b, _a = love.graphics.getColor()
          --set shadow color
          -- lg.setColor(255,255,255,155)
          -- lg.draw(self.img,tile.quad,tile.pos.x+7,tile.pos.y+7)
          -- lg.draw(self.img,tile.quad,tile.pos.x+16,tile.pos.y+16)
          -- Shadow alpha

          --reset color
          lg.setColor(_r, _g, _b, _a)

          -- Opaque tiles
          lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)

          -- save color from above
          local _r, _g, _b, _a = love.graphics.getColor()
          if tile.type == 0 then lg.setColor(255,255,255,155)
          elseif tile.type == 1 then lg.setColor(55,0,5,155)
          elseif tile.type == 2 then lg.setColor(0,255,255,155)
          end
          -- print the index of the tile on it colored by type
          -- lg.printf(tile.index, tile.pos.x, tile.pos.y, 64, 'left', 0, .35)

          -- print the layer data from the map on the tile
          -- lg.printf(tile.type, tile.pos.x, tile.pos.y, 32, 'left', 0, .85)

          --reset color
          lg.setColor(_r, _g, _b, _a)

          -- if turned off, tiles/background bizzaro flashes -maybe not anymore
          if tile.occupied then
            print(tile.occupied)
            lg.setColor(255,5,5,255)
            love.graphics.rectangle('line',
              tile.pos.x, tile.pos.y,
              32,
              32
            )
          end
            -- -- red box around all tiles
            -- lg.setColor(255,5,5,255)
            -- love.graphics.rectangle('line',
            --   tile.pos.x, tile.pos.y,
            --   32,
            --   32
            -- )
          lg.setColor(255,255,255,255)
        end
      end
    end
  end

  love.graphics.print(
    -- love.timer.getFPS(),
    chunk.strKey or '--',
    chunk.pos.x, --+ (windowWidth - 64),
    chunk.pos.y --+ (windowHeight - 64)
  )

end

function tlm:drawCustomMap(newstylemap)
  -- print("")
  -- print(' -> DRAWING OLDSKOOL MAP -> ')
  -- print("")
  local layers = self.tiles

  if newstylemap then
    local map = self.map

    love.graphics.print(
      -- love.timer.getFPS(),
      'test',
      camera.pos.x + 200,
      camera.pos.y + 200
    )

    local s = {
      'raint',
      'raint raint',
      'raint raint raint'
    }


        -- what was I doing? 
        -- love.graphics.printf( text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky )

  -- works for tiled versions:
  -- 1.8.4, ... what else? (does NOT work for 1.10.2)
  for k = 1, #layers do -- for each layer
    local layer = k

    for i = 1, map.height do
      for j = 1, map.width do
        local tile = layers[layer][i][j]
        -- love.graphics.setColor(55,255,55,255)
        love.graphics.setColor(255,255,255,255)
        -- love.graphics.rectangle('fill',100,100,100,100)
        -- love.graphics.rectangle('fill',100,100,100,100)

        local key = love.keyboard.isDown
        if DEBUG_GRID_ON or key('g') then
          if (tile.pos.x and tile.pos.y) then
            love.graphics.rectangle('line',
              tile.pos.x, tile.pos.y, 32,32
            )
          end
        end

        -- why this nil check?
        if quads[raint] == nil then
          raint = 3
        end

        raint = tile.type
        love.graphics.setColor(255,255,255,255)
        -- 0 tile type is air block
        if tile.type == 0 then
          -- love.graphics.setColor( 205, 205, 195, 255)
          -- love.graphics.rectangle("fill",
          -- tile.pos.x,
          -- tile.pos.y,
          -- 64,
          -- 64)

          -- air block
          -- love.graphics.draw(
          --   self.img,
          --   -- quads[47],
          --   quads[4],
          --   tile.pos.x,tile.pos.y
          -- )

        else -- other tile type than 0 is a tile specified by the editor
          love.graphics.draw(
            self.img,
            quads[raint+2], --or quads[1], -- raint+2 offsets the tileset texture ids
            tile.pos.x,
            tile.pos.y
          )
        end

        -- Tile type index numbers
        if DEBUG_GRID_ON then
        -- if true then
          local _r, _g, _b, _a = love.graphics.getColor()--255,255,255,155)
          love.graphics.setColor(255,255,255,155)
            lg.printf(
              tile.type,
              tile.pos.x,
              tile.pos.y,
              64,
              'left',
              0,
              .55
            )
          love.graphics.setColor( _r, _g, _b, _a)
        end

        -- love.graphics.printf(
        --   text,
        --   tile.pos.x,
        --   tile.pos.y,
        --   limit,
        --   align,
        --   r,
        --   sx,
        --   sy,
        --   ox,
        --   oy,
        --   kx,
        --   ky
        -- )
    -- love.graphics.draw(
    --   self.img,
    --   tile.quad,
    --   tile.pos.x,
    --   tile.pos.y
    -- )
    -- love.graphics.rectangle(
    --   'fill',
    --   tile.pos.x,
    --   tile.pos.y,
    --   32,
    --   32
    -- )
    -- love.graphics.draw(
    --   self.img,
    --   tile.quad,
    --   teat.pos.x,
    --   tile.pos.y
    -- )
    -- local _r, _g, _b, _a = love.graphics.getColor()
    -- love.graphics.setColor(255,255,255,255)
    -- love.graphics.setColor(_r, _g, _b, _a)
    -- PrintTable(layers[layer][1][1], 1)
    --   -- print(s[3])
          -- if not layers[layer][i][j]  then
    --   -- print(s[3])
    --         -- local tile = layers[layer][i][j]
    --         -- local text = tile.type
    --         -- local _r, _g, _b, _a = love.graphics.getColor()
    --         -- lg.setColor(_r, _g, _b, _a)
    --         -- lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
    --         -- lg.draw(self.img,tile.pos.x,tile.pos.y, 100, 100)
    --         -- local _r, _g, _b, _a = love.graphics.getColor()
    --         -- if tile.type == 0 then lg.setColor(255,255,255,155)
    --         -- elseif tile.type == 1 then lg.setColor(255,0,255,155)
    --         -- elseif tile.type == 2 then lg.setColor(0,255,255,155)
    --         -- end
    --         -- lg.setColor(_r, _g, _b, _a)
    --         -- lg.setColor(255,255,255,255)
    --       else
    --         -- print('RAINT nil tile')
          -- end

        end
      end
  end

    -- love.graphics.print(
    --   -- love.timer.getFPS(),
    --   'tile',
    --   camera.pos.x + 32 + g_Width/2,
    --   camera.pos.y + 32 + g_Height/2 
    -- )
  else

    for layer = 1,#self.tiles do
      for i = 1,16 do
        for j = 1,16 do
            -- PrintTable(self.tiles[1][1][1])
            -- ( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
          if self.tiles[layer][i][j] ~= nil then
            local tile = self.tiles[layer][i][j]
            local text = tile.type
            -- save color from above
            local _r, _g, _b, _a = love.graphics.getColor()
            --reset color
            lg.setColor(_r, _g, _b, _a)
            -- Opaque tiles
            lg.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
            -- minimap?
            -- love.graphics.draw(self.img,tile.quad,x_pos,y_pos,0,(1/16),(1/16))
            -- love.graphics.printf( text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky )
            -- save color from above
            local _r, _g, _b, _a = love.graphics.getColor()
            if tile.type == 0 then lg.setColor(255,255,255,155)
            elseif tile.type == 1 then lg.setColor(255,0,255,155)
            elseif tile.type == 2 then lg.setColor(0,255,255,155)
            -- else lg.setColor(255,5,5,255)
            end
            -- print the index of the tile on it colored by type
            -- lg.printf(tile.index, tile.pos.x, tile.pos.y, 64, 'left', 0, .85)
            -- print the layer data from the map on the tile
            -- lg.printf(tile.type, tile.pos.x, tile.pos.y, 32, 'left', 0, .85)

            --reset color
            lg.setColor(_r, _g, _b, _a)
            -- if turned off, tiles/background bizzaro flashes
            lg.setColor(255,255,255,255)
          end

        end
      end
    end

  end
end

function tlm:draw()
  local customMap = self.customMap -- loaded or generated/chunked
  local map = self.map

  if not customMap then -- generated chunks
    -- draw all the chunks
    for i=1, #self.chunks do
      tlm:drawChunk(self.chunks[i])
    end
  end

  -- TODO - deprecate and update all maps (or not?)
  if customMap then
    -- print('custom map')
    if map.tiledversion == "1.1.5" then
      tlm:drawCustomMap()
    end
    if map.tiledversion == "1.8.4" then
      tlm:drawCustomMap(true)
    end
    if map.tiledversion == "1.10.2" then
      tlm:drawCustomMap(true)
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