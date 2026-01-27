# CLAUDE.md - Project Instructions for Claude Code

This file contains project-specific context and instructions for Claude Code when working on the Invadors codebase.

## Project Overview

**Invadors** is a LÖVE2D game (Lua) with 294+ files, 70+ game states, and a modular architecture. It's a side-scrolling platformer with multiple game modes, a tile-based world system, and extensive UI components.

## Technology Stack

- **Engine**: LÖVE 11.5 (migrated from 10.2)
- **Language**: Lua
- **Libraries**: middleclass (OOP), stateful (state management), bump (collision), gspot (UI)

## Critical Information

### LÖVE 11 Color Format
All colors must use **0.0-1.0 range** (not 0-255):
```lua
-- CORRECT (LÖVE 11+)
love.graphics.setColor(1, 0, 0, 1)           -- Red
love.graphics.setColor(80/255, 80/255, 100/255, 1)  -- Blue-gray

-- WRONG (LÖVE 10.2 format - will appear white/washed out)
love.graphics.setColor(255, 0, 0, 255)       -- Don't use!
```

### Deprecated APIs (LÖVE 11)
| Old (10.2) | New (11+) |
|------------|-----------|
| `love.filesystem.exists(path)` | `love.filesystem.getInfo(path) ~= nil` |
| `love.graphics.setNewFont(size)` | `love.graphics.setFont(love.graphics.newFont(size))` |

## Project Structure

```
invadors/
├── main.lua              # Bootstrap loader
├── game.lua              # Main Game class, state loading
├── conf.lua              # LÖVE configuration
├── colors.lua            # Color constants (0-1 format)
├── src/
│   ├── core/
│   │   ├── dependencies.lua   # Main dependency loader
│   │   ├── constants.lua      # Debug flags, globals
│   │   ├── version.lua        # Version management
│   │   ├── game_config.lua    # Centralized config values
│   │   ├── services.lua       # Service locator pattern
│   │   └── love_compat.lua    # LÖVE 10→11 compatibility
│   └── ui/
│       ├── theme.lua          # UI theming (colors, fonts, spacing)
│       ├── Button.lua         # Reusable button component
│       ├── Layout.lua         # Layout helpers
│       ├── UIManager.lua      # UI element management
│       └── debug_menu.lua     # Debug menu component
├── states/               # Game states (70+)
│   ├── menu/             # Main menu, new game, load save
│   ├── generate/         # Main gameplay state
│   ├── characterCreation/
│   ├── inventory/
│   ├── dialogue/
│   └── ...
├── objects/              # Game entities
│   ├── player.lua
│   ├── zombie.lua
│   ├── item.lua
│   └── coin.lua
├── tiles/
│   └── tlm.lua           # Tile manager (1039 lines - chunk gen + map loading)
├── tools/
│   ├── renderer.lua
│   ├── gameloop.lua
│   ├── camera.lua
│   ├── asm.lua           # Asset manager
│   └── obm.lua           # Object manager
└── assets/
    └── maps/             # Tiled map exports (.lua format)
```

## Key Systems

### State Management
States use middleclass + stateful pattern:
```lua
local MyState = Game:addState('MyState')

function MyState:enteredState() end
function MyState:exitedState() end
function MyState:update(dt) end
function MyState:draw() end
function MyState:keypressed(key, code) end
```

Transitions:
- `self:gotoState('stateName')` - Full switch
- `self:pushState('stateName')` - Overlay/stack
- `self:popState('stateName')` - Return from overlay

### Generate State Debug Menu
The main gameplay state (`states/generate/generate.lua`) has a built-in debug menu:
- **Toggle**: Press **F1**
- **Features**:
  - Switch between procedural chunks and tiled maps
  - Load any available map (bedroom/house1-3, test levels, etc.)
  - Respawn player, reset camera
  - Toggle grid and hitbox visualization

### Tile Manager (tlm.lua)
Two modes:
1. **Custom Maps** (`tlm.customMap = true`): Loads Tiled-exported .lua maps
2. **Chunk Generation** (`tlm.customMap = false`): Procedural 16x16 tile chunks

### Available Maps
Located in `assets/maps/`:
- bedroom/house0, house1, house2, house3, underground
- test/stonebox, test/test
- test2/test, test2/test2
- generator/template, generator/proggen1
- infinite/infinite
- ship/test

## Debug Flags (src/core/constants.lua)

| Flag | Default | Purpose |
|------|---------|---------|
| `DEBUG_NOSPLASH` | false | Skip splash screen |
| `DEBUG_HITBOX_VIS` | true | Show entity hitboxes |
| `DEBUG_GRID_ON` | false | Show tile grid |
| `DEBUG_SHOW_FPS` | true | Show FPS counter |
| `DEBUG_LOGGING_ON` | true | Enable console logging |

## Common Patterns

### Adding a New State
1. Create file in `states/` folder
2. Register: `local MyState = Game:addState('myState')`
3. Add to `game.lua` via `loadStateFile('myState')` or `loadStateFolder('myFolder')`

### Color Usage
Always use the color constants from `colors.lua` or theme from `src/ui/theme.lua`:
```lua
love.graphics.setColor(COLOR_WHITE)  -- From colors.lua
love.graphics.setColor(Theme.colors.button.normal)  -- From theme.lua
```

## Known Issues

- Some states may still have unconverted 0-255 color values
- The `tlm.lua` file is monolithic (1039 lines) and could benefit from splitting
- Multiple duplicate files were consolidated in src/core/ (the src/ root duplicates were removed)

## Recent Changes (Session Notes)

### LÖVE 11.5 Migration
- Created `src/core/love_compat.lua` compatibility layer
- Updated `colors.lua` to 0-1 format
- Fixed `love.filesystem.exists()` calls
- Fixed `love.graphics.setNewFont()` calls
- Updated version requirement in `conf.lua`

### Files with Fixed Colors
- main.lua, highscore.lua
- objects/player.lua, zombie.lua, item.lua, coin.lua
- states/menu/menu.lua, newGame.lua, loadSave.lua
- states/characterCreation/characterCreation.lua, drawMan.lua
- states/face/man1.lua
- states/inventory/inventory.lua
- states/options/options.lua, pause.lua, splash.lua
- states/vapeStatus/vapeStatus.lua
- states/editor/editorui.lua
- tiles/tlm.lua

### New Core Systems Created
- `src/core/services.lua` - Service locator
- `src/ui/theme.lua` - UI theming
- `src/ui/Button.lua` - Button component
- `src/ui/Layout.lua` - Layout helpers
- `src/ui/UIManager.lua` - UI management

### Cleanup Performed
- Deleted duplicate files (src/constants.lua, src/dependencies.lua, src/logging.lua)
- Deleted src/particles/ (duplicate of src/utils/particles/)
- Deleted 11 scratch files across codebase
