
Module = {}

function Module:class_method( ... )
  -- use this anywhere
end

-- create an instance
function Module:new( ... )
  local module = {}
  function module:load( ... )
    -- body
  end
  return module
end

return Module
