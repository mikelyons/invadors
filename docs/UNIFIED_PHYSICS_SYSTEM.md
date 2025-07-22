# Unified Physics System

## Overview

The unified physics system provides a single collision detection and physics handling system that works seamlessly with both chunk-based procedurally generated maps and custom Tiled maps. This eliminates the need for separate physics functions and ensures consistent behavior across all map types.

## Architecture

### Core Components

1. **`unified_physics(obj, dt)`** - Main physics function that handles both map types
2. **`tlm:getTilesForPhysics()`** - Unified tile access system
3. **`tlm:getMapDimensions()`** - Unified map dimension system
4. **Updated entity physics calls** - All entities now use the same physics function

## How It Works

### Automatic Map Type Detection

The system automatically detects which map type is being used:

```lua
-- In unified_physics()
if tlm.customMap then
  -- Use custom map tile system
  tiles = tlm.tiles[layer]
else
  -- Use chunk-based tile system
  tiles = chunk.tiles[layer]
end
```

### Unified Tile Access

The `tlm:getTilesForPhysics()` function provides a single interface for accessing tiles:

```lua
function tlm:getTilesForPhysics()
  if self.customMap then
    -- Return tiles from custom map system
    return self.tiles
  else
    -- Return tiles from current chunk
    local player = obm:get_closest_by_id(nil, "player")
    if player then
      local chunkKey = tostring(floor(player.pos.x / 32 / 16)) .. tostring(floor(player.pos.y / 32 / 16))
      local chunk = self.chunksByStrKey[chunkKey]
      if chunk then
        return chunk.tiles
      end
    end
    return {}
  end
end
```

### Layer Priority System

The system uses a priority-based layer selection for collision detection:

1. **Custom Maps**: Tries layers in order: 3 (foreground) → 2 (solid) → 1 (background)
2. **Chunk Maps**: Uses layer 2 (solid) by default

```lua
-- Determine which layer to use for collision detection
if tlm.customMap then
  -- Custom map system - try different layers
  if allTiles[3] then
    tiles = allTiles[3] -- Foreground layer
  elseif allTiles[2] then
    tiles = allTiles[2] -- Solid layer
  elseif allTiles[1] then
    tiles = allTiles[1] -- Background layer
  end
else
  -- Chunk-based system - use solid layer
  if allTiles[2] then
    tiles = allTiles[2]
  end
end
```

## Implementation

### Entity Updates

All entities now use the same physics function:

```lua
-- Player physics (objects/player.lua)
function player:tick(dt)
  -- ... movement code ...
  
  -- Use unified physics system for both chunk-based and custom maps
  unified_physics(self, dt)
  
  -- ... rest of update code ...
end

-- Zombie physics (objects/zombie.lua)
function zombie:tick(dt)
  -- ... AI code ...
  
  -- Use unified physics system for both chunk-based and custom maps
  unified_physics(self, dt)
  
  -- ... rest of update code ...
end

-- Item physics (objects/item.lua)
function item:tick(dt)
  -- ... item logic ...
  
  -- Use unified physics system for both chunk-based and custom maps
  unified_physics(self, dt)
  
  -- ... rest of update code ...
end
```

### Collision Detection

The unified system uses the same collision detection algorithm for both map types:

```lua
-- Object's next-frame predicted position
local box = rect:new(
  obj.pos.x + (obj.vel.x * dt * obj.dir.x),
  obj.pos.y + obj.vel.y * dt,
  obj.size.x,
  obj.size.y
)

-- Check collision with the tile at the predicted position
local tile = tiles[tiley] and tiles[tiley][tilex]

if tile and tile.type ~= 0 then
  local coll, t = rectangle_collision(box, tile)
  
  if coll and t and t.type ~= 0 then
    -- Handle vertical collision (ground/ceiling)
    -- Handle horizontal collision (left/right walls)
  end
end
```

## Benefits

### Consistency
- Same physics behavior across all map types
- Unified collision detection algorithm
- Consistent ground detection and jumping mechanics

### Maintainability
- Single physics function to maintain
- No duplicate code between map systems
- Easier to add new physics features

### Performance
- Optimized tile access through unified system
- Reduced function call overhead
- Better memory usage patterns

### Extensibility
- Easy to add new map types
- Simple to modify physics behavior globally
- Clear separation of concerns

## Migration Guide

### Before (Old System)
```lua
-- Player had different physics calls
if not tlm.customMap then
  local chunk = tlm.chunksByStrKey[chunkKey]
  update_physics(self, chunk, dt, true)
else
  newupdate_physics(self, dt)
end

-- Zombie only used custom map physics
newupdate_physics(self, dt)

-- Item used old chunk physics
update_physics(self, tiles, dt)
```

### After (Unified System)
```lua
-- All entities use the same physics function
unified_physics(self, dt)
```

## Debug Features

The unified system includes comprehensive debug logging:

```lua
if DEBUG_LOGGING_COLLISION then
  print('Collision: tile-type:' .. tile.type)
  print('Bottom collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
  print('Top collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
  print('Left collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
  print('Right collision - tileindex: ' .. tile.index .. ' - type: ' .. tile.type)
end
```

## Future Enhancements

### Planned Improvements
1. **Multi-chunk collision detection** - Handle collisions across chunk boundaries
2. **Optimized tile lookup** - Spatial partitioning for better performance
3. **Advanced collision shapes** - Support for non-rectangular collision shapes
4. **Physics interpolation** - Smooth physics updates for better feel

### Technical Debt
1. **Remove old physics functions** - Clean up deprecated `update_physics` and `newupdate_physics`
2. **Standardize tile types** - Ensure consistent tile type values across map systems
3. **Add unit tests** - Comprehensive testing for physics behavior

## File Structure

```
tools/
├── world_physics.lua     # Unified physics system
└── physics_helper.lua    # Collision detection utilities

tiles/
└── tlm.lua              # Tile manager with unified access

objects/
├── player.lua           # Updated to use unified physics
├── zombie.lua           # Updated to use unified physics
└── item.lua             # Updated to use unified physics
```

This unified physics system provides a robust foundation for consistent gameplay across all map types while maintaining the flexibility to support both chunk-based and custom map systems. 