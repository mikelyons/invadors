# Invadors - Project Documentation

## Project Overview
Invadors is a Love2D platformer game prototype developed for learning game programming concepts. The project uses a state-driven architecture where different game modes and features are implemented as separate states.

## Architecture

### Core Structure
```
invadors/
├── src/                    # Core game source code
│   ├── core/              # Essential game systems
│   ├── states/            # Game states (modes/features)
│   ├── utils/             # Utility functions and helpers
│   └── assets/            # Game assets (organized by type)
├── lib/                   # Third-party libraries
├── tools/                 # Development tools and utilities
├── docs/                  # Documentation
└── experiments/           # Experimental code and prototypes
```

### State Management
The game uses a state machine pattern where:
- Each state represents a different game mode or feature
- States are loaded dynamically during initialization
- States can transition between each other
- Each state implements a consistent interface (init, update, draw, etc.)

### Key Components
- **Game Class**: Main game controller using Stateful for state management
- **States**: Individual game modes and features
- **Asset Management**: Centralized asset loading and management
- **Logging**: Comprehensive logging system for debugging
- **Constants**: Global configuration and constants

## Development Guidelines

### File Naming
- Use snake_case for all Lua files
- Use descriptive names that indicate purpose
- Group related files in appropriate directories

### Code Organization
- Keep states self-contained
- Use consistent module patterns
- Document complex logic with comments
- Separate concerns (rendering, logic, input handling)
- Use instance variables (`self.variable`) for values that persist across methods
- Avoid local variables for values needed in multiple functions

### Asset Management
- Organize assets by type (sprites, audio, maps, etc.)
- Use consistent naming conventions
- Document asset usage and dependencies

### Error Handling
- Use defensive programming with nil checks for external references
- Implement safe resource loading with fallbacks
- Wrap critical functions in pcall for error handling
- Provide fallback rendering when errors occur
- Log errors to console for debugging

## State Development
To add a new state:
1. Create a new directory in `src/states/`
2. Implement the state interface (init, update, draw, etc.)
3. Register the state in `game.lua`
4. Document the state's purpose and functionality
5. Implement proper error handling and defensive programming
6. Use instance variables for values that persist across methods
7. Add fallback rendering for error conditions

## Recent Improvements
- **Bug Fixes**: Fixed multiple state crashes and silent failures
- **Error Handling**: Implemented comprehensive error handling across all states
- **Text Input**: Fixed text input system functionality
- **Resource Safety**: Added safe resource loading with fallbacks
- **Variable Scope**: Fixed screen dimension scope issues in Computer state
- **Documentation**: Created comprehensive bug fix documentation

## Build and Run
The project includes platform-specific run scripts:
- Windows: `run1.bat`, `run2.bat`, `run3.bat`
- MacOS: `run.command`, `run2.command`

## Dependencies
- Love2D 0.10.2+ (tested with 0.10.2 and 11.3)
- Middleclass (for OOP)
- Stateful (for state management)
- Denver (for additional utilities) 