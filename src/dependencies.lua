
-- Development dependencies enabled by environment @TODO
require 'src/devDependencies'

-- Engine Initialize
require 'colors'
require 'src/constants'
require 'src/logging'


-- Libraries
-- based on http://aalvarez.me/blog/posts/an-introduction-to-game-states-in-love2d.html
Class    = require 'lib/middleclass/middleclass'
Stateful = require 'lib/stateful/stateful'

Score    = require 'highscore'
-- The Main Game Launch Point

-- BASED ON: https://www.youtube.com/watch?v=UFE94uJodVs&list=PLKpDO_ZkjZ7TBYWcV2n632Z6iRJJlX2oM&index=2
Renderer = require "tools/renderer"
GameLoop = require "tools/gameloop"


-- serializer libarary
-- ser = require 'lib/binser/binser'

-- Tools
asm    = require 'tools/asm' -- asset manager
tlm    = require 'tiles/tlm' -- tile manager 
obm    = require 'tools/obm' -- object manager
camera = require 'tools/camera'

-- main game launchpoint
require 'game'

-- require the gamestates
-- require 'states/splash' -- vetted, passes to menu


-- require 'states/menu/main' -- can select any mode below - landing on quit

-- required because not loaded from menu currently for dev
-- require 'states/synth'
-- requiring these is not necessary if they are required via loadstate in root game.lua
-- require 'states/pause'
-- require 'states/bizzaro'
-- require 'states/Training'
-- require 'states/space1'
-- require 'states/generate/generate'

