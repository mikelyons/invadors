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
    for tickers = 0, #self.tickers do
      local obj = self.tickers[tickers]
      if obj ~= nil then
        obj:tick(dt)
      end
    end
  end

  return gameloop 
end

return Gameloop 

