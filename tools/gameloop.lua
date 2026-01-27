local Gameloop = {}

local insert = table.insert
local remove = table.remove

function Gameloop:create()
  local gameloop = {}

  gameloop.tickers = {}

  function gameloop:addLoop( obj )
    insert(self.tickers, obj)
  end

  function gameloop:update(dt)
    for i = 1, #self.tickers do
      local obj = self.tickers[i]
      if obj ~= nil then
        obj:tick(dt)
      end
    end
  end

  return gameloop 
end

return Gameloop 

