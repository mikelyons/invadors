# Version Management Guide

This document explains how version management works in the Invadors project and when to bump version numbers.

## Centralized Version System

All version information is now centralized in `src/core/version.lua`. This ensures consistency across the entire project.

### Version Format

The project uses a **4-part version number**: `MAJOR.MINOR.PATCH.BUILD`

- **MAJOR**: Breaking changes, major feature releases
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, minor improvements
- **BUILD**: Development builds, internal tracking

### Current Version: 0.4.7.3

## Files That Use Version Information

1. **`src/core/version.lua`** - Central version definition
2. **`conf.lua`** - Game version and LÖVE version
3. **`main.lua`** - Game metadata
4. **`highscore.lua`** - Save file version compatibility
5. **`docs/CHANGELOG.md`** - Release notes and change tracking

## When to Bump Versions

### MAJOR Version (0.x.x.x → 1.0.0.0)
- Breaking changes to save file format
- Major architectural changes
- Incompatible API changes
- Complete rewrite of major systems

### MINOR Version (0.4.x.x → 0.5.0.0)
- New game states or major features
- Significant new gameplay mechanics
- Large content additions
- Major UI/UX changes

### PATCH Version (0.4.7.x → 0.4.8.0)
- New features (dinner simulation, new game modes)
- Bug fixes
- Performance improvements
- Minor content additions

### BUILD Version (0.4.7.2 → 0.4.7.3)
- Development builds
- Small fixes and improvements
- Documentation updates
- Asset additions

## How to Update Versions

### 1. Update Central Version File
```lua
-- In src/core/version.lua
GAME_VERSION = "0.4.7.4"  -- Bump appropriate part
SAVE_VERSION = "0.4.7.4"  -- Usually matches GAME_VERSION
```

### 2. Update Changelog
```markdown
## [0.4.7.4] - YYYY-MM-DD

### Added
- New feature description

### Fixed
- Bug fix description
```

### 3. Update Version History
```lua
-- In src/core/version.lua
CHANGELOG = {
  ["0.4.7.4"] = {
    date = "2025-08-16",
    changes = {
      "New feature description",
      "Bug fix description"
    }
  },
  -- ... existing versions
}
```

## Automatic Version Features

### Build Information
- **Build Date**: Automatically generated when game loads
- **Build Time**: Automatically generated when game loads
- **Snap Date**: Development build identifier (m08d16 format)

### Version Functions
```lua
local Version = require('src/core/version')

-- Get current game version
local version = Version:getGameVersion()

-- Get full version with snap date
local fullVersion = Version:getFullVersion()

-- Get build information
local buildInfo = Version:getBuildInfo()

-- Get changelog for specific version
local changelog = Version:getChangelog("0.4.7.3")
```

## Save File Compatibility

The `SAVE_VERSION` in `src/core/version.lua` determines save file compatibility:

- **Same version**: Full compatibility
- **Different MAJOR/MINOR**: May require migration
- **Different PATCH/BUILD**: Usually compatible

## Release Process

1. **Development**: Use BUILD version bumps
2. **Feature Complete**: Bump PATCH version
3. **Release**: Update changelog and tag release
4. **Major Release**: Bump MINOR or MAJOR version

## Examples

### Adding Dinner Simulation (PATCH bump)
- **Before**: 0.4.7.2
- **After**: 0.4.7.3
- **Reason**: New game state, significant feature

### Bug Fix (BUILD bump)
- **Before**: 0.4.7.3
- **After**: 0.4.7.4
- **Reason**: Minor fix, no new features

### New Game Engine (MINOR bump)
- **Before**: 0.4.7.3
- **After**: 0.5.0.0
- **Reason**: Major new system, significant changes

### Breaking Changes (MAJOR bump)
- **Before**: 0.4.7.3
- **After**: 1.0.0.0
- **Reason**: Incompatible save format, major rewrite



