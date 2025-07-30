# Development Guidelines

## Code Style and Standards

### File Naming
- Use **snake_case** for all Lua files and directories
- Use descriptive names that indicate purpose
- Group related files in appropriate directories
- Examples:
  - `player_controller.lua`
  - `asset_manager.lua`
  - `ui_elements/`

### Code Formatting
- Use 2 spaces for indentation
- Use consistent spacing around operators
- Add spaces after commas in function calls
- Use meaningful variable and function names
- Keep lines under 80 characters when possible

### Comments and Documentation
```lua
--[[
  file_name.lua
  
  Brief description of what this file does
  Author: Name
  Date: YYYY-MM-DD
]]

-- Function description
function functionName(param1, param2)
  -- Inline comment explaining complex logic
  local result = param1 + param2
  return result
end
```

## Module Patterns

### Standard Module Pattern
```lua
local ModuleName = {}

function ModuleName.new()
  local self = {}
  -- Initialize module
  return self
end

function ModuleName:someMethod()
  -- Method implementation
end

return ModuleName
```

### Class Pattern (using Middleclass)
```lua
local ClassName = Class('ClassName')

function ClassName:initialize(param1, param2)
  self.param1 = param1
  self.param2 = param2
end

function ClassName:someMethod()
  -- Method implementation
end

return ClassName
```

## State Development

### State Template
```lua
local StateName = Class('StateName'):include(Stateful)

function StateName:initialize()
  -- State initialization
end

function StateName:enter()
  -- Called when entering this state
end

function StateName:exit()
  -- Called when leaving this state
  -- Clean up resources here
end

function StateName:update(dt)
  -- Game logic update
end

function StateName:draw()
  -- Rendering
end

function StateName:keypressed(key, code)
  -- Handle key events
end

function StateName:mousepressed(x, y, button, istouch)
  -- Handle mouse events
end

return StateName
```

## Asset Management

### Asset Loading
- Use the asset manifest for all asset references
- Implement proper error handling for missing assets
- Use appropriate asset types (Image, Audio, Font)
- Clean up assets when no longer needed

### Asset Organization
```
assets/
├── images/
│   ├── ui/
│   ├── characters/
│   ├── backgrounds/
│   └── effects/
├── audio/
│   ├── music/
│   └── sounds/
├── fonts/
└── data/
```

## Error Handling

### Defensive Programming
```lua
-- Check for nil values
if player and player.position then
  -- Safe to use player.position
end

-- Validate function parameters
function someFunction(param1, param2)
  assert(type(param1) == "string", "param1 must be a string")
  assert(type(param2) == "number", "param2 must be a number")
  -- Function implementation
end
```

### Debug Logging
```lua
if DEBUG_LOGGING_ON then
  print("Debug: " .. message)
end

-- Use PrintColor for colored output
PrintColor("Error message", "red")
PrintColor("Success message", "green")
```

## Performance Guidelines

### Memory Management
- Avoid creating objects in update loops
- Use object pooling for frequently created/destroyed objects
- Clean up resources in state exit() methods
- Monitor memory usage during development

### Rendering Optimization
- Batch similar draw calls
- Use sprite batching when possible
- Minimize texture switching
- Use appropriate blend modes

### Update Optimization
- Avoid expensive operations in update loops
- Use delta time for frame-rate independent movement
- Implement proper collision detection optimization

## Testing and Debugging

### Debug Tools
- Enable debug flags in constants.lua
- Use the debug console for testing
- Implement debug rendering for hitboxes, paths, etc.
- Use profiling tools for performance analysis

### Common Debug Flags
```lua
DEBUG_HITBOX_VIS = true    -- Show hitboxes
DEBUG_GRID_ON = true       -- Show grid
DEBUG_SHOW_FPS = true      -- Show FPS counter
DEBUG_LOGGING_ON = true    -- Enable logging
```

## Version Control

### Commit Messages
- Use clear, descriptive commit messages
- Reference issue numbers when applicable
- Group related changes in single commits
- Use present tense ("Add feature" not "Added feature")

### Branch Strategy
- Use feature branches for new development
- Keep main branch stable
- Test changes before merging
- Document breaking changes

## Documentation

### Code Documentation
- Document complex algorithms
- Explain non-obvious code
- Keep documentation up to date
- Use consistent documentation style

### API Documentation
- Document public functions and methods
- Include parameter descriptions
- Provide usage examples
- Document return values

## Security Considerations

### Input Validation
- Validate all user input
- Sanitize file paths
- Check for malicious data
- Implement proper error handling

### File Operations
- Use safe file paths
- Validate file types
- Implement proper file permissions
- Handle file operation errors

## Platform Considerations

### Cross-Platform Compatibility
- Test on multiple platforms
- Handle platform-specific differences
- Use platform-agnostic APIs when possible
- Document platform requirements

### Performance Differences
- Account for different hardware capabilities
- Implement graceful degradation
- Test on target platforms
- Optimize for common use cases

## Future Considerations

### Scalability
- Design for future expansion
- Use modular architecture
- Plan for asset growth
- Consider performance implications

### Maintainability
- Write self-documenting code
- Use consistent patterns
- Minimize dependencies
- Keep code simple and readable 