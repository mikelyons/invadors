local sti = require("../../lib/sti")
local gamera = require("../../states/prog2/gamera")
--love.window.setFullscreen(true)

-- create a new orthogonal map that is 64x64 tiles, each tile is 32x32 pixels
local map = {
  orientation = "orthogonal",
  width = 64,
  height = 64,
  tilewidth = 32,
  tileheight = 32,
  tilesets = {},
  layers = {}
}

-- create a tileset from an image (Liberated Pixel Cup terrain_atlas.png from opengameart.org)
local tileset = {
  name = "terrain_atlas",
  firstgid = 1,
  tilewidth = 32,
  tileheight = 32,
  spacing = 0,
  margin = 0,
  image = "../../states/prog2/terrain_atlas.png",
  imagewidth = 1024,
  imageheight = 1024,
  tileoffset = {x = 0, y = 0},
  tilecount = 1024,
  tiles = {}
}
table.insert(map.tilesets, tileset)

-- create a layer of the map, with the same height/width as the map
function addLayer(map, name)
  local layer = {
    type = "tilelayer",
    name = name,
    x = 0,
    y = 0,
    width = 64,
    height = 64,
    visible = true,
    opacity = 1,
    offsetx = 0,
    offsety = 0,
    properties = {},
    encoding = "lua",
    data = {}
  }
  table.insert(map.layers, layer)
  return layer
end
-- add a layer to the map object's table
local layer = addLayer(map, "grass")

-- populate the layer with a default tile ID
function populateLayer(layer, tile_id)
  for i=1, layer.width * layer.height do
    table.insert(layer.data, tile_id)
  end
end

-- helper function to get the ID of a tile from the tileset using x,y coordinates
function getTileID(tileset, x, y)
  -- the width of each tile in image pixels
  local width = tileset.imagewidth / tileset.tilewidth
  return x + y * width + 1 -- +1 because Tile ID 0 represents an empty tile
end

-- create a grass background layer
local grass_tile_id = getTileID(tileset, 22, 3)
populateLayer(layer, grass_tile_id)

-- helper function to set a tile in the layer based on x,y coordinates
function setTile(layer, x, y, tile_id)
  layer.data[x + y * layer.width + 1] = tile_id -- +1 because Tile ID 0 represents an empty tile
end

-- create a layer for the rocks
local rocks_layer = addLayer(map, "rocks")
populateLayer(rocks_layer, 0)
local rockgen = require("../../states/prog2/rockgen")
Rock = rockgen:new()
Rock:load(rocks_layer, tileset)
Rock:rockgen(rocks_layer, tileset)

-- create a layer for the path
local path_layer = addLayer(map, "path")
populateLayer(path_layer, 0)
local pathgen = require("../../states/prog2/pathgen")
Path = pathgen:new(path_layer)
Path:load(path_layer, tileset)
Path:pathgen(path_layer, tileset)


-- create a layer for objects like the tree
local objects_layer = addLayer(map, "objects")
populateLayer(objects_layer, 0)
-- include trees
local treeGen = require("../../states/prog2/treegen")
Tree = treeGen:new(objects_layer)
Tree:load(objects_layer)
Tree:randomTree(objects_layer, tileset)


-- need to figure out sti tilemap:draw()
local tileMap = sti(map)
local w, h = tileMap.tilewidth * tileMap.width, tileMap.tileheight * tileMap.height
local camera = gamera.new(0, 0, w, h)

function love.draw()
  local dt = love.timer.getDelta()
  love.graphics.reset()
  camera:draw(function(l, t, w, h)
    tileMap:update(dt)
    tileMap:setDrawRange(-l, -t, w, h)
-- @TODO
-- need to figure out sti tilemap:draw()
    tileMap:draw()
  end)
end