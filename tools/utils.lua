-- gathering and namespacing all my utility functions

-- what is this? find the length of the table?
function Tlength(tbl)
  local getN = 0
  for n in pairs(tbl) do 
    getN = getN + 1 
  end
  return getN
end

local getN = 0
for n in pairs(tm) do 
  getN = getN + 1 
end