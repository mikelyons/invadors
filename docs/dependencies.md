# Dependencies Documentation

## Core Dependencies

### Love2D Engine
- **Version**: 0.10.2+ (tested with 0.10.2 and 11.3)
- **Purpose**: Main game engine
- **Location**: External installation required
- **Documentation**: https://love2d.org/

### Third-Party Libraries

#### Middleclass
- **Location**: `lib/middleclass/`
- **Purpose**: Object-oriented programming support
- **Usage**: Provides Class functionality for OOP patterns
- **Documentation**: https://github.com/kikito/middleclass

#### Stateful
- **Location**: `lib/stateful/`
- **Purpose**: State machine implementation
- **Usage**: Manages game state transitions
- **Documentation**: https://github.com/kikito/stateful.lua

#### Denver
- **Location**: `lib/denver.lua`
- **Purpose**: Additional utility functions
- **Usage**: Provides helper functions for game development

### Development Dependencies

#### Debug Libraries
- **lovedebug**: Debug utilities for Love2D
- **ProFi**: Performance profiling (commented out)
- **lldebugger**: Debugger for development

#### Asset Management
- **asm**: Asset manager (`tools/asm.lua`)
- **tlm**: Tile manager (`tiles/tlm.lua`)
- **obm**: Object manager (`tools/obm.lua`)

#### Rendering & Game Loop
- **Renderer**: Custom renderer (`tools/renderer.lua`)
- **GameLoop**: Custom game loop (`tools/gameloop.lua`)
- **Camera**: Camera system (`tools/camera.lua`)

## Optional Dependencies (Under Consideration)

### Libraries
- **turtle.lua**: Drawing library
- **lua-namegen**: Name generation
- **GifCat**: GIF writing capabilities
- **strong**: Ruby string methods for Lua

### Tools
- **pixelatorapp**: Pixel art tool
- **love-fuser**: Nightly builds
- **moonshine**: Post-processing effects

## Installation Notes

### Windows
1. Install Love2D 0.10.2 or 11.3
2. Clone the repository
3. Use provided run scripts (`run1.bat`, `run2.bat`, `run3.bat`)

### MacOS
1. Install Love2D 0.10.2 or 11.3
2. Clone the repository
3. Use provided run scripts (`run.command`, `run2.command`)

## Version Compatibility

### Love2D Versions
- **0.10.2**: Primary development version
- **11.3**: Tested and compatible
- **0.9.0+**: Minimum required version

### Lua Versions
- **LuaJIT**: Recommended for performance
- **Standard Lua**: Compatible but slower

## Troubleshooting

### Common Issues
1. **Missing Love2D**: Ensure Love2D is installed and in PATH
2. **Library Errors**: Check that all lib/ files are present
3. **Asset Loading**: Verify asset paths and file existence
4. **State Loading**: Check state registration in game.lua

### Debug Mode
Enable debug mode by running with "debug" argument:
```bash
love . debug
``` 