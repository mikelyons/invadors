
--[[
  game.lua

  The main game loop initializer this is loaded by the 
  main bootstrap file main.lua
]]

-- networking tutorial with enet (which is installed)
-- https://rvagamejams.com/learn2love/pages/02-18-networking-part-2.html
-- https://www.reddit.com/r/love2d/comments/r3qg1k/luasocket_vs_luaenet/hmf4xk2/
-- are these doing anything?
renderer = Renderer:create()
gameloop = GameLoop:create()
require 'helpers/loading_helpers'

-- should we add this?
-- https://githubhelp.com/xkotori/love2d-console
--and this
-- https://github.com/SiENcE/astray
--https://github.com/mxgmn/WaveFunctionCollapse


-- Middleclass Root Game class with Stateful state machine
Game = Class('Game'):include(Stateful)
function Game:new() end

function Game:initialize()
  print('Game init')
  -- this only works if launched through run.BAT
  -- https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
  PrintColor('raint', 'red')

    -- try to get multithreading working
    loadStateFile( 'mts')
    loadStateFile( 'orbital')
    -- self:gotoState('mts')


  loadStateFile  ('pause')
  -- Various mini-games 
  loadStateFolder('synth')
  loadStateFolder('prog2')
  loadStateFolder('generate')
  loadStateFolder('dialogue')
  loadStateFolder('computer')
  loadStateFile  ('bizzaro')
  loadStateFolder('prog2')
  loadStateFolder('shop')
  loadStateFile('pro')

  -- ingame UIs
  loadStateFolder('inventory')

  -- menu states
  loadStateFolder('menu')
  loadMenuStateFile('newGame')
  loadStateFile  ('createWorld')
  loadMenuStateFile('loadSave')
  loadMenuStateFile('signin')
  loadStateFolder('editor')
  -- loadStateFolder('template')
  -- self:gotoState('template')
  loadMenuStateFile('pressStart')
  self:gotoState('PressStart')
  -- self:gotoState('menu')
end

function Game:update(dt) end
function Game:keypressed(key, code) end
function Game:mousepressed(x, y, button, istouch) end
function Game:mousereleased(x, y, button) end
-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
function Game:draw(dt)
  -- does this do anything? maybe in generate state?
  -- nothing for Menu
  -- renderer:draw() -- why isn't this happening?
end

