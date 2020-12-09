-- Middleclass Root Game class with Stateful state machine
Game = Class('Game'):include(Stateful)

-- are these doing anything?
renderer = Renderer:create()
gameloop = GameLoop:create()

-- loads states that are a folder instead of a file
function loadState(name)
  local path = "states/" .. name
  require(path .. '/main')
  load(name)
end
function load(name) end

function Game:initialize()
  self:gotoState('Splash')
  -- make the generate state (nuber 6) available in the game object
  loadState('generate')
end

function Game:update(dt) end
-- something not right here, stuttering, need fix https://gafferongames.com/post/fix_your_timestep/
function Game:draw(dt)
  -- renderer:draw() -- why isn't this happening?
end

function Game:keypressed(key, code) end
function Game:mousepressed(x, y, button, istouch) end
function Game:mousereleased(x, y, button) end

