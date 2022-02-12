-- https://github.com/Jeepzor/Platformer-tutorial/blob/main/Episode%206/coin.lua
-- // from: https://www.youtube.com/watch?v=fKuWvf7nwtA

Coin = {}
Coin.__index = Coin
ActiveCoins = {}

function Coin.new(x, y)
  local instance = setmetatable({}, Coin)
  instance.x = y
  instance.y = y
  -- instance.img = love.graphics.newImage("assets/items/beergreenbottle.png")
  -- bool, data = pcall(love.graphics.newImage("assets/items/beergreenbottle.png"))
  -- print(bool)
  -- print(data)
  instance.img = love.graphics.newImage("assets/char.png")
  -- instance.width  = instance.img.getWidth() or 16
  -- instance.height = instance.img.getHeight() or 16

  instance.width  = 16
  instance.height = 16
  instance.scaleX = 1
  -- instance.scaleY = 

  instance.randomTimeOffset = math.random(0, 1000)

  instance.physics = {}
  -- instance.physics.body = love.physics.newBody()


  table.insert(ActiveCoins, instance)

  -- return instance
  -- insert into activecoins instead of returning
end

function Coin:spin()
  self.scaleX = math.sin(love.timer.getTime() * 5 + self.randomTimeOffset)

end

function Coin:update(dt)
  self:spin(dt)
end

function Coin:updateAll(dt)
  for i,instance in ipairs(ActiveCoins) do
    instance:update(dt)
  end
end

function Coin:draw() 
  local r, g, b, a = love.graphics.getColor()
  -- love.graphics.draw(self.img,self.x,self.y,0,1,1,self.with/2,self.heigh/2)
  -- love.graphics.rectangle('fill', instan
  -- love.graphics.draw(
  -- ,self.x,self.y,0,1,1,self.with/2,self.heigh/2)
  -- love.graphics.setColor(240, 224, 96, 255)
  love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(self.img,self.x,self.y,0,self.scaleX,1,self.width/2,self.height/2)
  love.graphics.setColor(r, g, b, a)
end


function Coin:drawAll()
  for i,instance in ipairs(ActiveCoins) do
    instance:draw()
  end
end