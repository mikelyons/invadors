-- first pass proc gen map 
-- using sti for the map loading
-- (Simple Tiled Implementation)
local sti = require("../../lib/sti")
local gamera = require("../../lib/gamera")
-- local ok,res = pcall(require, "../../lib/gamera")
-- print(res)
-- local gamera = res --require("gamera")

local prog = Game:addState('prog2')

function prog:enteredState()
  if DEBUG_LOGGING_ON then
    print("")
    print(string.format("ENTER prog2 STATE - %s \n", os.date()))
    print("")
  end

  -- heheh
  -- print(love.window.getTitle())
  -- print(love.graphics.getWidth())
  -- print(love.graphics.getHeight())

  require('../../states/prog2/gen')
  -- local ok,res = pcall(require, "../../states/prog2/gen")

  -- print(res)

  -- local tileMap = sti(map)
  -- local w, h = tileMap.tilewidth * tileMap.width, tileMap.tileheight * tileMap.height
  -- local camera = gamera.new(0, 0, w, h)

end

function prog:exitedState()
  camera:goToPoint({x=0,y=0})
  self:pushState('menu')
end
function prog:update(dt) end
function prog:draw(dt)

  -- print("draw")

  -- camera:draw(function(l, t, w, h)
  --   tileMap:update(dt)
  --   tileMap:setDrawRange(-l, -t, w, h)
  --   tileMap:draw()
  -- end)

end

function prog:keypressed(key, code)
  -- if key == 'escape' then self:pushState('Pause') end
  -- if key == 'escape' then self:pushState('Pause') end
  print("KEY: "..key)
  if key == ('escape') then self:popState('prog2') end
  if key == ('r') then self:popState('prog2') end
  if key == ('e') then self:pushState('inventory') end
  if key == ('q') then love.event.push('quit') end
end
