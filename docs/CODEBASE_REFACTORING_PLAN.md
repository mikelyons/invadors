# Invadors Codebase Refactoring Plan

**Created:** 2026-01-16
**Status:** Ready for Implementation
**Branches:** Start from `features/editor-470`

---

## Overview

This document captures a comprehensive codebase evaluation conducted by 6 specialized agents analyzing menus/UI, game state cruft, and modularization opportunities. Use this as a reference when starting implementation work.

---

## Quick Start Checklist

When resuming this work, tackle in this order:

### Phase 1: Low-Risk Cleanup (< 1 hour)

- [ ] Delete duplicate `src/constants.lua` (keep `src/core/constants.lua`)
- [ ] Delete duplicate `src/dependencies.lua` (keep `src/core/dependencies.lua`)
- [ ] Delete duplicate `src/logging.lua` (keep `src/core/logging.lua`)
- [ ] Delete duplicate `src/particles/` directory (keep `src/utils/particles/`)
- [ ] Delete `states/menu/menu_scratch.lua` (empty file)
- [ ] Delete `ui objects/gui.lua` (8-line stub, unused)

### Phase 2: Create UI System (2-3 hours)

- [ ] Create `src/ui/theme.lua`
- [ ] Create `src/ui/Button.lua`
- [ ] Create `src/ui/Layout.lua`
- [ ] Create `src/ui/UIManager.lua`
- [ ] Migrate `states/menu/menu.lua` to use new UI
- [ ] Migrate `states/menu/newGame.lua`
- [ ] Migrate `states/menu/loadSave.lua`

### Phase 3: Service Architecture (2-3 hours)

- [ ] Create `src/core/services.lua` (Service Locator)
- [ ] Create `src/core/event_bus.lua`
- [ ] Create `src/core/input_manager.lua`
- [ ] Update `game.lua` to use Services

---

## Section 1: Menus and UI Problems

### The Core Problem: Code Duplication

The `drawButtons()` function is copy-pasted in 4 files with 400+ lines of identical code:

| File | Lines | Status |
|------|-------|--------|
| `states/menu/menu.lua` | 536-601 | Primary menu |
| `states/menu/menu_helper.lua` | 103-162 | Unused helper |
| `states/menu/newGame.lua` | 79-163 | State selector |
| `states/menu/loadSave.lua` | 80-142 | Save loader |

### Hardcoded Values (Examples)

```lua
-- These appear in multiple files:
local button_height = 64
local button_width = ww * (1/3)
local margin = 16
local color = {80, 80, 100, 255}
local textColor = {0, 0, 0, 255}
local hoverColor = {160, 160, 200, 255}
```

### Solution: New UI System

Create `src/ui/` with these files:

**theme.lua** - Centralized styling:
```lua
local Theme = {}
Theme.default = {
    colors = {
        button = {
            normal = {80/255, 80/255, 100/255, 1},
            hovered = {160/255, 160/255, 200/255, 1},
        },
        text = {
            normal = {0, 0, 0, 1},
            hovered = {1, 1, 1, 1},
        },
    },
    dimensions = {
        button = {height = 64, widthRatio = 1/3, margin = 16},
    },
}
return Theme
```

**Button.lua** - Reusable component:
```lua
local Button = {}
Button.__index = Button

function Button:new(config)
    local btn = setmetatable({}, self)
    btn.text = config.text
    btn.onClick = config.onClick
    btn.x, btn.y = 0, 0
    btn.width = config.width or love.graphics.getWidth() * (1/3)
    btn.height = config.height or 64
    btn.isHovered = false
    return btn
end

function Button:update(dt)
    local mx, my = love.mouse.getPosition()
    self.isHovered = mx > self.x and mx < self.x + self.width and
                     my > self.y and my < self.y + self.height
    if self.isHovered and love.mouse.isDown(1) then
        self:onClick()
    end
end

function Button:draw()
    -- Use Theme colors
end

return Button
```

### Files to Delete After Migration

- `states/menu/menu_helper.lua` - Functions absorbed by new system
- `states/menu/menu_scratch.lua` - Empty
- `ui objects/gui.lua` - Abandoned stub

### Files to Evaluate

- `states/menu/fanfic.lua` - Text input, currently disabled
- `states/menu/gravatar.lua` - Avatar display, currently disabled

---

## Section 2: Game State Cruft

### Duplicate Files to Consolidate

| Keep | Delete |
|------|--------|
| `src/core/constants.lua` | `src/constants.lua` |
| `src/core/dependencies.lua` | `src/dependencies.lua` |
| `src/core/logging.lua` | `src/logging.lua` |
| `src/utils/particles/` | `src/particles/` |

After deletion, update `src/dependencies.lua` line 18:
```lua
require 'src/core/constants'  -- was 'src/constants'
```

### The "raint" Problem

Mystery debug variable appears 100+ times. Action by category:

**Delete (commented code):**
- `main.lua:80-81, 105, 246`
- `objects/player.lua:110-128`
- `objects/item.lua:38`
- `objects/zombie.lua:74`

**Rename to meaningful names:**
| File | Current | Rename To |
|------|---------|-----------|
| `tiles/tlm.lua:826-853` | `raint` | `tileTypeIndex` |
| `states/wireArt/wireArt.lua` | `raintor` | `twistCount` |
| `states/computer/*.lua` | `raintar` | `avatarImage` |

### Magic Numbers to Extract

Create `src/core/config.lua`:
```lua
local Config = {}

Config.physics = {
    gravity = 500,           -- was hardcoded in world_physics.lua:18
    max_velocity = 300,      -- was hardcoded in world_physics.lua:24
    jump_velocity = -200,    -- was hardcoded in world_physics.lua:33
}

Config.tiles = {
    size = 32,               -- was hardcoded in tlm.lua
    chunk_size = 16,
    atlas_size = 512,
}

Config.window = {
    width = 1340,            -- was hardcoded in main.lua:87
    height = 900,            -- was hardcoded in main.lua:88
}

return Config
```

### Dead Code in main.lua

**Lines 135-145:** `debug_ui` struct never called - DELETE
**Lines 148-169:** Delta-time averaging never used - DELETE or implement properly
**Lines 222-254:** Commented print statements - DELETE

Target: Reduce main.lua from 334 lines to ~150 lines.

### Scratch Files to Delete

```
states/menu/menu_scratch.lua
states/generate/player_scratch.lua
states/earth2/player_scratch.lua
states/computer/computer-scratch1.lua
states/dialogue/scratch.lua
states/kitchen/kitchen-scratch.lua
tiles/chunk scratch.lua
tiles/map scratch.raint
tiles/newMap scratch.lua
spheres_scratch.lua
assets/character/avatars/scratch.lua
```

---

## Section 3: Modularization

### State Organization

Current: 70+ states loaded ad-hoc in `game.lua`

Proposed categories:

```lua
StateRegistry.Categories = {
    core = {
        "menu", "pause", "options", "newGame", "loadSave", "signin"
    },
    game_modes = {
        "generate", "synth", "kitchen", "dinner", "space1",
        "computer", "drivingSim", "asciiGame", "infiniteRunner"
    },
    ui = {
        "dialogue", "inventory", "vapeStatus", "uiTest"
    },
    tools = {
        "editor", "characterCreation", "characterCustomizer",
        "wireArt", "face", "quadtree", "tiledZoom"
    },
    experimental = {
        "bizzaro", "livelove", "orbital", "mts", "prog2", "pro"
    },
}
```

### Service Locator Pattern

Create `src/core/services.lua`:
```lua
local Services = {_services = {}}

function Services:register(name, service)
    self._services[name] = service
    _G[name] = service  -- Backward compatibility
    return service
end

function Services:get(name)
    return self._services[name]
end

function Services:initialize()
    self:register('renderer', require('tools/renderer'):create())
    self:register('gameloop', require('tools/gameloop'):create())
    self:register('camera', require('tools/camera'))
    self:register('asm', require('tools/asm'))
    self:register('tlm', require('tiles/tlm'))
end

return Services
```

### Split tlm.lua (1039 lines)

Current monolith handles: tile generation, chunks, map loading, collision, drawing, minimap

Split into:
```
tiles/
  tlm.lua              # Facade (< 100 lines)
  tile_generator.lua   # Chunk generation
  tile_renderer.lua    # Drawing logic
  tile_collision.lua   # Collision detection
  map_loader.lua       # Tiled map loading
  minimap.lua          # Minimap rendering
```

### Missing Core Systems to Create

| System | File | Purpose |
|--------|------|---------|
| Event Bus | `src/core/event_bus.lua` | Decouple state communication |
| Input Manager | `src/core/input_manager.lua` | Action-based input mapping |
| Audio Manager | `src/core/audio_manager.lua` | Centralized audio control |
| Asset Manager | `src/core/asset_manager.lua` | O(1) lookup (current asm.lua is O(n)) |
| Config Manager | `src/core/config_manager.lua` | Save/load configuration |

---

## Target Directory Structure

```
invadors/
  main.lua                    # Minimal bootstrap
  conf.lua                    # LOVE config
  game.lua                    # Simplified, uses Services

  src/
    core/
      services.lua            # Service locator
      dependencies.lua        # Core requires
      constants.lua           # Legacy constants
      config.lua              # New config system
      event_bus.lua           # Event system
      input_manager.lua       # Input handling
      state_registry.lua      # State organization

    ui/
      theme.lua               # Styling
      Button.lua              # Button component
      Layout.lua              # Layout helpers
      UIManager.lua           # UI management

    entities/
      entity.lua              # Base entity
      components/             # Reusable components

    utils/
      particles/              # Particle systems

  states/
    core/                     # menu/, pause.lua, options/
    game_modes/               # generate/, synth/, kitchen/
    ui/                       # dialogue/, inventory/
    tools/                    # editor/, characterCreation/
    experimental/             # bizzaro/, livelove/

  tiles/
    tlm.lua                   # Facade
    tile_generator.lua
    tile_renderer.lua
    tile_collision.lua
    map_loader.lua
```

---

## Verification Steps

After each change:

1. **Run game:** `love .`
2. **Check menu:** All buttons clickable
3. **Test transition:** Menu -> New Game -> any state
4. **Check console:** No new errors
5. **Visual check:** No rendering issues

---

## Risk Assessment

| Task | Risk | Notes |
|------|------|-------|
| Delete duplicate files | LOW | Just remove redundant copies |
| Delete scratch files | VERY LOW | Unused |
| Create UI system | MEDIUM | New code, test thoroughly |
| Migrate menus | MEDIUM | Touch working code |
| Service Locator | LOW | Additive, bridges to globals |
| Split tlm.lua | MEDIUM | Large refactor, test tiles |
| Clean main.lua | LOW | Remove dead code only |

---

## Git Strategy

```bash
# Create feature branch
git checkout -b refactor/codebase-cleanup

# Commit after each phase
git add . && git commit -m "Phase 1: Remove duplicate files"
git add . && git commit -m "Phase 2: Create UI system"
# etc.

# Tag stable points
git tag cleanup-phase-1-complete
```

---

## Resume Command

To continue this work in a new session, reference this document:

```
Read docs/CODEBASE_REFACTORING_PLAN.md and help me implement the refactoring plan starting with Phase 1.
```
