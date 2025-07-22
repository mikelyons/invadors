# State Management Documentation

## Overview
The game uses a state machine pattern implemented with the Stateful library. Each state represents a different game mode, screen, or feature.

## State Architecture

### Core Components
- **Game Class**: Main controller that manages state transitions
- **Stateful Library**: Provides state machine functionality
- **State Interface**: Consistent interface all states must implement

### State Interface
All states should implement these methods:
```lua
function StateName:init()
  -- Called when state is first loaded
end

function StateName:enter()
  -- Called when entering this state
end

function StateName:exit()
  -- Called when leaving this state
end

function StateName:update(dt)
  -- Called every frame for game logic
end

function StateName:draw()
  -- Called every frame for rendering
end

function StateName:keypressed(key, code)
  -- Handle key press events
end

function StateName:mousepressed(x, y, button, istouch)
  -- Handle mouse press events
end
```

## Current States

### Core Game States
- **menu**: Main menu system
- **pause**: Pause screen
- **splash**: Splash screen
- **createWorld**: World creation interface

### Game Modes
- **asciiGame**: ASCII-based game mode
- **synth**: Synthesizer/audio game
- **prog2**: Programming game mode
- **generate**: Procedural generation demo
- **space1**: Space-themed game mode
- **worldMap**: World map interface

### UI States
- **uiTest**: UI testing and development
- **dialogue**: Dialogue system
- **computer**: Computer interface
- **book**: Book reading interface
- **inventory**: Inventory management
- **vapeStatus**: Status display

### Experimental States
- **bizzaro**: Experimental game mode
- **kitchen**: Kitchen simulation
- **drivingSim**: Driving simulation
- **livelove**: Live love simulation
- **characterCreation**: Character creation
- **characterCustomizer**: Character customization

### Utility States
- **options**: Game options
- **wireArt**: Wire art generator
- **editor**: Level editor
- **tiledZoom**: Tile zoom utility
- **face**: Face generation
- **quadtree**: Quadtree implementation

## State Loading

### Loading Functions
```lua
-- Load a state that is a single file
loadStateFile('stateName')

-- Load a state that is a folder
loadStateFolder('stateName')

-- Load a menu state file
loadMenuStateFile('stateName')
```

### State Registration
States are registered in `game.lua` during initialization:
```lua
function Game:initialize()
  -- Load various states
  loadStateFile('pause')
  loadStateFolder('menu')
  loadStateFolder('synth')
  -- ... more states
end
```

## State Transitions

### Transitioning Between States
```lua
-- From within a state
self:gotoState('targetState')

-- From the game object
game:gotoState('targetState')
```

### Boot Configuration
States can be set to load directly on startup:
```lua
-- In constants.lua
BOOT_TO_STATE = 'menu'  -- or any other state name
```

## State Development Guidelines

### Creating a New State
1. **Choose Structure**: Decide if your state is a single file or folder
2. **Create Files**: 
   - Single file: `states/stateName.lua`
   - Folder: `states/stateName/stateName.lua`
3. **Implement Interface**: Add required methods (init, update, draw, etc.)
4. **Register State**: Add loading call in `game.lua`
5. **Test**: Verify state loads and transitions correctly

### Best Practices
- Keep states self-contained
- Use consistent naming conventions
- Document complex state logic
- Handle cleanup in exit() method
- Use state-specific constants when needed

### State Communication
- Use global variables sparingly
- Consider using a message system for inter-state communication
- Pass data through state transitions when possible

## Debugging States

### Common Issues
1. **State not loading**: Check registration in game.lua
2. **Missing methods**: Ensure all required interface methods are implemented
3. **Transition errors**: Verify state names match exactly
4. **Memory leaks**: Clean up resources in exit() method

### Debug Tools
- Enable `DEBUG_LOGGING_LOADING` to see state loading
- Use `PrintColor` for colored console output
- Check state transitions with debug logging

## Performance Considerations

### State Loading
- States are loaded at startup, not dynamically
- Large states may impact initial load time
- Consider lazy loading for rarely-used states

### Memory Management
- Clean up resources when exiting states
- Avoid keeping large assets in memory unnecessarily
- Use asset pooling for frequently used resources

## Future Improvements

### Planned Enhancements
- Dynamic state loading
- State persistence
- State-specific configuration
- Better error handling
- State transition animations 