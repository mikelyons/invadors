
--[[
  font_helpers.lua

  Do all the fonts dirty work for them
  - Load some fonts
  - https://love2d.org/wiki/Font
  - https://love2d.org/wiki/love.graphics.getFont
  - https://love2d.org/wiki/FontForge
  - https://love2d.org/wiki/Tutorial:Fonts_and_Text

  - https://github.com/gvx/richtext
]]

__fonts = {}

-- https://dev.to/buntine/dim-jump-lve-and-lua
function withColour(r, g, b, a, f)
  local _r, _g, _b, _a = love.graphics.getColor()

  love.graphics.setColor(r, g, b, a)
  f()
  love.graphics.setColor(_r, _g, _b, _a)
end

function withFont(name, f)
  if __fonts[name] == nil then
    return false
  end
  local _f = love.graphics.getFont()

  love.graphics.setFont(__fonts[name])
  f()
  love.graphics.setFont(_f)
end

  -- font = love.graphics.newFont("AwesomeFont.ttf", 15)
local font = love.graphics.newImageFont("assets/newer/Imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")


-- local font = love.graphics.newImageFont("assets/outlinefont.png",
-- " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")

-- a font for tiny occasions
-- local font = love.graphics.newImageFont("assets/tinyfont.png",
-- " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-=[]\\,./;')!@#$%^&*(+{}!<>?:\"")


-- local lg = love.graphics
-- local defaultfont = lg.getFont()
-- local fontsize = 80
-- local targetscale = .28
-- assert(targetscale >= 0.25 and targetscale < 0.5)
-- local font1 = lg.newFont(fontsize)
-- local font2 = lg.newFont(fontsize*0.5)
-- local font3 = lg.newFont(fontsize*targetscale)


-- local function testfont(font, scale, text, title, position)
--   lg.origin()
--   lg.setFont(defaultfont)
--   lg.print(title, 0, position)
--   lg.setFont(font)
--   lg.scale(scale)
--   lg.print(text, 0, (position + 20) / scale)
-- end


-- function love.draw()
--   local text = "The quick brown fox jumps over the lazy dog"
--   testfont(font1, .28, text, "Scaled to under 50%", 100)
--   testfont(font2, .56, text, "Scaled to 50% or more", 200)
--   testfont(font3, 1, text, "No scale", 0)
-- end
