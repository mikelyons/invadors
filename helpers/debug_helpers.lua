
--[[
  debug_helpers.lua

  DEBUG HELPERS

  Functions that read and instrospect game data and objects
  for the purposes of easy debugging
]]

-- this doesn't seem to work
function dump(t, indent, done)
    done = done or {}
    indent = indent or 0

    done[t] = true

    for key, value in pairs(t) do
        print(string.rep("\t", indent))

        if (type(value) == "table" and not done[value]) then
            done[value] = true
            print(key, ":\n")

            PrintTable(value, indent + 2, done)
            done[value] = nil
        else
            print(key, "\t=\t", value, "\n")
        end
    end
end

--Need a pcall that will take a table of parameters

-- A helper function to print the line number and other information about the printable parameter
function PrintDebug(f) --, args)
  print("")
  print("=========================================================")
  print("              start PRINT DEBUG start")
  print("=========================================================")
  print("===")

  -- print("=== Arguments: "..type(args))
  -- print("=== Type of F: "..type(f))
  if type(f) == 'string' then
    print("=== String: "..f)
    print("=== ")
  end
  if type(f) == 'table' then
    print("=== Table: ", f)
    print("=== ")
  end
  if type(f) ~= ('string') then
    print("=== unknown: ",type(f))
    print("=== ")
  end

  -- this isn't getting the correct place
  -- gets this file instead of the callsite
  -- local i = debug.getinfo(1)
  -- print("=== Current File: "..i.source)
  -- print("=== Current Line: "..i.currentline)
  -- print("=== The Variable: "..f)

  -- print("=== The variable: "..f)
  
  -- if type(f) == 'function' then
  --   -- print('=== FUCKIN function')
  --   -- print('=== '..args)
  --   -- print('==='..f(args)..' raint')
  -- end

  -- if type(f) == 'function' then
  --   print("=== Function call results: "..f(args))
  --   print("=== "..f(args).."                                   ===")
  -- end

    -- print("=== Function call results: "..f(args))
    -- print("=== "..f(args).."                                   ===")
  -- local ok,res = pcall(function(f)
  -- pcall(pcall(function(f)
  --   -- print("=== "..f)
  --   -- print(args)
  --   -- PrintTable(debug.getinfo(1))
  --   -- PrintDebug()
  -- end))
  -- print(pcall(pcall(f)))
  -- print(pcall(''))
  -- print(pcall(f))
  -- print("=== RESULT OF PCALL.OK?: "..ok)
  -- print("=== "..res)
  -- print("=== "..f)
  -- print("===")
  print("===")
  print("=========================================================")
  print("                end  PRINT DEBUG end")
  print("=========================================================")
  print("")
  -- print(debug.getinfo)
  -- PrintTable(debug.getinfo(1))
  -- i = debug.getinfo(1)
  -- print(i['source']..':'..i['currentline'])
end

---A helper function to print a table's contents.
---@param tbl table @The table to print.
---@param depth number @The depth of sub-tables to traverse through and print.
---@param n number @Do NOT manually set this. This controls formatting through recursion.
function PrintTable(tbl, depth, n)
  n = n or 0;
  depth = depth or 5;

  if (depth == 0) then
      print(string.rep(' ', n).."...");
      return;
  end

  if (n == 0) then
      print(" ");
  end

  for key, value in pairs(tbl) do
      if (key and type(key) == "number" or type(key) == "string") then
          key = string.format("[\"%s\"]", key);

          if (type(value) == "table") then
              if (next(value)) then
                  print(string.rep(' ', n)..key.." = {");
                  PrintTable(value, depth - 1, n + 4);
                  print(string.rep(' ', n).."},");
              else
                  print(string.rep(' ', n)..key.." = {},");
              end
          else
              if (type(value) == "string") then
                  value = string.format("\"%s\"", value);
              else
                  value = tostring(value);
              end

              print(string.rep(' ', n)..key.." = "..value..",");
          end
      end
  end

  if (n == 0) then
      print(" ");
  end
end

-- this only works if you run the game with RUN.BAT
function PrintColor(p, colorName)
  local n = colorName
  local pc = {
    ['red'] = ''
  }
    -- print('\27[31mRed!')
    -- print('\27[32mGreen!')
    -- print('\27[33mYello!')
    -- print('\27[34mBlue!')
    -- print('\27[35mMagenta!')
    -- print('\27[36mCyan!')
    -- print('\27[37mWhite!')

    -- print('\27[0mReset!')
    -- print('\27[mReset!')
    -- print("")

    print(
      '\27[31m'..p..'! - ' .. 
      'red' ..
      '\27[31mRed!' .. 
      ''
    )
    -- print('\27[32mGreen!')
    -- print('\27[33mYello!')
    -- print('\27[34mBlue!')
    -- print('\27[35mMagenta!')
    -- print('\27[36mCyan!')
    -- print('\27[37mWhite!')

    -- print('\27[0mReset!')
    -- print('\27[mReset!')
    -- print("")
  
end
