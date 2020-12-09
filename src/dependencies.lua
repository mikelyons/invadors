
-- Engine Initialize
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

-- main game launchpoint
require 'game'

-- serializer libarary
ser = require 'lib/binser/binser'

-- Tools
asm    = require 'tools/asm' -- asset manager
camera = require 'tools/camera'

-- require the gamestates
require 'states/splash' -- vetted, passes to menu

require 'states/menu/menu' -- can select any mode below - landing on quit

-- requiring these is not necessary if they are required via loadstate in root game.lua
-- require 'states/pause'
-- require 'states/bizzaro'
-- require 'states/Training'
-- require 'states/space1'
-- require 'states/generate'

