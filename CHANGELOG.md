## Unreleased
## 0.4.7.3 (Jan 1, 2023)
### Added
### Changed
### Removed
### Fixed

## Unreleased

## 0.4.7.2 (Nov 11, 2023)

### Added
- lots of gamestates
  states/_template/_addState.lua
  states/asciiGame/
  states/computer/wood.png
  states/face/
  states/options/
  states/quadtree/
  states/synth/effects.lua
  states/synth/love-tunes/
  states/tiledZoom/
  states/uiTest/
  states/wireArt/wire.lua
  states/yard/
- lots of assets
- 

### Changed
- many things changed in this update

## 0.4.7.1 (~Jan 1, 2023)

### Added

- Many QoL improvements
- The computer interface
- A ui panel object editor (WIP)

### Changed

- Development workflow outline document to come

### Removed

- many features are switched off until we can have separate build streams

### Fixed

## 0.4.7 (April 18, 2022 --  Dec 20, 2022)

### Added

- can switch between generated chunks and loading a custom map
- lots of assets
- imagesequence video frames and support
  - imageSequence files need compression)
- bundle love executables for run.bats with the game
- new map 'bedroom'
- new constants
- lots of files for tracking things like:
  - colors
  - hud
  - videostate
  - and more!
- QoL improvements

### Changed

- Player, world and physics updated to account for different worldtypes
- 3 run.bat files for launching with different versions

### Removed

- level1.lua extraneous file
- lots of extraneous comments

### Fixed

- inventory now snapps to camera position (and scale sorta)
- chunk tile collisions work (except on the right side between chunks)

#### Known Issues
- right side generate collission with tile scape chunks
- lots of menu and other problems
- long span between commits means this may ahve a quick update to follow

## 0.4.6 (March 18, 2022)

### Added

- chunk generation

### Changed
### Removed
### Fixed

- Several menu bugs


## 0.4.5 (February 21, 2022)

### Added
	- New game Menu
	- Load game Menu
	- save directory scanning
	- gamestate directory scanning
	- Press Start screen
	- game state template

## 0.4.4 (February 12, 2022)

### Added

- Coin Items
- Beginning inventory UI
- Various libraries
- textbox basic functionality
- procedural top-down level generation
- tiled level gen and interp
- batch file runner with colored console logging
- smtp and sockets libraries
- synth noise loops, white, pink, ufo, generic
- some assets for character
- some splash texts
- some debug helpers

### Fixed

- UI point and click menu is working! (this is HUGE was a blocker for a long time)
- Multi-threading for sounds to not block the main thread
- Dependency and Module loading
- Game state management now has seperate loaders for folders or files, this may change again to be folders only in future

## 0.4.3 (December 9, 2020)

### Added

- Synthesized waveform sound effects / music with Denver
- `run.bat` for managing LOVE version
- socket request for Gravatar
- **New Logo!**
- lots of new assets
- and more ...

### Changed

- massive revamp of particle system
- reorganized particle assets
- rebuilt menus

## 0.4.2 (December 9, 2020)

### Added
- `misc` folder
- added icon musroom
- current state of the project after enormous cleanup
- too many things were lost in the great reorg to list

### Changed
- new format for changelog?

## 0.4 (April 5, 2017)

### Added
- finlandian work

### Changed

* Remove Player shader and add gaussian blur shader to background based on movement
* Slow Player movement to 4

## 0.3 (April 4, 2017)

### Added

* First pass at shaders, filmgrain box and character

## 0.2 (April 4, 2017)

### Added

* Initial public release
