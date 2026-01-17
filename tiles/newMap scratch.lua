
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