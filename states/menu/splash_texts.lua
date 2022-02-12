
require('helpers/font_helpers')
require 'states/menu/splash_texts_library'

local SplashText = {}

function SplashText:new()
  math.randomseed(os.time())
  local rand1 = math.random(#splashWords)
  local rand2 = math.random(#splashColors)
  local word = splashWords[rand1] 
  local dur = 0.5
  local sp = {x=400, y=300, sc=1, text = 'This will be ' .. word .. '!'}
  local complete = false
  local splashTextTween = tween.new(dur, sp, {sc=1.2}, 'linear')

  local font = love.graphics.newImageFont("assets/newer/Imagefont.png",
      " abcdefghijklmnopqrstuvwxyz" ..
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
      "123456789.,!?-+/():;%&`'*#=[]\"")

  local splashColor = splashColors[rand2] 

  local splashText = {}

  function splashText:load()
    print("")
    print("Splash Text reads:")
    print(sp.text)
    print("")
    print("")
  end
  function splashText:update(dt)
    -- splashtext tween
    if complete == true then
      complete = false
      local scale = sp.sc
      if sp.sc == 1.2 then 
        scale =  1 
        easetype = 'inQuad'
      end
      if sp.sc == 1   then 
        scale = 1.2 
        easetype = 'outQuad'
      end
      -- https://github.com/kikito/tween.lua
      --(duration, subject, target, [easing])
      -- print(tostring(sp.x .. sp.y .. sp.sc .. sp.text))
      splashTextTween = tween.new(dur, sp, {sc=scale}, easetype)
    end
    complete = splashTextTween:update(dt)
  end

  function splashText:getText()
    return sp.text
  end

  function splashText:draw()
    -- font = the font object you made before
    -- local prevFont = love.graphics.getFont()
    -- local prevColor= {love.graphics.getColor()}

    love.graphics.setFont(font)
    love.graphics.setColor(splashColor)
    love.graphics.print(sp.text,sp.x,sp.y,-.3,sp.sc,sp.sc,50,50,0,0)

    -- love.graphics.setFont(prevFont)
    -- love.graphics.setColor(prevColor)
  end

  return splashText
end

return SplashText
