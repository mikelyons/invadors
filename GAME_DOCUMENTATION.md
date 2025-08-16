# Invadors Game Documentation

This document provides an overview of the "Invadors" game project, its architecture, core systems, and a to-do list for future development.

## 1. Project Overview

"Invadors" is a game developed using the [LÖVE](https://love2d.org/) framework. It features a highly modular architecture built around a state machine, allowing for various independent game modes, mini-games, and UI screens. The project is composed of a core engine, numerous game states, and a collection of libraries and tools.

The game boots from `main.lua`, which sets up the window and global settings. It then loads all dependencies via `src/core/dependencies.lua` and initializes the main `Game` object from `game.lua`. The `Game` object manages the active game state and delegates updates, drawing, and input handling.

## 2. Core Systems

The game relies on a set of core systems to function.

### 2.1. State Management (`stateful`)

The game uses the `stateful` library, integrated into the main `Game` class, to manage game states.

*   **State Definition**: Each game state is a Lua module (e.g., `states/menu/menu.lua`) that returns a table with functions like `enteredState`, `exitedState`, `update`, `draw`, `keypressed`, etc.
*   **State Loading**: States are loaded in `game.lua` using the custom `loadStateFile` and `loadStateFolder` helper functions.
*   **State Transition**: The `Game:gotoState(stateName)` function is used to switch between different game states. The game can be configured to boot directly into a specific state using the `BOOT_TO_STATE` variable in `game.lua`.

### 2.2. Rendering (`tools/renderer.lua`)

A custom `Renderer` class is responsible for drawing objects. The main `love.draw` function calls `renderer:draw()`. This system appears to be designed for layered rendering, although the implementation details need further investigation.

### 2.3. Game Loop (`tools/gameloop.lua` & `main.lua`)

The game loop is managed by a combination of the standard LÖVE callbacks (`love.update`, `love.draw`) and a custom `GameLoop` class. `main.lua` contains a fixed-timestep implementation to ensure consistent game speed.

### 2.4. Input Handling

Input events (`keypressed`, `mousepressed`, etc.) are captured in `main.lua` and delegated to the currently active game state via the `Game` object. This allows each state to define its own input handling logic.

### 2.5. Asset Management (`tools/asm.lua`)

The `asm` (Asset Manager) tool is responsible for loading and managing game assets.

### 2.6. Tile & Object Management (`tiles/tlm.lua`, `tools/obm.lua`)

The project includes a `tlm` (Tile Manager) and an `obm` (Object Manager), suggesting a tile-based world structure. These managers are likely responsible for loading map data and managing game objects within the world.

### 2.7. Camera (`tools/camera.lua`)

A dedicated camera tool is used to manage the game's viewport. It supports setting and unsetting the camera's position, allowing for scrolling and zooming independent of the game world's coordinates.

## 3. Game States

The project contains a vast number of game states, each representing a different part of the game. Here is a partial list:

*   **Core States**: `splash`, `menu`, `options`, `pause`, `credits`
*   **Mini-Games**: `asciiGame`, `brawl`, `cardGame`, `drivingSim`, `hexhacker`, `infiniteRunner`, `oregonTrail`, `space1`, `synth`
*   **World/Map States**: `worldMap`, `cityMap`, `countryMap`, `planetaryMap`, `zeldaWorld`, `tiledZoom`
*   **Character & UI**: `characterCreation`, `characterCustomizer`, `inventory`, `vapeStatus`, `npcProfile`, `dialogue`
*   - **Development/Test States**: `_template`, `generate`, `uiTest`, `editor`, `livelove`, `vapeStatus`

## 4. To-Do List & Next Steps

This section outlines potential areas for improvement and future work based on code comments and analysis.

### General & Core Systems

*   **[ ] Documentation**: Flesh out this documentation with more detail on each system. Add code comments where logic is unclear.
*   **[ ] Refactor `main.lua`**: The `love.draw` function in `main.lua` has a lot of debug code. This should be moved to a dedicated debug overlay/module.
*   **[ ] Fix Timestep**: The comment in `main.lua` mentions stuttering issues. Investigate and fully implement the fixed timestep from the provided link (`https://gafferongames.com/post/fix_your_timestep/`).
*   **[ ] Finalize Renderer**: The renderer system seems incomplete. Define a clear layer-based rendering system.
*   **[ ] Debug Tools**:
    *   The `lovebird` debugger is mentioned but not fully integrated. Decide if it should be used and implement it properly.
    *   The FPS counter is disabled. Fix and enable it behind a debug flag.
    *   The `lldebugger` for VSCode is included but noted as "not working on mac". Investigate or remove.
*   **[ ] Networking**: The code mentions tutorials for `enet`. If multiplayer is a goal, this system needs to be designed and implemented.
*   **[ ] Save/Load System**: A robust save/load system is needed for game progress, especially for the `worldMap` and character-related states. The `loadSave.lua` state is a starting point.
*   **[ ] Consolidate `main.lua` files**: There are multiple `main.lua` files in subdirectories. Consolidate them or clarify their purpose to avoid confusion.

### Game States

*   **`_template`**:
    *   **[ ]** Improve the template with more boilerplate and instructions for creating new states.
*   **`worldMap`**:
    *   **[ ]** Implement the `pois.lua` (Points of Interest) functionality. Currently, it checks for collision but needs triggers for interactions.
    *   **[ ]** Connect the `worldMap` to other states (e.g., entering a town transitions to the `cityMap` state).
*   **`generate`**:
    *   **[ ]** The comments in `main.lua` suggest drawing issues with this state. Investigate and fix why rendering seems to hang or be delayed.
*   **`characterCreation` / `characterCustomizer`**:
    *   **[ ]** Finalize the UI and logic for character creation.
    *   **[ ]** Ensure the created character data can be saved and loaded.
*   **`vapeStatus`**:
    *   **[ ]** The name suggests a status screen. It's currently a simple demo. Implement it to show actual player stats.
*   **`livelove`**:
    *   **[ ]** This appears to be a live-coding environment. Document its features and how to use it for development.
*   **`kitchen`**:
    *   **[ ]** This state seems to be related to items. It needs to be integrated with the inventory system.
*   **`dialogue`**:
    *   **[ ]** Expand the dialogue system. It currently has a basic structure but needs a more robust way to handle conversations, branching, and events. 