
-- directed path generation
rockgen = {}

-- helper function to populate the layer with a default tile ID
function populateLayer(layer, tile_id)
  for i=1, layer.width * layer.height do
    table.insert(layer.data, tile_id)
  end
end
-- helper function to get the ID of a tile from the tileset using x,y coordinates
function getTileID(tileset, x, y)
  local width = tileset.imagewidth / tileset.tilewidth
  return x + y * width + 1 -- +1 because Tile ID 0 represents an empty tile
end
-- helper function to set a tile in the layer based on x,y coordinates
function setTile(layer, x, y, tile_id)
  local x = x
  local y = y or 0
  layer.data[x + y * layer.width + 1] = tile_id -- +1 because Tile ID 0 represents an empty tile
end

function rockgen:new(self)
  return {
    init = function() end,
    load = function(self, rocks_layer, tileset)
      print("")
      print("loaded rockgen")
      print("")
      -- PrintTable(tileset)
      -- PrintTable(path_layer)
    end,
    rockgen = function(self, rocks_layer, tileset)
      print('creating rocks')
      -- TODO add random rocks?

      -- 3 wide path from left to right
      for x=0, rocks_layer.width-1 do
        setTile(rocks_layer, x, 9, 19)--getTileID(tileset, 19, 19))
        setTile(rocks_layer, x, 10, 19)--getTileID(tileset, 19, 19))
        setTile(rocks_layer, x, 11, 19)--getTileID(tileset, 19, 19))

      end
    end
  }
end
return rockgen