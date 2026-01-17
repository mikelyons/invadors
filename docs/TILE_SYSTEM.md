# Tile and Level System Documentation

**Last Updated:** 2026-01-16
**Status:** Working with known limitations

---

## Overview

The Invadors tile system supports two modes:
1. **Custom Maps** - Hand-crafted levels made in Tiled map editor
2. **Procedural Chunks** - Infinite world generated from templates

---

## Quick Reference

### Core Files

| File | Lines | Purpose |
|------|-------|---------|
| `tiles/tlm.lua` | 1039 | Tile Layer Manager - loading, rendering, collision |
| `tools/world_physics.lua` | 201 | Physics and collision detection |
| `src/core/game_config.lua` | - | Tile size and physics constants |

### Available Maps

| Map | Path | Tiled Version | Status |
|-----|------|---------------|--------|
| Bedroom House 1 | `bedroom/house1` | 1.8.4 | Working |
| Bedroom House 2 | `bedroom/house2` | 1.10.2 | Partial |
| Bedroom House 3 | `bedroom/house3` | - | Untested |
| Underground | `bedroom/underground` | 1.10.2 | Untested |
| Test Basic | `test/test` | 1.4.3 | Working |
| Stonebox | `test/stonebox` | 1.10.2 | Untested |
| Test 2 | `test2/test` | 1.5.0 | Working |
| Generator Template | `generator/template` | - | For chunks |
| Infinite | `infinite/infinite` | 1.7.2 | Broken |

### Tileset Images

| Path | Dimensions | Tiles | Used By |
|------|------------|-------|---------|
| `assets/maps/bedroom/house1.png` | 512x512 | 256 | house1, house2 |
| `assets/maps/test/test.png` | 64x32 | 2 | test maps |
| `assets/maps/test2/test.png` | 512x512 | 256 | test2 maps |
| `assets/maps/generator/test.png` | 64x32 | 2 | chunk generation |
| `assets/maps/infinite/brix.png` | 1024x768 | ~768 | infinite maps |

---

## How the Tile System Works

### Loading a Custom Map

```lua
-- In generate.lua or your state:
tlm:load(true)  -- true = custom map mode
tlm:loadMap('bedroom/house1')  -- Load from assets/maps/
```

### Loading Process

1. **tlm:load(customMap)** - Initialize tile manager
   - Creates quad arrays for rendering
   - Sets up chunk/tile storage

2. **tlm:loadMap(mapname)** - Load Tiled map
   - Reads `assets/maps/{mapname}.lua`
   - Detects Tiled version from `map.tiledversion`
   - Loads appropriate tileset image
   - Parses layers into `tlm.tiles[layer][row][col]`

3. **tlm:draw()** - Render tiles
   - Iterates through tile layers
   - Uses quads to draw from tileset

### Chunk Generation Mode

```lua
-- Enable procedural generation:
tlm:load(false)  -- false = chunk generation mode
```

- Generates 16x16 tile chunks (512x512 pixels each)
- Uses `generator/template.lua` as base
- Creates 9x9 grid of chunks by default
- Stores in `tlm.chunks` and `tlm.chunksByStrKey`

---

## Tile Data Structures

### Single Tile

```lua
tile = {
    index = 5,              -- Position in tileset (1-indexed)
    type = 1,               -- Collision type (0=air, 1=solid, 2=hazard)
    pos = vec2(160, 96),    -- World position in pixels
    size = vec2(32, 32),    -- Always 32x32
    quad = <Quad>,          -- LÖVE quad for rendering
    occupied = false        -- Reserved for future use
}
```

### Chunk Structure

```lua
chunk = {
    pos = {x = 512, y = 0},     -- World pixel position
    tiles = {                    -- 3D array [layer][row][col]
        [1] = {...},            -- Background layer
        [2] = {...},            -- Solid layer (collision)
        [3] = {...},            -- Foreground layer
    },
    chunkCoords = {x = 1, y = 0},  -- Grid coordinates
    strKey = "10"                   -- Lookup key
}
```

### Layer Convention

| Layer | Purpose | Collision |
|-------|---------|-----------|
| 1 | Background/sky | No |
| 2 | Solid platforms | Yes |
| 3 | Foreground/hazards | Varies |

---

## Creating New Maps in Tiled

### Recommended Settings

- **Tile Size:** 32x32 pixels
- **Map Size:** Any (common: 64x32, 32x32)
- **Orientation:** Orthogonal
- **Tiled Version:** 1.8.4 or 1.10.2

### Layer Setup

1. Create exactly 3 layers:
   - `background` - Layer 1
   - `solid` - Layer 2 (collision)
   - `foreground` - Layer 3

2. Mark solid tiles in Layer 2

### Export Process

1. In Tiled: File → Export As → Lua
2. Save to `assets/maps/yourmap/yourmap.lua`
3. Copy tileset PNG to same directory

### Tileset Requirements

- **Format:** PNG
- **Recommended sizes:**
  - Small: 64x32 (2 tiles)
  - Medium: 256x256 (64 tiles)
  - Large: 512x512 (256 tiles)
- **Tile grid:** 32x32 pixels per tile

---

## Adding a New Map to the Game

### Step 1: Create the Map

1. Create folder: `assets/maps/mymap/`
2. Create tileset: `assets/maps/mymap/tiles.png`
3. Create map in Tiled, export as `mymap.lua`

### Step 2: Register in Debug Menu

Edit `states/generate/generate.lua`:

```lua
local availableMaps = {
    -- ... existing maps ...
    {name = "My New Map", path = "mymap/mymap"},
}
```

### Step 3: Test

1. Run game, enter generate state
2. Press F1 for debug menu
3. Select your map

---

## Known Issues

### Critical

1. **Hardcoded Tileset Paths**
   - `tlm.lua` line 66, 494, 499 always load `house1.png`
   - Workaround: Maps must use compatible tileset

2. **Version Comparison Bug** (line 552)
   ```lua
   -- Wrong:
   if map.tiledversion == ("1.8.4" or "1.10.2") then
   -- Should be:
   if map.tiledversion == "1.8.4" or map.tiledversion == "1.10.2" then
   ```

3. **Infinite Map Format Not Supported**
   - Tiled's chunked format (infinite=1) doesn't parse correctly

### Moderate

4. **Layer 1 Not Drawn in Chunks**
   - `drawChunk()` skips background layer

5. **No Chunk Unloading**
   - Memory grows as player explores

6. **Coordinate Functions Broken**
   - `posToCCoords()` has undefined variables

---

## Extending the System

### Adding New Tileset Support

In `tiles/tlm.lua`, update `loadMap()`:

```lua
-- After loading map data:
local tilesetPath = "assets/maps/" .. mapname:match("(.+)/") .. "/" .. map.tilesets[1].image
asm:add(love.graphics.newImage(tilesetPath), 'tiles')
```

### Adding Tile Properties

In Tiled, add custom properties to tiles. Access in code:

```lua
local tileProperties = map.tilesets[1].tiles[tileId].properties
if tileProperties.hazard then
    -- Handle lava, spikes, etc.
end
```

### Implementing Chunk Streaming

```lua
function tlm:updateChunksAroundPlayer(playerPos)
    local playerChunk = self:posToCCoords(playerPos)

    -- Load 3x3 grid around player
    for dx = -1, 1 do
        for dy = -1, 1 do
            local chunkKey = (playerChunk.x + dx) .. "_" .. (playerChunk.y + dy)
            if not self.chunksByStrKey[chunkKey] then
                self:generateChunk({x = playerChunk.x + dx, y = playerChunk.y + dy})
            end
        end
    end

    -- Unload distant chunks
    for key, chunk in pairs(self.chunksByStrKey) do
        if math.abs(chunk.chunkCoords.x - playerChunk.x) > 2 or
           math.abs(chunk.chunkCoords.y - playerChunk.y) > 2 then
            self.chunksByStrKey[key] = nil
        end
    end
end
```

---

## Future Improvements

- [ ] Fix tileset path resolution from map metadata
- [ ] Support multiple tilesets per map
- [ ] Implement chunk streaming (load/unload)
- [ ] Add collision shape support from Tiled
- [ ] Create map editor integration
- [ ] Add parallax background support
- [ ] Implement tile animations

---

## File Inventory

### Map Files (27 total)

```
assets/maps/
├── bedroom/
│   ├── house1.lua, house1.tmx, house1.png
│   ├── house2.lua, house2.tmx
│   ├── house3.lua
│   ├── underground.lua, underground.tmx
│   ├── bedroom1.tmx
│   └── kitchen.tmx
├── test/
│   ├── test.lua, test.tmx, test.png
│   ├── test-simplify.lua
│   └── stonebox.lua, stonebox.tmx
├── test2/
│   ├── test.lua, test.tmx, test.png, temp.png
│   └── test2.lua, test2.tmx
├── generator/
│   ├── template.lua
│   ├── proggen1.lua
│   └── test.png
├── infinite/
│   ├── infinite.lua, infinite.tmx
│   └── brix.png
├── ship/
│   └── test.lua, test.tmx
├── earthmap/
│   └── earth2map1.tmx
├── testMap.lua
└── 4tiles.png, test copy.png
```

---

## Debug Menu (F1)

The generate state includes a debug menu (press F1) that allows:
- Loading any registered map
- Switching to procedural chunk generation
- Respawning player
- Resetting camera
- Toggling debug overlays (grid, hitboxes)
