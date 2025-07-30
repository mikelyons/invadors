# Generate Game System Documentation

## Overview

The Generate game system is a side-scrolling platformer that supports both procedurally generated chunk-based worlds and custom Tiled maps. It features a modular architecture with separate systems for tile management, object management, physics, and rendering.

## Architecture

### Core Systems

1. **Tile Manager (TLM)** - Handles chunk generation and custom map loading
2. **Object Manager (OBM)** - Manages game entities (player, zombies, items)
3. **Physics System** - Handles collision detection and gravity
4. **Renderer** - Manages drawing order and camera
5. **Game Loop** - Coordinates updates across all systems

## Chunk-Based Map System

### Chunk Structure

Chunks are 16x16 tile areas that make up the infinite world:

```lua
-- Chunk dimensions
CHUNK_SIZE = 16 tiles
TILE_SIZE = 32 pixels
CHUNK_PIXEL_SIZE = 16 * 32 = 512 pixels
```

### Chunk Generation

Chunks are generated procedurally using templates:

```lua
-- Chunk coordinate system
local chunkCoords = {
  x = floor(player.x / (32 * 16)),
  y = floor(player.y / (32 * 16))
}

-- Chunk storage
tlm.chunks = {} -- Array of all chunks
tlm.chunksByStrKey = {} -- Hash table for quick lookup
```

### Chunk Loading Process

1. **Template Loading**: Uses `assets/maps/generator/template.lua` as base
2. **Position Calculation**: Offsets tiles based on chunk coordinates
3. **Layer Processing**: Each chunk contains multiple tile layers
4. **Storage**: Chunks stored with string key format: `"x".."y"`

### Coordinate Systems

- **Screen Space (SS)**: Pixel coordinates on screen
- **Chunk Space (CS)**: Chunk grid coordinates
- **Tile Space (TS)**: Tile grid coordinates within chunks

```lua
-- Conversion functions
function posToCCoords(x, y)
  return vec2:new((x / 32) / 16, (y / 32) / 16)
end

function chunkCoordsToPos(chunkCoords)
  return vec2:new((chunkCoords.x * 32) * 16, (chunkCoords.y * 32) * 16)
end
```

## Custom Map System

### Tiled Map Support

The system supports multiple Tiled versions:
- **1.1.5**: Legacy format
- **1.8.4**: Modern format
- **1.10.2**: Latest format

### Map Loading Process

1. **Asset Loading**: Loads tile atlas image based on Tiled version
2. **Quad Generation**: Creates texture quads for each tile
3. **Layer Processing**: Processes each layer separately
4. **Tile Creation**: Creates tile objects with position and type data

### Layer System

Custom maps support multiple layers:

```lua
-- Layer structure
tlm.tiles = {
  [1] = {}, -- Background layer
  [2] = {}, -- Solid/collision layer  
  [3] = {}, -- Foreground layer
  -- Additional layers as needed
}
```

### Supported Map Files

- `bedroom/house1` - Working custom map
- `test/test` - Test map
- `test2/test2` - Alternative test map
- `generator/template` - Chunk template

## Player System

### Player Entity

The player inherits from the base Entity class:

```lua
Player:new(x, y) -- Creates player at position
```

### Player Features

- **Physics**: Gravity, jumping, collision detection
- **Animation**: Idle, walk, attack animations
- **Input**: Keyboard controls for movement
- **Inventory**: Item collection system
- **Camera**: Camera follows player position

### Player Controls

- **Movement**: WASD or arrow keys
- **Jump**: Spacebar
- **Attack**: Mouse click
- **Inventory**: E key
- **Dialogue**: L key
- **Pause**: P key

### Player Physics

```lua
-- Physics initialization
init_physics(player, 500) -- 500 gravity units

-- Jump mechanics
function physics_jump(obj)
  if obj.on_ground and obj.vel.y < 10 then
    obj.vel.y = -200
    obj.on_ground = false
  end
end
```

## Zombie System

### Zombie AI

Zombies have simple AI behavior:

1. **Player Detection**: Finds closest player entity
2. **Movement**: Moves toward player when on ground
3. **Direction**: Changes direction based on player position
4. **Physics**: Uses same physics system as player

### Zombie Behavior

```lua
-- AI logic
local player = obm:get_closest_by_id(self, "player")
if player then
  if self.pos.x < player.pos.x then
    self.vel.x = 50
    self.dir.x = 1
  else
    self.vel.x = 50  
    self.dir.x = -1
  end
end
```

### Zombie Features

- **Chase AI**: Follows player
- **Animation**: Basic movement animation
- **Collision**: Uses same collision system as player
- **Health**: Can be damaged/defeated

## Layer System

### Layer Types

1. **Background Layer (1)**: Decorative tiles, no collision
2. **Solid Layer (2)**: Collision tiles, blocks movement
3. **Foreground Layer (3)**: Decorative tiles on top
4. **Custom Layers**: Additional layers for special purposes

### Layer Rendering

```lua
-- Drawing order
for layer = 1, #chunk.tiles do
  for y = 1, mapHeight do
    for x = 1, mapWidth do
      local tile = chunk.tiles[layer][y][x]
      if tile then
        love.graphics.draw(tile.quad, tile.pos.x, tile.pos.y)
      end
    end
  end
end
```

### Collision Detection

Collision detection works on specific layers:

```lua
-- Try different layers for collision
local tiles = nil
if tlm.tiles[3] then
  tiles = tlm.tiles[3] -- Foreground layer
elseif tlm.tiles[2] then
  tiles = tlm.tiles[2] -- Solid layer
elseif tlm.tiles[1] then
  tiles = tlm.tiles[1] -- Background layer
end
```

## Physics System

### Collision Detection

Uses rectangle-based collision detection:

```lua
function rectangle_collision(rect_1, rect_2)
  return rect_1.pos.x + rect_1.size.x > rect_2.pos.x and
         rect_1.pos.x < rect_2.pos.x + rect_2.size.x and
         rect_1.pos.y + rect_1.size.y > rect_2.pos.y and
         rect_1.pos.y < rect_2.pos.y + rect_2.size.y
end
```

### Gravity System

```lua
function apply_gravity(obj, dt)
  obj.vel.y = obj.vel.y + obj.gravity * dt
  if obj.vel.y > 300 then
    obj.vel.y = 300 -- Terminal velocity
  end
end
```

### Ground Detection

```lua
-- Check if entity is on ground
if coll and tile.type ~= 0 then
  obj.vel.y = 0
  obj.on_ground = true
  obj.pos.y = tile.pos.y - obj.size.y
end
```

## Object Management

### Entity Base Class

All game objects inherit from Entity:

```lua
Entity:new(x, y, w, h, img, quad, id)
```

### Object Manager Functions

```lua
obm:add(obj) -- Add object to game
obm:get_closest_by_id(obj, id) -- Find object by ID
obm:tick(dt) -- Update all objects
```

### Entity Lifecycle

1. **Creation**: `Entity:new()`
2. **Loading**: `entity:load()`
3. **Update**: `entity:tick(dt)`
4. **Rendering**: `entity:draw()`
5. **Removal**: Set `entity.remove = true`

## Camera System

### Camera Features

- **Player Following**: Camera follows player position
- **Scaling**: Zoom in/out with +/- keys
- **Bounds**: Camera stays within world limits
- **Smooth Movement**: Interpolated camera movement

### Camera Controls

```lua
-- Zoom controls
if key == '-' then
  camera.scale.x = camera.scale.x + 0.2
  camera.scale.y = camera.scale.y + 0.2
end

if key == '=' then
  camera.scale.x = camera.scale.x - 0.2
  camera.scale.y = camera.scale.y - 0.2
end
```

## Debug Features

### Debug Modes

- **DEBUG_GRID_ON**: Shows tile grid
- **DEBUG_HITBOX_VIS**: Shows collision boxes
- **DEBUG_LOGGING_ON**: Enables debug output
- **DEBUG_SHOW_FPS**: Shows FPS counter

### Debug Functions

```lua
-- Print camera info
if key == 't' then
  PrintTable(camera, 3)
end

-- Generate chunks
if key == 'g' then
  coordToChunkCoord()
end
```

## Performance Considerations

### Optimization Strategies

1. **Chunk Loading**: Only load chunks near player
2. **Object Culling**: Only update visible objects
3. **Canvas Rendering**: Use canvas for minimap
4. **Quad Reuse**: Reuse texture quads

### Memory Management

- Objects marked for removal with `remove = true`
- Chunks stored in hash table for quick access
- Texture atlases loaded once and reused

## Future Improvements

### Planned Features

1. **Infinite Generation**: Procedural world generation
2. **Biome System**: Different chunk types
3. **Entity Spawning**: Dynamic entity placement
4. **Save System**: Save/load world state
5. **Multiplayer**: Network support

### Technical Debt

1. **Camera System**: Needs refactoring
2. **Collision Detection**: Improve accuracy
3. **Layer System**: Better layer management
4. **Performance**: Optimize rendering pipeline

## File Structure

```
states/generate/
├── generate.lua          # Main game state
├── player_scratch.lua    # Player development
└── checkCanvasSupport.lua # Canvas compatibility

tiles/
├── tlm.lua              # Tile manager
└── tlm.lua              # Chunk system

objects/
├── entity.lua           # Base entity class
├── player.lua           # Player implementation
├── zombie.lua           # Zombie implementation
└── item.lua             # Item system

tools/
├── obm.lua              # Object manager
├── physics_helper.lua   # Collision detection
└── world_physics.lua    # Physics system
```

This documentation provides a comprehensive overview of the Generate game system, covering all major components and their interactions. 