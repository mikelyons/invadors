# Build and Run Documentation

## Overview

The project includes platform-specific scripts for running the game with different Love2D versions and configurations.

## Available Scripts

### Windows Scripts

#### run1.bat
- **Love2D Version**: 10.2
- **Purpose**: Standard game execution
- **Usage**: Double-click or run from command line
- **Features**: Basic game launch

#### run2.bat
- **Love2D Version**: 11.3
- **Purpose**: Latest Love2D version testing
- **Usage**: Double-click or run from command line
- **Features**: Testing compatibility with newer Love2D

#### run3.bat
- **Love2D Version**: 10.2
- **Purpose**: Development with color terminal logging
- **Usage**: Run from command line for debugging
- **Features**: 
  - Color terminal output
  - Enhanced logging
  - Debug information display
  - Windows-specific console features

### MacOS Scripts

#### run.command
- **Love2D Version**: 10.2
- **Purpose**: Standard game execution on MacOS
- **Usage**: Double-click or run from terminal
- **Features**: Basic game launch

#### run2.command
- **Love2D Version**: 11.3
- **Purpose**: Latest Love2D version testing on MacOS
- **Usage**: Double-click or run from terminal
- **Features**: Testing compatibility with newer Love2D

## Manual Execution

### Command Line
```bash
# Windows
love .                    # Uses default Love2D version
love . debug              # Runs with debug argument

# MacOS
love .                    # Uses default Love2D version
love . debug              # Runs with debug argument
```

### Debug Mode
Running with the "debug" argument enables additional debugging features:
- Enhanced logging
- Debug console
- Performance monitoring
- Error reporting

## Script Contents

### Windows Scripts
```batch
@echo off
REM run1.bat - Love2D 10.2
"C:\Program Files\LOVE\love.exe" .

REM run2.bat - Love2D 11.3
"C:\Program Files\LOVE\love.exe" .

REM run3.bat - Love2D 10.2 with color logging
@echo on
color 0A
"C:\Program Files\LOVE\love.exe" .
pause
```

### MacOS Scripts
```bash
#!/bin/bash
# run.command - Love2D 10.2
/Applications/love.app/Contents/MacOS/love .

# run2.command - Love2D 11.3
/Applications/love.app/Contents/MacOS/love .
```

## Configuration

### Love2D Installation Paths
The scripts assume standard Love2D installation paths:

**Windows:**
- Love2D 10.2: `C:\Program Files\LOVE\love.exe`
- Love2D 11.3: `C:\Program Files\LOVE\love.exe`

**MacOS:**
- Love2D 10.2: `/Applications/love.app/Contents/MacOS/love`
- Love2D 11.3: `/Applications/love.app/Contents/MacOS/love`

### Custom Paths
If Love2D is installed in a different location, update the scripts accordingly:

1. Locate your Love2D installation
2. Update the path in the appropriate script
3. Test the script to ensure it works

## Troubleshooting

### Common Issues

#### Script Not Found
- Ensure Love2D is installed
- Check installation path in script
- Verify script has correct permissions

#### Game Won't Start
- Check Love2D version compatibility
- Verify all dependencies are present
- Check console for error messages

#### Debug Mode Issues
- Ensure debug argument is passed correctly
- Check debug flags in constants.lua
- Verify console supports color output

### Platform-Specific Issues

#### Windows
- **Color Terminal**: May not work in all terminals
- **Path Issues**: Use correct Love2D installation path
- **Permissions**: Run as administrator if needed

#### MacOS
- **Permissions**: Make scripts executable (`chmod +x run.command`)
- **Path Issues**: Verify Love2D installation location
- **Terminal**: Use Terminal.app for best compatibility

## Development Workflow

### Recommended Setup
1. **Primary Development**: Use run1.bat (Windows) or run.command (MacOS)
2. **Testing**: Use run2.bat/run2.command for newer Love2D versions
3. **Debugging**: Use run3.bat for enhanced logging

### Version Testing
- Test with multiple Love2D versions
- Verify compatibility across platforms
- Document version-specific issues

### Continuous Integration
Consider adding automated testing:
- Build verification
- Version compatibility testing
- Platform-specific testing

## Future Improvements

### Planned Enhancements
- [ ] Automated script generation
- [ ] Cross-platform compatibility
- [ ] Version detection
- [ ] Automated testing
- [ ] Build automation
- [ ] Deployment scripts

### Script Improvements
- [ ] Better error handling
- [ ] Version checking
- [ ] Automatic path detection
- [ ] Configuration files
- [ ] Logging improvements 