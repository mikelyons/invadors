--[[
-- 
--  logging_helpers.lua
-- 
--  Helper functions for printing to the game debug log / console
-- -- handles colors, format, spacing, variables, time and date
--  

]]

-- local codes = {
--   reset = "\x1B[m",
--   red = "\x1B[31m",
--   green = "\x1B[32m", --[[ rest left as exercise :P ]]}

-- function printC(colour, ...)
--   if not codes[colour] then error("Undefined colour: " .. colour) end
--   io.write(codes[colour])
--   print(...)
--   io.write(codes.reset)
-- end



local reset = "\x1B[m\x1B[K" -- adds clear-to-EOL code
local fgs = {red = "\x1B[31m", green = "\x1B[32m", --[[ rest left as exercise :P ]]}
local bgs = {red = "\x1B[41m", green = "\x1B[42m", --[[ rest left as exercise :P ]]}
function printC(fg,bg, ...)
  if fg then
    if not fgs[fg] then error("Undefined colour: " .. fg) end
    io.write(fgs[fg])
  end
  if bg then
    if not bgs[bg] then error("Undefined colour: " .. bg) end
    io.write(bgs[bg])
  end
  print(...)
  if fg or bg then
    io.write(reset)
  end
end

printC("red", "green", "This text is red on green", "This one too")
print("This is normal")
printC(false, false, "This is normal too")
printC("red", false, "This is red text")

printC("red", "This text is red", "This one too")
print("This is normal")
printC("reset", "This is normal too")
printC(false, "green", "This is normal text on green")