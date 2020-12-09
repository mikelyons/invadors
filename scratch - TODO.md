### Scratch
Renderlayers: Top to Bottom
Game
draw: score
Renderer
5: menu
4:
3: player, zombie
2: earth2/main
1: tlm




---
for formatting tips in this document: https://guides.github.com/features/mastering-markdown/

or: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

## scratch - TODO

- [ ] Player controls
- [ ] Player physics
- [ ] Player/world collisions
- [x] set up game states and menu
- [ ] create map screen
- [ ] chunk generation
- [ ] chunk saving - universe saving
- [ ] create chunk loading
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
- [ ] star generation background
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




## new bookmarks

https://github.com/love2d-community/awesome-love2d#animation

https://github.com/superzazu/denver.lua - make custom sound effects

## Bookmarks

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
