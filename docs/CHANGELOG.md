# Changelog

All notable changes to the Invadors project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.7.3] - 2025-08-16

### Version Management
- **Centralized Version System** - Created `src/core/version.lua` for unified version management
- **Version Bump** - Updated from 0.4.7.2 to 0.4.7.3 for dinner simulation release
- **Build Information** - Added automatic build date/time tracking
- **Changelog Integration** - Version history now tracked in centralized system

## [0.4.7.2] - 2024-12-XX

### Added
- **Vape Status Game State** - New vape status simulation with 'V' key binding
- **Driving Simulation** - New driving simulator with physics and vehicle controls
- **World Map State** - Interactive world map with navigation features
- **Wire Art Enhancements** - Added wrapping, bezier curves, and mesh experiments
- **Asset Management System** - New asset manifest and audio management
- **Particle System** - Blood particles, base particle system, and particle utilities
- **Core Infrastructure** - Constants, dependencies, logging, and development tools
- **Documentation Overhaul** - Comprehensive documentation in docs/ folder

### Enhanced
- **Menu System** - Improved menu with FPS display and single-key shortcuts
- **Computer State** - Fixed sticky note rendering and drag functionality
- **Kitchen State** - Major overhaul with improved gameplay mechanics
- **Inventory System** - Enhanced inventory management and UI
- **Character Creation** - Improved character creation workflow
- **Editor Tools** - Enhanced editor functionality and UI
- **Physics System** - Unified physics system improvements

### Technical Improvements
- **Loading System** - Improved state loading and error handling
- **Logging System** - Enhanced debug logging and development tools
- **Asset Organization** - Better asset management and organization
- **Code Structure** - Improved code organization and modularity
- **Performance** - Various performance optimizations and bug fixes

### Documentation
- **BUGFIX_DOCUMENTATION.md** - Comprehensive bug fix tracking
- **GENERATE_GAME_DOCUMENTATION.md** - Game generation system docs
- **MENU_IMPROVEMENTS_TODO.md** - Menu system improvement plans
- **UNIFIED_PHYSICS_SYSTEM.md** - Physics system documentation
- **Development Guidelines** - Coding standards and best practices
- **State Management** - Game state management documentation

### Added
- **Dinner Simulation Game State** - New first-person dinner table simulation
  - Created `states/dinner/dinner.lua` - Main dinner simulation with guest interactions and food consumption
  - Added drag-and-drop sticky note system for dinner notes
  - Implemented point-and-click food eating mechanics
  - Added guest interaction system with dialogue bubbles
  - Created tooltip system for item descriptions on hover
  - Added real-time stats tracking (hunger, happiness, interactions)
  - Implemented dynamic guest dialogue with random conversations

### Features
- **Food Items**: Pizza (restores hunger), Beer (increases happiness), Broken Beer (dangerous), Mushrooms (magical effects)
- **Guest System**: Three interactive guests (Alice, Bob, Carol) with clickable avatars
- **Environment**: Brown wood paneling background with dinner table
- **Controls**: 'D' key to enter dinner state, mouse interactions, escape to exit

### Modified
- `states/menu/menu.lua` - Added 'D' key binding for dinner state
- `states/states.lua` - Added dinner state loading and key binding
- `game.lua` - Added dinner state folder loading
- `conf.lua` - Updated to use centralized version management
- `main.lua` - Updated to use centralized version management
- `highscore.lua` - Updated to use centralized version management

### Documentation
- `states/dinner/README.md` - Comprehensive documentation of dinner simulation features and controls
- `test_dinner.lua` - Test file for verifying dinner state loading
- `docs/VERSION_MANAGEMENT.md` - Complete guide for version management and release process

### Assets Used
- `assets/items/pizza_0.png` - Pizza food item
- `assets/items/beergreenbottle.png` - Beer drink item
- `assets/items/beerbrokengreen.png` - Broken beer bottle (dangerous)
- `assets/items/SHROOMANDBUSH.png` - Magical mushrooms
- `assets/items/table_4.png` - Dinner table
- `assets/character/avatars/NN32.png` - Guest avatars
- `assets/hand-pointing-1.png` - Mouse cursor

### Technical Details
- Reused existing evilNote system for drag-and-drop functionality
- Implemented simple timer system for guest dialogue (replaced Timer.after with manual timer)
- Added hover detection and tooltip rendering
- First-person point-and-click interaction mechanics
- Real-time stat tracking and updates

---

## Development Phases

### Phase 1: Foundation (Initial Commits)
- Basic game structure and state management
- Menu system and splash screens
- Player physics and basic gameplay
- Asset management and tile loading

### Phase 2: Core Features (2024)
- Multiple game states (computer, kitchen, inventory, etc.)
- Enhanced menu system with shortcuts
- Particle systems and visual effects
- Documentation and code organization
- Physics system improvements

### Phase 3: AI-Assisted Development (2024-2025)
- **Vape Status State** - New simulation game state
- **Driving Simulation** - Physics-based vehicle simulation
- **World Map** - Interactive navigation system
- **Wire Art Enhancements** - Advanced graphics features
- **Dinner Simulation** - First-person dining experience
- **Version Management** - Centralized version control system

### Phase 4: Documentation & Polish (Ongoing)
- Comprehensive documentation in docs/ folder
- Bug fix tracking and resolution
- Code quality improvements
- Performance optimizations
- Development guidelines and standards

---

## Previous Changes

*This changelog tracks changes from version 0.4.7.2 onwards. Earlier development history is preserved in git commits and other documentation files.*
