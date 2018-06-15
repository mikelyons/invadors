local Player = {}

function Player:new()
  -- Entity:new(x,y,w,h,img,quad,id) -- this line should be commented out
  -- local player = require('objects/entity'):new()

  -- return player

  local player = require('objects/entity'):new(x,y,32,32,nil,nil,"player")

  function player:load()
    gameloop:addLoop(self)
    renderer:addRenderer(self)
  end
  function player:tick(dt) end
  function player:draw()
    love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
  end

  return player
end

return Player








--

-- local class = require './lib.middleclass.middleclass'

-- Player = class('player')

-- function Player:initialize()
--   player = {}
--   player.x = (love.graphics.getWidth() / 2)
--   player.y = (love.graphics.getHeight() / 2)
--   player.speed = 20

--   player.image = love.graphics.newImage('/assets/ufo2.png')
--   player.image:setFilter('nearest', 'nearest', 1)
-- end

-- function Player:update(dt)
  
-- end


