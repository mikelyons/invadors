-- Inventory

local inventory = Game:addState('inventory')

function inventory:enteredState()
  if DEBUG_LOGGING_ON then
    print("*")
    print(string.format("ENTER inventory STATE - %s \n", os.date()))
    print("*")
  end

  -- require('../../states/prog2/gen')
  -- local ok,res = pcall(require, "../../states/prog2/gen")

  self.width = love.graphics.getWidth()
  self.height= love.graphics.getHeight()

  self.panex = camera.pos.x + self.width/4
  self.paney = camera.pos.y + self.height/4

  -- self.panexx = (self.width/4)*3
  -- self.paneyy = (self.height/4)*3
  self.panew = self.width/2
  self.paneh = self.height/2

  -- print(panex, paney, panew, paneh)

  -- print(res)
  -- createBox = require "tools/createbox"

  -- r1 = createBox:create(64,64)
  -- r2 = createBox:create(96,96)
  -- r3 = createBox:create(164,164)
  -- r4 = createBox:create(196,196)
  -- r1 = createBox:createRandom()
  -- r2 = createBox:createRandom()
  -- r3 = createBox:createRandom()
  -- r4 = createBox:createRandom()

  -- r1:load()
  -- r2:load()
  -- r3:load()
  -- r4:load()

  self.inventory = {}
  table.insert(self.inventory, "raint")
  -- PrintTable(self.inventory)

end

function inventory:exitedState()
  print("*")
  print(string.format("==EXIT inventory STATE - %s \n", os.date()))
  print("*")
end
function inventory:update(dt)
  local currentWidth = love.graphics.getWidth()

  if (self.width ~= currentWidth) then
    self.width = currentWidth
    print(self.width)
  end
end
function inventory:draw()
  -- table.insert(self.inventory, "raint")
  -- inventory pane dimensions calculation
  local panex = camera.pos.x + self.width/4
  local paney = camera.pos.y + self.height/4

  panex = panex * camera.scale.x
  paney = paney * camera.scale.y

  local panew = self.panew
  local paneh = self.paneh

  panew = panew * camera.scale.x
  paneh = paneh * camera.scale.y

  -- print(panex, paney, panew, paneh)

  -- love.graphics.print(text,x,y,r,sx,sy,ox,oy)
  -- love.graphics.print(panex,panex-40,paney,0,1,1,0,0)
  -- love.graphics.print(panex,panex-25,paney,0,1,1,0,0)
  -- love.graphics.print(paney,panexx,paneyy,0,1,1,0,0)

  -- love.graphics.rectangle(mode,x,y,width,height)
  love.graphics.setColor(55,100,100,255)
  love.graphics.rectangle('fill', panex-25, paney-25, panew+50, paneh+50, 32, 32)
  love.graphics.setColor(55,55,55,255)
  love.graphics.rectangle('fill', panex, paney, panew, paneh, 10, 10, 2)
  love.graphics.setColor(5,1,1,255)
  -- love.graphics.rectangle('fill', panex, paney, panew, paneh)
  -- print("draw")
  -- local getN = 0
  -- for n in pairs(tbl) do 
  --   getN = getN + 1 
  -- end

  -- make a color helper out of this
  local _r, _g, _b, _a = love.graphics.getColor()
  love.graphics.setColor(25,25,25,255)
  for i=0, 9 do
  -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.rectangle('fill', panex, paney, panew, paneh)
    -- love.graphics.rectangle('fill', (i*10)-10, 10, 20, 20)
    love.graphics.rectangle('fill',
      panex + (10 + (i * 70)),
      paney + (10),
      64,
      64
    )
  end
  love.graphics.setColor(_r, _g, _b, _a)

end

-- does this work?
function calculateInventoryDimensions(self) 
  id = {}
  -- inventory pane dimensions calculation
  id.panex = self.width/4
  is.paney = self.height/4
  is.panexx = (self.width/4)*3
  is.paneyy = (self.height/4)*3
  is.panew = (self.width/4)*2
  is.paneh = (self.height/4)*2
  print(panex, paney, panew, paneh)
  return id
end

function drawInventoryChrome() 
  -- love.graphics.reset()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setColor(255,0,0,255)
  love.graphics.rectangle('fill', 100, 100, 100, 100)
  
end

function inventory:keypressed(key, code)
  if key == 'escape' then self:pushState('Pause') end
  -- if key == 'escape' then self:popState('prog') end
  if key == ('e') then self:popState('inventory') end
  if key == ('q') then love.event.push('quit') end
end
