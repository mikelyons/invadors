--[[
  template.lua

  a template for adding a new gamestate
]]

print('asciiGame.lua -> ')
print('ascii -> ')

-- dependencies

local Ascii = Game:addState('asciiGame') -- registering the gamestate
-- input
function Ascii:mousepressed(x,y, button , istouch) end
function Ascii:mousereleased(x, y, button) end

function Ascii:enteredState()
  if DEBUG_LOGGING_ON then print(string.format("ENTER template STATE - %s \n", os.date())) end
  Ascii.playerx = 0
  Ascii.playery = 400
end

function Ascii:exitedState() love.graphics.clear() end

function Ascii:update(dt) end

function Ascii:draw()
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
  love.graphics.rectangle("fill",Ascii.playerx,Ascii.playery, 80,50)
  love.graphics.setColor(255, 5, 5, 255)
  love.graphics.print("(._.)p", Ascii.playerx, Ascii.playery)

  love.graphics.setColor(44, 44, 44, 255)
  love.graphics.rectangle("fill",0,0, 500,100)
  love.graphics.setColor(244, 144, 244, 255)
  love.graphics.print("Player x:"..Ascii.playerx.." y: "..Ascii.playery, 0, 0)
  -- love.graphics.print("resolution x:"..screenWidth.." y: "..screenHeight, 32, 0)
  love.graphics.print("resolution x:"..screen_width.." y: "..screen_height, 0, 32)

  love.graphics.setColor(_r, _g, _b, _a)
end

-- input
function Ascii:mousepressed(x,y, button , istouch) end
function Ascii:mousereleased(x, y, button) end
function Ascii:keypressed(key, code)
  if key == ('w') then Ascii.playery = Ascii.playery - 32 end
  if key == ('a') then Ascii.playerx = Ascii.playerx - 32 end
  if key == ('s') then Ascii.playery = Ascii.playery + 32 end
  if key == ('d') then Ascii.playerx = Ascii.playerx + 32 end

  -- if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then self:popState('asciiGame') end
end