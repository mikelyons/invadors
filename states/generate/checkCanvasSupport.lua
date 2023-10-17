
  -- is canvas available?
  local canvas = love.graphics.getSupported()
  for k, v in pairs(canvas) do
    print("IS CANVAS SUPPORTED?")
    print(k, v)
  end
