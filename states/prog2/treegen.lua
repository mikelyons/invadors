
-- random tree generation
treeGen = {}

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
  layer.data[x + y * layer.width + 1] = tile_id -- +1 because Tile ID 0 represents an empty tile
end

function treeGen:new(self)
  return {
    init = function() end,
    load = function(self, objects_layer, tileset)
      print("")
      print("loaded treeGen")
      print("")
    end,
    randomTree = function(self, objects_layer, tileset)
      print('creating random trees')
      for i=0,objects_layer.width do
        for j=0, objects_layer.height do
          local xspot = math.random(1, objects_layer.width)
          local yspot = math.random(1, objects_layer.height)
          local xoffset = math.random(-1, 1)
          local yoffset = math.random(-1, 1)

          if (i < (objects_layer.width-1) and i > -1 and i % 5 == 0) then
            if j % 6 == 0 then
              -- print("i"..i.." j"..j)
              self.createTree(i+xoffset,j+yoffset, objects_layer, tileset)
            -- self.createTree(0+xspot,0+yspot, objects_layer, tileset)
            end
          end
        end
      end
    end,
    createTree = function(x, y, objects_layer, tileset)
      -- print('creating a tree at: '..x..', '..y)
      local xx, yy = x-1, y-1
      local x = x
      local y = y
      setTile(objects_layer, xx+1, yy+1, getTileID(tileset, 30, 0))
      setTile(objects_layer, xx+2, yy+1, getTileID(tileset, 31, 0))
      setTile(objects_layer, xx+1, yy+2, getTileID(tileset, 30, 1))
      setTile(objects_layer, xx+2, yy+2, getTileID(tileset, 31, 1))
      setTile(objects_layer, xx+1, yy+3, getTileID(tileset, 30, 2))
      setTile(objects_layer, xx+2, yy+3, getTileID(tileset, 31, 2))
      setTile(objects_layer, xx+1, yy+4, getTileID(tileset, 30, 3))
      setTile(objects_layer, xx+2, yy+4, getTileID(tileset, 31, 3))
      setTile(objects_layer, xx+1, yy+5, getTileID(tileset, 30, 4))
      setTile(objects_layer, xx+2, yy+5, getTileID(tileset, 31, 4))
    end
  }
end
return treeGen