### Dev Log

##### 12-9-2022

- Top priority - get score-reader working in denver, folderize it with that utility

##### 3-17-2022 

trying to fix collisions to they work again after all the chunk tile stuff

### Versions

0.4.5

- Add The Herobrine
-  

## Priorities

Chunk loading unloading 
- https://www.youtube.com/watch?v=uE36MVjB5-8
- https://github.com/NesiAwesomeneess/ChunkLoader-CSharp

image sequencing - https://github.com/YoungNeer/clove

### Scratch


Lua Reflection
https://stackoverflow.com/questions/2620377/lua-reflection-get-list-of-functions-fields-on-an-object

##### Renderlayers: Top to Bottom

main draw outside camera

Game
draw: score

generate 
camera open
  Renderer
    5: menu background
    4:
    3: player, zombie
    2: earth2/main/generate, solid tiles
    1: tlm drawchunk 
camera close

Pre processing and metaprogramming - http://luapreprocess.refreezed.com/docs/
- https://flamendless.github.io/devblog-1/

lovelymoon
https://love2d.org/forums/viewtopic.php?f=5&t=38702&p=111082

chunks
https://github.com/Guthen/Chunk2D


# feature ideas

- Racial damage

-- text to speech : https://gist.github.com/slemonide/625b0309bdf49d1ad4ea189d2892e956
https://www.reddit.com/r/love2d/comments/4185xi/quick_question_typing_effect/

# Automated builds

- https://github.com/nhartland/love-build

# dependency management

- https://gitea.it/1414codeforge/crush
- https://github.com/Alloyed/loverocks

# Original open source libraries

- extract out gravatar.lua and make a public project out of it

# Consideration

love.js - https://kalis.me/building-love2d-games-web-docker/

style guide - https://flamendless.github.io/lua-coding-style-guide/

## tools

Flux animation curve visualized
- https://idbrii.itch.io/lua-fluxvisualized

physics collisions
- https://github.com/a327ex/windfield

Material UI
- https://github.com/flamendless/material-love

# 3d engine
- https://love2d.org/forums/viewtopic.php?f=5&t=86350
- https://love2d.org/forums/viewtopic.php?f=14&t=92041&hilit=raycast
-  another - https://github.com/AndrewMicallef/ss3d

the most fleshed out game I've seen
- https://github.com/hawkthorne

evolution 
- https://github.com/groverburger/marufight

portable executable
- https://github.com/groverburger/luape

.obj files
- https://github.com/karai17/lua-obj

exporting to platforms
- https://github.com/dmoa/love-export

iqm/exm models? - blender
- https://github.com/excessive/iqm-exm

mariokart style levels
- https://github.com/hatninja/Playmat

# video
- https://love2d.org/forums/viewtopic.php?f=5&t=9275
- https://love2d.org/forums/viewtopic.php?f=5&t=10396
- https://love2d.org/forums/viewtopic.php?f=5&t=9275
- https://love2d.org/forums/viewtopic.php?p=79378
- 

bone animation - https://github.com/pfirsich/andross
flux tweening - https://github.com/flamendless/Anagramer/tree/master/modules/flux
slab ui windows - https://github.com/flamendless/Slab

# post processing shaders
- https://github.com/flamendless/moonshine
- https://github.com/veethree/POSTER

pack assets into datafile to hide them - https://github.com/flamendless/love_seal

light and shadows - https://github.com/flamendless/lighter
- https://github.com/flamendless/Luven

imgui - https://github.com/flamendless/love-imgui

vector library - https://github.com/flamendless/brinevector3D
- https://github.com/novemberisms/brinevector

scaling grid for the camera - https://github.com/flamendless/Editgrid

window management / scaling? - https://github.com/flamendless/lovely-windows

webserver serve a web-page - https://github.com/bakpakin/moonmint/wiki/Getting-Started

julia set fractal - https://github.com/novemberisms/julia

markov chain level generation - https://rxi.github.io/level_generation_using_markov_chains.html

threading for synth? - https://github.com/rxi/coil

useful functions - https://github.com/rxi/lume

sync events to bpm of audio track - https://github.com/rxi/lovebpm

hot swap changed files into running love game - https://github.com/rxi/lurker

automate the use of spritebatches - https://github.com/rxi/autobatch

love for DOS - https://github.com/rxi/lovedos

spacial hash? - https://github.com/rxi/shash

delay function calls - https://github.com/rxi/tick

table inspector any value readable - https://github.com/kikito/inspect.lua

pathfinding - https://github.com/CapsAdmin/love2d-flow-field-pathfinding

steamworks - https://github.com/CapsAdmin/luajit-steamworks

testing - https://github.com/Olivine-Labs/busted

shapes - https://github.com/pelevesque/draft

how long ago converter for dates/times - https://github.com/f-person/lua-timeago

drawing geo-data based maps - https://github.com/nekromoff/osmlove

text effects - https://github.com/Papaew/popo

text dialog boxes - https://github.com/smallsco/scribe

### Tiled

 - https://www.youtube.com/watch?v=RyeWjQET0Zk

https://pinetools.com/pixelate-effect-image

## Libs

https://github.com/tanema/light_world.lua

---
for formatting tips in this document: https://guides.github.com/features/mastering-markdown/

or: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

## scratch - TODO

- [x] Player controls
- [x] Player physics
- [x] Player/world collisions
- [x] game states and menu
- [ ] map screen
- [x] chunk generation
- [ ] chunk saving - universe saving
- [ ] chunk loading
- [ ] universe loading
- [ ] planetoid loading
- [ ] orbit mode
- [ ] ship interior view
- [ ] ship building view
- [ ] ship construction bay view
- [ ] combat system
- [ ] landing on planet
- [ ] gathering resources
- [ ] storage houses 
- [ ] parallax star generation background
- [ ] game stats per game universe
- [ ] saving / loading save

## Notes

### Space types 
* nano
* micro
* terrestrial
* orbit
* solar system
* interstellar
* intergalactic
* void

### Save Directory

- C:/Users/Mike/AppData/Roaming/LOVE/invadors_save_directory

## newest bookmarks

sound effects

- https://love2d.org/wiki/sfxr.lua

Auto Updates

- https://github.com/a327ex/blog/issues/6
- https://love2d.org/forums/viewtopic.php?t=80788
- https://love2d.org/wiki/LoveUpdate

### new bookmarks

https://github.com/love2d-community/awesome-love2d#animation
https://github.com/superzazu/denver.lua - make custom sound effects

### Bookmarks

* shaders - http://blogs.love2d.org/content/beginners-guide-shaders
- https://github.com/vrld/shine/wiki

https://love2d.org/wiki/Sublime_Text -- set up build system
https://github.com/vrld/SUIT -- GUI widgets

* tile maps - http://lua.space/gamedev/using-tiled-maps-in-love
- https://www.youtube.com/watch?v=e6K4jjDczSg

* cameras - http://nova-fusion.com/2011/05/09/cameras-in-love2d-part-3-movement-bounds/
- https://love2d.org/forums/viewtopic.php?t=9281
* parallax - https://github.com/davisdude/Brady
- https://love2d.org/forums/viewtopic.php?f=5&t=79953&view=unread&sid=1a59a18525f7377feb66e5709c39707b#p182305

* resolution handling - https://github.com/Ulydev/push

* animation - https://github.com/kikito/anim8

* collisions - http://hc.readthedocs.io/en/latest/

* Math -
- http://gamedev.stackexchange.com/questions/106258/how-does-orbital-math-work

* music - https://love2d.org/forums/viewtopic.php?t=2053

* game states - https://www.reddit.com/r/love2d/comments/2893c2/game_states/
- http://hump.readthedocs.io/en/latest/gamestate.html
- https://www.youtube.com/watch?v=L_OrFXyorwI&index=16&list=PL924F20B05A624D91

* 3d - https://github.com/excessive/love3d-demos
- https://github.com/excessive/love3d

* libraries -- https://love2d.org/wiki/Category:Libraries
* demos - https://love2d.org/forums/viewtopic.php?t=82472&start=30

* misc
- https://github.com/aranasaurus/experiment-love2d -- some guys ship game
- https://developer.coronalabs.com/user/login?destination=downloads/coronasdk/ -- cross platform lua app sdk
- https://coronalabs.com/corona-sdk/


* love version management - https://gist.github.com/airstruck/5bfb4b33e9c4042223e7

* Lua libs - https://github.com/luafun/luafun

## Misc

Lua game engine comparisons
http://www.gamefromscratch.com/post/2012/09/21/Battle-of-the-Lua-Game-Engines-Corona-vs-Gideros-vs-Love-vs-Moai.aspx

Love game maker
https://github.com/LOVE2D-Game-Maker/love2d-game-maker
https://github.com/LOVE2D-Game-Maker/Project-Unique

boilerplate
https://github.com/dschneider/love-boilerplate

### stack overflow questions to improve
* http://stackoverflow.com/questions/34467628/l%C3%96ve-viewport-like-libgdx
* http://stackoverflow.com/questions/34659850/mandelbrot-set-through-shaders-in-glsl-with-love2d-renders-a-circle-not-a-fract

* love irc - https://webchat.oftc.net/?channels=love

#### easter eggs
Aconitin from the irc
easter bunny credits - Aaron Trostle
some other damn thang from tutorials
paying homage to other games or something

# Scratch

  -- DEBUG
  print("DEBUG")



  -- -- move up/downward with a key
  -- if love.keyboard.isDown('down') then
  --   dy = speed * dt
  -- elseif love.keyboard.isDown('up') then
  --   dy = -speed * dt
  -- end
