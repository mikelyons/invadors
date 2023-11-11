--[[
  template.lua

  a template for adding a new gamestate
]]

print('template.lua -> ')
print('template -> ')

-- dependencies

local Signin = Game:addState('asciiGame') -- registering the gamestate
-- input
function Signin:mousepressed(x,y, button , istouch) end
function Signin:mousereleased(x, y, button) end
function Signin:keypressed(key, code)

  if key == ('escape') then love.event.push('quit') end
end
function Signin:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER template STATE - %s \n", os.date())) end
  Signin.playerx = 0
  Signin.playery = 400
end
function Signin:exitedState() love.graphics.clear() end

function Signin:update(dt) end

function Signin:draw()
  local _r, _g, _b, _a = love.graphics.getColor()
  -- love.graphics.setColor(0, 255, 255, 255)

  love.graphics.setColor(25, 155, 25, 255)
  love.graphics.print([[
--    `,.      .   .        *   .    .      .  _    ..          .
--      \,~-.         *           .    .       ))       *    .
--           \ *          .   .   |    *  . .  ~    .      .  .  ,
--  ,           `-.  .            :               *           ,-
--   -             `-.        *._/_\_.       .       .   ,-'
--   -                 `-_.,     |n|     .      .       ;
--     -                    \ ._/_,_\_.  .          . ,'         ,
--      -                    `-.|.n.|      .   ,-.__,'         -
--       -                   ._/_,_,_\_.    ,-'              -
--       -                     |..n..|-`'-'                -
--        -                 ._/_,_,_,_\_.                 -
--          -               ,-|...n...|                  -
--            -         ,-'._/_,_,_,_,_\_.              -
--              -  ,-=-'     |....n....|              -
--               -;       ._/_,_,_,_,_,_\_.         -
--              ,-          |.....n.....|          -
--            ,;         ._/_,_,_,_,_,_,_\_.         -
--   `,  '.  `.  ".  `,  '.| n   ,-.   n |  ",  `.  `,  '.  `,  ',
-- ,.:;..;;..;;.,:;,.;:,o__|__o !.|.! o__|__o;,.:;.,;;,,:;,.:;,;;:
--  ][  ][  ][  ][  ][  |_i_i_H_|_|_|_H_i_i_|  ][  ][  ][  ][  ][
--                      |     //=====\\     |
--                      |____//=======\\____|
--                          //=========\\
  ]], 0, 0)

  love.graphics.setColor(5, 5, 5, 200)
  love.graphics.rectangle("fill",Signin.playerx,Signin.playery, 80,50)
  love.graphics.setColor(255, 5, 5, 255)
  love.graphics.print("(._.)p", Signin.playerx, Signin.playery)

  love.graphics.setColor(44, 44, 44, 255)
  love.graphics.rectangle("fill",0,0, 500,100)
  love.graphics.setColor(244, 144, 244, 255)
  love.graphics.print("Player x:"..Signin.playerx.." y: "..Signin.playery, 0, 0)
  -- love.graphics.print("resolution x:"..screenWidth.." y: "..screenHeight, 32, 0)
  love.graphics.print("resolution x:"..screen_width.." y: "..screen_height, 0, 32)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Signin:mousepressed(x,y, button , istouch) end
function Signin:mousereleased(x, y, button) end
function Signin:keypressed(key, code)
  if key == ('w') then Signin.playery = Signin.playery - 32 end
  if key == ('a') then Signin.playerx = Signin.playerx - 32 end
  if key == ('s') then Signin.playery = Signin.playery + 32 end
  if key == ('d') then Signin.playerx = Signin.playerx + 32 end

  if key == ('escape') then love.event.push('quit') end
end